package budgetquest.service;

import budgetquest.controller.ImportProgressController;
import budgetquest.utils.DbConnection;
import com.opencsv.exceptions.CsvValidationException;
import javafx.concurrent.Task;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.FileChooser;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.Window;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.*;
import java.sql.*;
import java.time.LocalDate;
import java.util.List;

import com.opencsv.CSVReader;
import com.opencsv.CSVParserBuilder;
import com.opencsv.CSVReaderBuilder;

public class CsvTransactionImporter {

    private static final Logger logger = LogManager.getLogger(CsvTransactionImporter.class);
    private final int userId;

    public CsvTransactionImporter(int userId) {
        this.userId = userId;
    }

    public void importFromFileChooser(Window parentWindow) {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Import Transactions CSV");
        fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("CSV Files", "*.csv"));
        File file = fileChooser.showOpenDialog(parentWindow);

        if (file != null) {
            try {
                // Load dialog
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/import_progress_dialogue.fxml"));
                Parent root = loader.load();
                ImportProgressController controller = loader.getController();

                Stage dialogStage = new Stage();
                dialogStage.initModality(Modality.APPLICATION_MODAL);
                dialogStage.setResizable(false);
                dialogStage.setTitle("Importing...");
                dialogStage.setScene(new Scene(root));

                // Start background task
                Task<Void> importTask = createImportTask(file, controller);
                controller.bindProgress(importTask, countLines(file));

                importTask.setOnSucceeded(e -> dialogStage.close());
                importTask.setOnFailed(e -> {
                    logger.error("Import failed", importTask.getException());
                    dialogStage.close();
                });

                new Thread(importTask).start();
                dialogStage.showAndWait(); // blocks UI

            } catch (Exception e) {
                logger.error("Error showing progress dialog", e);
            }
        }
    }
    private int countLines(File file) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            return (int) reader.lines().count() - 1; // exclude header
        }
    }


    private Task<Void> createImportTask(File file, ImportProgressController controller) {
        return new Task<>() {
            @Override
            protected Void call() throws Exception {
                try (
                        Reader reader = new FileReader(file);
                        CSVReader csvReader = new CSVReaderBuilder(reader)
                                .withCSVParser(new CSVParserBuilder().withSeparator(',').withQuoteChar('"').build())
                                .build()
                ) {
                    List<String[]> allRows = csvReader.readAll();
                    int total = allRows.size() - 1;
                    int count = 0;

                    for (String[] row : allRows) {
                        if (count == 0) { count++; continue; } // Skip header

                        if (row.length < 8) continue;

                        try {
                            String name = clean(row[1]);
                            String description = clean(row[4]);
                            String categoryName = clean(row[6]);
                            String categoryType = clean(row[7]);
                            LocalDate date = LocalDate.parse(row[2].trim());
                            double amount = Double.parseDouble(row[3].trim());
                            Timestamp createdAt = Timestamp.valueOf(row[5].trim());

                            int categoryId = getOrCreateCategoryId(categoryName, categoryType);
                            insertTransaction(name, date, amount, description, createdAt, categoryId);

                            updateProgress(count, total);
                            updateMessage("Importing transaction: " + name);
                            count++;

                        } catch (Exception e) {
                            logger.error("Error in line: {}", String.join(",", row), e);
                        }
                    }
                }

                return null;
            }
        };
    }


    private void importFromCSV(File file) throws IOException {
        try (
                Reader reader = new FileReader(file);
                CSVReader csvReader = new CSVReaderBuilder(reader)
                        .withCSVParser(
                                new CSVParserBuilder()
                                        .withSeparator(',')
                                        .withQuoteChar('"')
                                        .build()
                        )
                        .build()
        ) {
            String[] values;
            boolean isFirstLine = true;

            while ((values = csvReader.readNext()) != null) {
                if (isFirstLine) {
                    isFirstLine = false;
                    continue; // skip header
                }

                if (values.length < 8) {
                    logger.warn("Skipping line with insufficient columns: {}", String.join(",", values));
                    continue;
                }

                try {
                    String name = values[1].trim();
                    LocalDate date = LocalDate.parse(values[2].trim());
                    double amount = Double.parseDouble(values[3].trim());
                    String description = values[4].trim();

                    String createdAtStr = values[5].trim();
                    Timestamp createdAt = createdAtStr.isEmpty() ? Timestamp.valueOf(LocalDate.now().atStartOfDay()) : Timestamp.valueOf(createdAtStr);

                    String categoryName = values[6].trim();
                    String categoryType = values[7].trim();

                    int categoryId = getOrCreateCategoryId(categoryName, categoryType);
                    insertTransaction(name, date, amount, description, createdAt, categoryId);

                } catch (Exception e) {
                    logger.error("Failed to process CSV line: {}", String.join(",", values), e);
                }
            }
        } catch (CsvValidationException e) {
            throw new RuntimeException(e);
        }

    }

    private String clean(String input) {
        if (input == null) return "";
        input = input.trim();
        if (input.startsWith("\"") && input.endsWith("\"") && input.length() > 1) {
            input = input.substring(1, input.length() - 1); // rimuove virgolette esterne
        }
        return input.replace("\"\"", "\""); // gestisce doppie virgolette escape
    }


    private void insertTransaction(String name, LocalDate date, double amount, String description, Timestamp createdAt, int categoryId) throws SQLException {
        String insertSQL = """
            INSERT INTO transactions (user_id, category_id, name, date, amount, description, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(insertSQL)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, categoryId);
            stmt.setString(3, name);
            stmt.setDate(4, Date.valueOf(date));
            stmt.setDouble(5, amount);
            stmt.setString(6, description);
            stmt.setTimestamp(7, createdAt);
            stmt.executeUpdate();
        }

        logger.info("Inserted transaction: {} on {}", name, date);
    }

    private int getOrCreateCategoryId(String name, String type) throws SQLException {
        String selectSQL = "SELECT id FROM categories WHERE user_id = ? AND name = ? AND type = ?";
        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(selectSQL)) {

            stmt.setInt(1, userId);
            stmt.setString(2, name);
            stmt.setString(3, type);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("id");
            }
        }

        String insertSQL = "INSERT INTO categories (user_id, name, type) VALUES (?, ?, ?) RETURNING id";
        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(insertSQL)) {

            stmt.setInt(1, userId);
            stmt.setString(2, name);
            stmt.setString(3, type);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                logger.info("Created new category: {} ({})", name, type);
                return rs.getInt("id");
            }
        }

        throw new SQLException("Failed to create or retrieve category: " + name);
    }
}
