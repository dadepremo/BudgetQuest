package budgetquest.service;

import budgetquest.utils.DbConnection;
import budgetquest.utils.MyUtils;
import javafx.stage.FileChooser;
import javafx.stage.Window;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

public class CsvTransactionExporter {

    private static final Logger logger = LogManager.getLogger(CsvTransactionExporter.class);

    public void exportWithFileChooser(Window parentWindow, int userId) {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Save Transactions CSV");
        fileChooser.setInitialFileName("transactions" + LocalDate.now() + ".csv");
        fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("CSV Files", "*.csv"));

        File selectedFile = fileChooser.showSaveDialog(parentWindow);
        if (selectedFile != null) {
            try {
                exportTransactionsToCSV(userId, selectedFile.getAbsolutePath());
                MyUtils.showInfo("Export completed", "Export completed to " + selectedFile.getAbsolutePath());
                logger.info("Export completed to {}", selectedFile.getAbsolutePath());
            } catch (Exception e) {
                MyUtils.showError("Export failed", "Failed to export transactions to CSV");
                logger.error("Failed to export transactions to CSV", e);
            }
        }
    }

    public void exportTransactionsToCSV(int userId, String filePath) throws SQLException, IOException {
        String query = """
            SELECT t.id, t.name, t.date, t.amount, t.description, t.created_at,
                   c.name AS category, c.type AS category_type
            FROM transactions t
            LEFT JOIN categories c ON t.category_id = c.id
            WHERE t.user_id = ?
            ORDER BY t.date
        """;

        try (
                Connection connection = DbConnection.connect();
                PreparedStatement stmt = connection.prepareStatement(query);
                FileWriter csvWriter = new FileWriter(filePath)
        ) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            // Header
            csvWriter.append("ID,Name,Date,Amount,Description,Created At,Category,Category Type\n");

            // Rows
            while (rs.next()) {
                csvWriter.append(escape(String.valueOf(rs.getInt("id")))).append(",");
                csvWriter.append(escape(rs.getString("name"))).append(",");
                csvWriter.append(escape(String.valueOf(rs.getDate("date")))).append(",");
                csvWriter.append(escape(rs.getBigDecimal("amount") != null ? rs.getBigDecimal("amount").toPlainString() : "")).append(",");
                csvWriter.append(escape(rs.getString("description"))).append(",");
                csvWriter.append(escape(tsToString(rs.getTimestamp("created_at")))).append(",");
                csvWriter.append(escape(rs.getString("category"))).append(",");
                csvWriter.append(escape(rs.getString("category_type"))).append("\n");
            }
        }
    }

    private String tsToString(Timestamp ts) {
        return ts != null ? ts.toString() : "";
    }

    private String escape(String value) {
        if (value == null) return "";

        String cleaned = value
                .replace("\r", " ")  // CR
                .replace("\n", " ")  // LF

                .replace("\t", " ")
                .replaceAll("\\p{C}", " ");  // Unicode invisible characters

        String escaped = cleaned.replace("\"", "\"\"");

        return "\"" + escaped.trim() + "\"";
    }





}
