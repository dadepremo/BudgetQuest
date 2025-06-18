package budgetquest.controller;

import budgetquest.dao.AssetDao.AssetDao;
import budgetquest.dao.AssetDao.AssetDaoImpl;
import budgetquest.dao.CategoryDao.CategoryDao;
import budgetquest.dao.CategoryDao.CategoryDaoImpl;
import budgetquest.dao.LiabilityDao.LiabilityDao;
import budgetquest.dao.LiabilityDao.LiabilityDaoImpl;
import budgetquest.dao.NetWorthHistoryDao.NetWorthHistoryDao;
import budgetquest.dao.NetWorthHistoryDao.NetWorthHistoryDaoImpl;
import budgetquest.dao.ShopItemDao.ShopItemDao;
import budgetquest.dao.ShopItemDao.ShopItemDaoImpl;
import budgetquest.dao.TransactionDao.TransactionDao;
import budgetquest.dao.TransactionDao.TransactionDaoImpl;
import budgetquest.dao.UserDao.UserDao;
import budgetquest.dao.UserDao.UserDaoImpl;
import javafx.animation.*;
import javafx.application.Platform;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.concurrent.Task;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.XYChart;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.KeyCode;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.FileChooser;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.util.Duration;
import budgetquest.model.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mindrot.jbcrypt.BCrypt;
import budgetquest.service.ExcelTransactionImporter;
import budgetquest.utils.DbConnection;
import budgetquest.utils.MyUtils;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Objects;


// Controller class for the main dashboard screen
public class DashboardController {

    private static final Logger logger = LogManager.getLogger(DashboardController.class);

    // FXML-bound labels for displaying key user and financial metrics
    @FXML private Label assetsLabel;
    @FXML private Label liabilitiesLabel;
    @FXML private Label usernameLabel;
    @FXML private ProgressBar xpBar;
    @FXML private Label xpLabel;
    @FXML private Label dpLabel;
    @FXML private Label levelLabel;
    @FXML private Label networthLabel;
    @FXML private Label expensesLabel;
    @FXML private Label incomesLabel;
    @FXML private Button streakButton;
    @FXML private Button refreshButton;
    @FXML private Button addTransactionButton;

    @FXML private ProgressBar progressBarImportTransactions;
    @FXML private Label statusLabelImportTransactions;
    @FXML private ProgressBar progressBarImportTransactions1;
    @FXML private Label statusLabelImportTransactions1;

    // UI controls and tabs
    @FXML private TabPane tabPane;
    @FXML private Button changeThemeButton;
    @FXML private Button buttonIncomeChart;
    @FXML private Button buttonExpensesChart;
    @FXML private Button buttonIncomeChart1;
    @FXML private Button buttonExpensesChart1;
    @FXML private Label dashboardLabel;

    // Profile settings fields
    @FXML private TextField usernameField;
    @FXML private TextField emailField;
    @FXML private TextField firstNameField;
    @FXML private TextField lastNameField;
    @FXML private ChoiceBox<String> themeChoiceBox;
    @FXML private ChoiceBox<String> currencyChoiceBox;
    @FXML private PasswordField currentPasswordField;
    @FXML private PasswordField newPasswordField;
    @FXML private PasswordField confirmPasswordField;

    // Asset TableView and its columns
    @FXML private TableView<Asset> assetTable;
    @FXML private TableColumn<Asset, String> nameColumn;
    @FXML private TableColumn<Asset, String> typeColumn;
    @FXML private TableColumn<Asset, String> valueColumn;
    @FXML private TableColumn<Asset, LocalDate> acquiredDateColumn;
    @FXML private TableColumn<Asset, String> liquidColumn;
    @FXML private TableColumn<Asset, String> notesColumns;

    // Liability TableView and its columns
    @FXML private TableView<Liability> liabilityTable;
    @FXML private TableColumn<Liability, String> liabilityNameColumn;
    @FXML private TableColumn<Liability, String> liabilityTypeColumn;
    @FXML private TableColumn<Liability, String> amountColumn;
    @FXML private TableColumn<Liability, String> remainingColumn;
    @FXML private TableColumn<Liability, BigDecimal> rateColumn;
    @FXML private TableColumn<Liability, LocalDate> startColumn;
    @FXML private TableColumn<Liability, LocalDate> dueColumn;
    @FXML private TableColumn<Liability, String> activeColumn;
    @FXML private TableColumn<Liability, String> liabilityNotesColumn;

    // Expense TableView and its columns
    @FXML private TableView<Transaction> expenseTable;
    @FXML private TableColumn<Transaction, String> expensesNameColumn;
    @FXML private TableColumn<Transaction, String> expensesDateColumn;
    @FXML private TableColumn<Transaction, String> expensesAmountColumn;
    @FXML private TableColumn<Transaction, String> expensesCategoryColumn;
    @FXML private TableColumn<Transaction, String> expensesDescriptionColumn;

    // Income TableView and its columns
    @FXML private TableView<Transaction> incomeTable;
    @FXML private TableColumn<Transaction, String> incomesNameColumn;
    @FXML private TableColumn<Transaction, String> incomesDateColumn;
    @FXML private TableColumn<Transaction, String> incomesAmountColumn;
    @FXML private TableColumn<Transaction, String> incomesCategoryColumn;
    @FXML private TableColumn<Transaction, String> incomesDescriptionColumn;

    @FXML private TextField incomeSearchField, expenseSearchField;
    @FXML private DatePicker incomeFromDatePicker, incomeToDatePicker;
    @FXML private DatePicker expenseFromDatePicker, expenseToDatePicker;
    @FXML private TextField assetSearchField;
    @FXML private DatePicker assetFromDatePicker, assetToDatePicker;
    @FXML private TextField liabilitySearchField;
    @FXML private DatePicker liabilityFromDatePicker, liabilityToDatePicker;
    @FXML private Button uploadTransactionsBtn;
    @FXML private Button uploadTransactionsBtn1;

    // Line chart to visualize net worth history
    @FXML private LineChart<String, Number> lineChart;
    @FXML private Tab netWorthTab;

    // DAO implementations for interacting with the database
    private final NetWorthHistoryDao netWorthDao = new NetWorthHistoryDaoImpl();
    private final TransactionDao transactionDao = new TransactionDaoImpl();
    private final UserDao userDao = new UserDaoImpl();
    private final ShopItemDao shopItemDao = new ShopItemDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    private User currentUser;
    private AssetDao assetDao;
    private LiabilityDao liabilityDao;

    /**
     * Main method to initialize the dashboard after a user logs in.
     * Loads user info, financial summaries, theme preferences, and data tables.
     */
    public void setUser(User user) {
        this.currentUser = user;
        this.assetDao = new AssetDaoImpl();
        this.liabilityDao = new LiabilityDaoImpl();

//        incomeFromDatePicker.setValue(LocalDate.now().minusMonths(1));
//        incomeToDatePicker.setValue(LocalDate.now());
//        expenseFromDatePicker.setValue(LocalDate.now().minusMonths(1));
//        expenseToDatePicker.setValue(LocalDate.now());

        filterAssetTable();
        filterIncomeTable();
        filterExpenseTable();
        filterLiabilityTable();

        assetSearchField.textProperty().addListener((obs, oldVal, newVal) -> filterAssetTable());
        assetFromDatePicker.valueProperty().addListener((obs, oldVal, newVal) -> filterAssetTable());
        assetToDatePicker.valueProperty().addListener((obs, oldVal, newVal) -> filterAssetTable());

        incomeSearchField.textProperty().addListener((obs, old, newVal) -> filterIncomeTable());
        incomeFromDatePicker.valueProperty().addListener((obs, old, newVal) -> filterIncomeTable());
        incomeToDatePicker.valueProperty().addListener((obs, old, newVal) -> filterIncomeTable());
        progressBarImportTransactions.setVisible(false);
        statusLabelImportTransactions.setVisible(false);
        progressBarImportTransactions.setProgress(0);
        statusLabelImportTransactions.setText("Waiting import");
        progressBarImportTransactions1.setVisible(false);
        statusLabelImportTransactions1.setVisible(false);
        progressBarImportTransactions1.setProgress(0);
        statusLabelImportTransactions1.setText("Waiting import");

        expenseSearchField.textProperty().addListener((obs, old, newVal) -> filterExpenseTable());
        expenseFromDatePicker.valueProperty().addListener((obs, old, newVal) -> filterExpenseTable());
        expenseToDatePicker.valueProperty().addListener((obs, old, newVal) -> filterExpenseTable());

        liabilitySearchField.textProperty().addListener((obs, old, newVal) -> filterLiabilityTable());
        liabilityFromDatePicker.valueProperty().addListener((obs, old, newVal) -> filterLiabilityTable());
        liabilityToDatePicker.valueProperty().addListener((obs, old, newVal) -> filterLiabilityTable());

        buttonExpensesChart.setDisable(true);
        buttonExpensesChart1.setDisable(true);
        buttonIncomeChart.setDisable(true);
        buttonIncomeChart1.setDisable(true);

        if (shopItemDao.getItemByNameForUser("Dashboard Title Animation", user.getId()) != null) {
            animateDashboardLabel();
        }

        logger.info("Dashboard infos displayed");

        // Display user info and level
        if (shopItemDao.getItemByNameForUser("Welcome!", user.getId()) != null) {
            MyUtils.animateTyping(usernameLabel, shopItemDao.getItemByNameForUser("Make your username BIG", user.getId()) != null ? "Welcome, " + user.getUsername().toUpperCase() + "!" : "Welcome, " + user.getUsername() + "!", Duration.millis(100), Duration.millis(1000));
        } else {
            usernameLabel.setText(shopItemDao.getItemByNameForUser("Make your username BIG", user.getId()) != null ? "Welcome, " + user.getUsername().toUpperCase() + "!" : "Welcome, " + user.getUsername() + "!");
        }
        levelLabel.setText("Level " + user.getLevel());
        xpLabel.setText(MyUtils.formatInt(user.getXp()) + " / " + MyUtils.formatInt(((user.getLevel() + 1) * 500)) + " XP");

        if (shopItemDao.getItemByNameForUser("Points animation", user.getId()) != null) {
            MyUtils.animateNumber(dpLabel, user.getPoints(), Duration.seconds(5), true, "DP", Duration.millis(2000));
        } else {
            dpLabel.setText(MyUtils.formatDpPoints(user.getPoints()));
        }

        if (shopItemDao.getItemByNameForUser("Bicolor Xp Bar", user.getId()) == null) {
            xpBar.setProgress((double) user.getXp() / ((user.getLevel() + 1) * 500));
        } else {
            double targetProgress = (double) user.getXp() / ((user.getLevel() + 1) * 500);
            animateProgressBarColorSmooth(xpBar);    // Start the color animation
            animateProgressBar(targetProgress);
        }

        if (shopItemDao.getItemByNameForUser("Streak calendar", user.getId()) != null) {
            streakButton.setText(user.getCurrentStreak() + " 🔥");
            streakButton.setDisable(false);
        } else {
            streakButton.setText("??? 🔥");
            streakButton.setDisable(true);
        }

        if (shopItemDao.getItemByNameForUser("Fire it up!", user.getId()) == null) {
            streakButton.getStyleClass().remove("button-fire");
        } else {
            streakButton.getStyleClass().add("button-fire");
        }

        if (shopItemDao.getItemByNameForUser("Refreshing", user.getId()) != null) animateRefreshButton();

        netWorthTab.setDisable(shopItemDao.getItemByNameForUser("Net Worth details", user.getId()) == null);

        // Apply user's saved theme preference
        if (shopItemDao.getItemByNameForUser("Dark Mode Theme", user.getId()) != null) {
            if (user.getTheme().equals("light")) {
                changeThemeButton.setText("Light");
                changeThemeButton.setDisable(false);
                switchToLightTheme();
            } else if (user.getTheme().equals("dark")) {
                changeThemeButton.setText("Dark");
                changeThemeButton.setDisable(false);
                switchToDarkTheme();
            }
        } else {
            changeThemeButton.setDisable(true);
        }


        // Load and display last month’s expenses and incomes
        BigDecimal lastMonthExpenses = transactionDao.getLastMonthExpensesSum(user);
        BigDecimal lastMonthIncomes = transactionDao.getLastMonthIncomesSum(user);

        // EXPENSES
        if (lastMonthExpenses != null && lastMonthExpenses.compareTo(BigDecimal.ZERO) > 0) {
            expensesLabel.setText("-" + MyUtils.formatCurrency(lastMonthExpenses, user.getCurrencySymbol()));

            // Style red if item exists
            if (shopItemDao.getItemByNameForUser("Expenses are no good!", user.getId()) != null) {
                expensesLabel.setStyle("-fx-text-fill: red;");
            }

            // Enable/disable chart buttons based on unlock
            boolean hasExpenseChart = shopItemDao.getItemByNameForUser("Expenses pie chart", user.getId()) != null;
            buttonExpensesChart.setDisable(!hasExpenseChart);
            buttonExpensesChart1.setDisable(!hasExpenseChart);

        } else {
            buttonExpensesChart.setDisable(true);
            buttonExpensesChart1.setDisable(true);
            expensesLabel.setText("No expenses last month");
        }

        // INCOMES (unchanged, for comparison)
        if (lastMonthIncomes != null && lastMonthIncomes.compareTo(BigDecimal.ZERO) > 0) {
            incomesLabel.setText(MyUtils.formatCurrency(lastMonthIncomes, user.getCurrencySymbol()));

            if (shopItemDao.getItemByNameForUser("Incomes are so good!", user.getId()) != null) {
                incomesLabel.setStyle("-fx-text-fill: green;");
            }

            boolean hasIncomeChart = shopItemDao.getItemByNameForUser("Income pie chart", user.getId()) != null;
            buttonIncomeChart.setDisable(!hasIncomeChart);
            buttonIncomeChart1.setDisable(!hasIncomeChart);

        } else {
            buttonIncomeChart.setDisable(true);
            buttonIncomeChart1.setDisable(true);
            incomesLabel.setText("No income last month");
        }


        // Display total assets
        double assetsValue = assetDao.sumAllAssetValues(user);
        if (assetsValue == 0) {
            assetsLabel.setText("No assets found");
        } else {
            assetsLabel.setText(MyUtils.formatCurrency(assetsValue, user.getCurrencySymbol()));
            if (shopItemDao.getItemByNameForUser("Assets are so good!", user.getId()) != null)
                assetsLabel.setStyle("-fx-text-fill: green;");
        }

        // Display total liabilities
        double liabilitiesAmount = liabilityDao.sumAllLiabilitiesAmount(user);
        if (liabilitiesAmount == 0) {
            liabilitiesLabel.setText("No liabilities found");
        } else {
            liabilitiesLabel.setText("-" + MyUtils.formatCurrency(liabilitiesAmount, user.getCurrencySymbol()));
            if (shopItemDao.getItemByNameForUser("Liabilities are no good!", user.getId()) != null)
                liabilitiesLabel.setStyle("-fx-text-fill: red;");
        }

        // Calculate and display net worth
        double netWorth = assetsValue - liabilitiesAmount;
        networthLabel.setText(MyUtils.formatCurrency(netWorth, user.getCurrencySymbol()));
        networthLabel.setStyle(netWorth < 0 ? "-fx-text-fill: red;" : "-fx-text-fill: green;");

        // Load chart and table data
        loadNetWorthChart(currentUser);
        setTableViews(currentUser);
        setTooltips();

        // Add shortcut for manual refresh with "R" key
        Scene scene = usernameLabel.getScene();
        if (scene != null) {
            scene.setOnKeyPressed(event -> {
                if (event.getCode() == KeyCode.R) {
                    refresh();
                }
            });
        } else {
            logger.info("Refresh manually the first time");
        }

        // Editors openings
        assetTable.setRowFactory(tv -> {
            TableRow<Asset> row = new TableRow<>();
            row.setOnMouseClicked(event -> {
                if (event.getClickCount() == 2 && (!row.isEmpty())) {
                    Asset selectedAsset = row.getItem();
                    openAssetEditor(selectedAsset);
                }
            });
            row.setTooltip(MyUtils.createInstantTooltip("Double click to edit"));
            return row;
        });

        liabilityTable.setRowFactory(tv -> {
            TableRow<Liability> row = new TableRow<>();
            row.setOnMouseClicked(event -> {
                if (event.getClickCount() == 2 && (!row.isEmpty())) {
                    Liability selectedLiability = row.getItem();
                    openLiabilityEditor(selectedLiability);
                }
            });
            row.setTooltip(MyUtils.createInstantTooltip("Double click to edit"));
            return row;
        });

        incomeTable.setRowFactory(tv -> {
            TableRow<Transaction> row = new TableRow<>();
            row.setOnMouseClicked(event -> {
                if (event.getClickCount() == 2 && (!row.isEmpty())) {
                    Transaction transaction = row.getItem();
                    openTransactionEditor(transaction, "income");
                }
            });
            row.setTooltip(MyUtils.createInstantTooltip("Double click to edit"));
            return row;
        });

        expenseTable.setRowFactory(tv -> {
            TableRow<Transaction> row = new TableRow<>();
            row.setOnMouseClicked(event -> {
                if (event.getClickCount() == 2 && (!row.isEmpty())) {
                    Transaction transaction = row.getItem();
                    openTransactionEditor(transaction, "expense");
                }
            });
            row.setTooltip(MyUtils.createInstantTooltip("Double click to edit"));
            return row;
        });


    }

    private void openAssetEditor(Asset asset) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/asset_editor.fxml"));
            Parent root = loader.load();

            AssetEditorController controller = loader.getController();
            controller.setAsset(asset, currentUser);

            Stage stage = new Stage();
            stage.setTitle("Edit Asset");
            stage.setScene(new Scene(root));
            stage.setResizable(false);

            stage.initModality(Modality.APPLICATION_MODAL);
            stage.initOwner(assetTable.getScene().getWindow());

            stage.showAndWait();
            assetTable.refresh();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void openLiabilityEditor(Liability liability) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/liability_editor.fxml"));
            Parent root = loader.load();

            LiabilityEditorController controller = loader.getController();
            controller.setLiability(liability, currentUser);

            Stage stage = new Stage();
            stage.setTitle("Edit Liability");
            stage.setScene(new Scene(root));
            stage.setResizable(false);

            stage.initModality(Modality.APPLICATION_MODAL);
            stage.initOwner(liabilityTable.getScene().getWindow());

            stage.showAndWait();
            liabilityTable.refresh();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void openTransactionEditor(Transaction transaction, String type) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/transaction_editor.fxml"));
            Parent root = loader.load();

            TransactionEditorController controller = loader.getController();
            controller.setTransaction(transaction, currentUser, type);

            Stage stage = new Stage();
            stage.setScene(new Scene(root));
            stage.setTitle(type.equals("income") ? "Edit Income" : "Edit Expense");

            stage.initModality(Modality.APPLICATION_MODAL);
            stage.initOwner(incomeTable.getScene().getWindow());
            stage.showAndWait();

            // Refresh table
            if (type.equals("income")) {
                filterIncomeTable();
            } else {
                filterExpenseTable();
            }

        } catch (IOException e) {
            e.printStackTrace();
            MyUtils.showError("Error", "Could not open the editor window.");
        }
    }

    // Set UI tooltips
    private void setTooltips() {
        assetsLabel.setTooltip(MyUtils.createInstantTooltip("Total value of your owned assets."));
        liabilitiesLabel.setTooltip(MyUtils.createInstantTooltip("Total value of your liabilities or debts."));
        usernameLabel.setTooltip(MyUtils.createInstantTooltip("Your username."));
        xpBar.setTooltip(MyUtils.createInstantTooltip("Your experience progress toward the next level."));
        xpLabel.setTooltip(MyUtils.createInstantTooltip("Current XP out of the total needed to level up."));
        dpLabel.setTooltip(MyUtils.createInstantTooltip("Your points to spend in the store."));
        levelLabel.setTooltip(MyUtils.createInstantTooltip("Your current level."));
        networthLabel.setTooltip(MyUtils.createInstantTooltip("Your total net worth (assets minus liabilities)."));
        expensesLabel.setTooltip(MyUtils.createInstantTooltip("Last month expenses"));
        incomesLabel.setTooltip(MyUtils.createInstantTooltip("Last month income"));
        streakButton.setTooltip(MyUtils.createInstantTooltip("Visualize your streak calendar"));
        incomeFromDatePicker.setTooltip(MyUtils.createInstantTooltip("From date"));
        incomeToDatePicker.setTooltip(MyUtils.createInstantTooltip("To date"));
        expenseFromDatePicker.setTooltip(MyUtils.createInstantTooltip("From date"));
        expenseToDatePicker.setTooltip(MyUtils.createInstantTooltip("To date"));
    }

    private void animateRefreshButton() {
        RotateTransition rotate = new RotateTransition(Duration.seconds(1), refreshButton);
        rotate.setByAngle(360);
        rotate.setCycleCount(1);
        rotate.setInterpolator(Interpolator.EASE_BOTH);
        rotate.play();
    }

    private Timeline hoverAnimation;
    private final String[] hoverTexts = {"Add","a","new","transaction", "-", "--", "---", "----", "---->"};
    private int currentIndex = 0;

    @FXML
    private void handleButtonHover() {
        if (shopItemDao.getItemByNameForUser("TransACTING", currentUser.getId()) != null) {
            currentIndex = 0;
            hoverAnimation = new Timeline(
                    new KeyFrame(Duration.seconds(0), e -> addTransactionButton.setText(hoverTexts[currentIndex])),
                    new KeyFrame(Duration.seconds(0.3), e -> updateText()),
                    new KeyFrame(Duration.seconds(0.6), e -> updateText()),
                    new KeyFrame(Duration.seconds(0.9), e -> updateText()),
                    new KeyFrame(Duration.seconds(1.2), e -> updateText()),
                    new KeyFrame(Duration.seconds(1.5), e -> updateText()),
                    new KeyFrame(Duration.seconds(1.8), e -> updateText()),
                    new KeyFrame(Duration.seconds(2.1), e -> updateText()),
                    new KeyFrame(Duration.seconds(2.4), e -> updateText()),
                    new KeyFrame(Duration.seconds(2.7), e -> updateText())

            );
            hoverAnimation.setCycleCount(Timeline.INDEFINITE);
            hoverAnimation.play();
            addTransactionButton.setFont(Font.font(addTransactionButton.getFont().getFamily(), FontWeight.BOLD, addTransactionButton.getFont().getSize()));
        }
    }

    private void updateText() {
        currentIndex = (currentIndex + 1) % hoverTexts.length;
        addTransactionButton.setText(hoverTexts[currentIndex]);
    }

    @FXML
    private void handleButtonExit() {
        if (hoverAnimation != null) {
            hoverAnimation.stop();
        }
        addTransactionButton.setText("Add Transaction");
        // Reset font to normal weight
        addTransactionButton.setFont(Font.font(addTransactionButton.getFont().getFamily(), FontWeight.NORMAL, addTransactionButton.getFont().getSize()));
    }


    public void loadNetWorthChart(User user) {
        List<NetWorthHistory> historyList = netWorthDao.findAllByUser(user);

        XYChart.Series<String, Number> series = new XYChart.Series<>();
        series.setName("Net Worth");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        for (NetWorthHistory entry : historyList) {
            BigDecimal netWorth = entry.getNetWorth();
            String date = entry.getDate().format(formatter);
            series.getData().add(new XYChart.Data<>(date, netWorth));
        }

        lineChart.getData().clear();
        lineChart.getData().add(series);

    }



    // Import transactions from file
    private int totXp = 0;
    public void handleUploadTransactions() {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Select Excel File");
        fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("Excel Files", "*.xlsx"));

        Stage stage = (Stage) uploadTransactionsBtn.getScene().getWindow();

        File file = fileChooser.showOpenDialog(stage);

        if (file != null) {

            progressBarImportTransactions.setVisible(true);
            statusLabelImportTransactions.setVisible(true);
            progressBarImportTransactions1.setVisible(true);
            statusLabelImportTransactions1.setVisible(true);
            uploadTransactionsBtn.setDisable(true);
            uploadTransactionsBtn1.setDisable(true);

            Task<Void> importTask = new Task<>() {
                @Override
                protected Void call() {
                    updateMessage("Starting import...");
                    Map<Category, Transaction> result = ExcelTransactionImporter.importFromExcel(file, currentUser);

                    int total = result.size();
                    int counter = 0;

                    for (Category category : result.keySet()) {
                        Transaction transaction = result.get(category);
                        transaction.setUserId(currentUser.getId());
                        transactionDao.insertFile(currentUser, transaction, category);
                        counter++;

                        updateProgress(counter, total);
                        updateMessage("Imported " + counter + " of " + total + " transactions...");

                        totXp += 50;

                        try {
                            Thread.sleep(1);
                        } catch (InterruptedException e) {
                            Thread.currentThread().interrupt();
                        }
                    }


                    updateMessage("Import finished.");
                    return null;
                }
            };


            // Bind progress bar and label
            progressBarImportTransactions.progressProperty().unbind();
            progressBarImportTransactions.progressProperty().bind(importTask.progressProperty());
            statusLabelImportTransactions.textProperty().bind(importTask.messageProperty());

            progressBarImportTransactions1.progressProperty().unbind();
            progressBarImportTransactions1.progressProperty().bind(importTask.progressProperty());
            statusLabelImportTransactions1.textProperty().bind(importTask.messageProperty());

            uploadTransactionsBtn.setDisable(false);
            uploadTransactionsBtn1.setDisable(false);


            importTask.setOnSucceeded(e -> {
                statusLabelImportTransactions.textProperty().unbind();
                statusLabelImportTransactions.setText("Import completed.");
                progressBarImportTransactions.progressProperty().unbind();
                statusLabelImportTransactions.textProperty().unbind();
                statusLabelImportTransactions1.textProperty().unbind();
                statusLabelImportTransactions1.setText("Import completed.");
                progressBarImportTransactions1.progressProperty().unbind();
                statusLabelImportTransactions1.textProperty().unbind();
                userDao.updateUserLevel(currentUser, totXp);
                totXp = 0;
                refresh();
            });

            importTask.setOnFailed(e -> {
                statusLabelImportTransactions.textProperty().unbind();
                statusLabelImportTransactions.setText("Import failed...");
                progressBarImportTransactions.progressProperty().unbind();
                progressBarImportTransactions.setProgress(0);
                progressBarImportTransactions.progressProperty().unbind();
                statusLabelImportTransactions.textProperty().unbind();

                statusLabelImportTransactions1.textProperty().unbind();
                statusLabelImportTransactions1.setText("Import failed...");
                progressBarImportTransactions1.progressProperty().unbind();
                progressBarImportTransactions1.setProgress(0);
                progressBarImportTransactions1.progressProperty().unbind();
                statusLabelImportTransactions1.textProperty().unbind();
                logger.warn(importTask.getException().getMessage());
            });

            // 🔁 Start background task
            new Thread(importTask).start();
        }

    }

    public void handleChangeTheme() {
        if (currentUser.getTheme().equalsIgnoreCase("dark")) {
            currentUser.setTheme("light");
            userDao.updateUserTheme(currentUser);
            logger.info("Changed theme to light");
            switchToLightTheme();
        } else if (currentUser.getTheme().equalsIgnoreCase("light")) {
            currentUser.setTheme("dark");
            userDao.updateUserTheme(currentUser);
            logger.info("Changed theme to dark");
            switchToDarkTheme();
        }
    }

    public void handleOpenCalendarStreak() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/calendar_streak.fxml"));
            Parent root = loader.load();
            CalendarStreakController controller = loader.getController();
            controller.setUserId(currentUser.getId());

            Stage stage = new Stage();
            stage.setTitle("Your Streak");
            stage.setScene(new Scene(root));
            stage.setResizable(false);

            stage.initOwner(streakButton.getScene().getWindow());
            stage.initModality(Modality.WINDOW_MODAL);

            stage.show();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void handleOpenCategoryEditor() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/category_editor.fxml"));
            Parent root = loader.load();

            CategoryManagerController controller = loader.getController();
            controller.setUser(currentUser);

            Stage stage = new Stage();
            stage.setTitle("Edit categories");
            stage.setScene(new Scene(root));
            stage.setResizable(false);

            stage.initOwner(streakButton.getScene().getWindow());
            stage.initModality(Modality.WINDOW_MODAL);

            stage.showAndWait();

            refresh();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void switchToLightTheme() {
        changeThemeButton.setText("Dark");
        tabPane.getStylesheets().clear();
        tabPane.getStylesheets().add(Objects.requireNonNull(getClass().getResource("/style/light_theme.css")).toExternalForm());
    }

    public void switchToDarkTheme() {
        changeThemeButton.setText("Light");
        tabPane.getStylesheets().clear();
        tabPane.getStylesheets().add(Objects.requireNonNull(getClass().getResource("/style/dark_theme.css")).toExternalForm());
    }

    public void animateProgressBar(double targetProgress) {
        targetProgress = Math.min(1.0, Math.max(0, targetProgress));

        Timeline timeline = new Timeline(
                new KeyFrame(Duration.ZERO, new KeyValue(xpBar.progressProperty(), xpBar.getProgress())),
                new KeyFrame(Duration.seconds(3), new KeyValue(xpBar.progressProperty(), targetProgress))
        );
        timeline.play();
    }

    public void animateProgressBarColorSmooth(ProgressBar xpBar) {
        Color color1 = Color.web("#096303"); // Mint
        Color color2 = Color.web("#46E327");   // Jungle
        ObjectProperty<Color> colorProperty = new SimpleObjectProperty<>(color1);
        colorProperty.addListener((obs, oldColor, newColor) -> {
            String rgba = String.format("rgba(%d, %d, %d, %.2f)",
                    (int) (newColor.getRed() * 255),
                    (int) (newColor.getGreen() * 255),
                    (int) (newColor.getBlue() * 255),
                    newColor.getOpacity());
            Platform.runLater(() -> xpBar.setStyle("-fx-accent: " + rgba + ";"));
        });

        Timeline timeline = new Timeline(
                new KeyFrame(Duration.ZERO, new KeyValue(colorProperty, color1, Interpolator.LINEAR)),
                new KeyFrame(Duration.seconds(2), new KeyValue(colorProperty, color2, Interpolator.LINEAR)),
                new KeyFrame(Duration.seconds(4), new KeyValue(colorProperty, color1, Interpolator.LINEAR))
        );

        timeline.setCycleCount(Animation.INDEFINITE);
        timeline.play();
    }

    private void animateDashboardLabel() {
        // Initial state: off-screen and invisible
        dashboardLabel.setTranslateX(-300);
        dashboardLabel.setOpacity(0);

        // Slide transition (from left to position 0)
        TranslateTransition slide = new TranslateTransition(Duration.seconds(4), dashboardLabel);
        slide.setFromX(-300);
        slide.setToX(0);

        // Fade transition (opacity 0 to 1)
        FadeTransition fade = new FadeTransition(Duration.seconds(1), dashboardLabel);
        fade.setFromValue(0);
        fade.setToValue(1);

        // Play slide and fade together
        ParallelTransition slideAndFade = new ParallelTransition(slide, fade);

        slideAndFade.setOnFinished(event -> {
            // After slide+fade finishes, start pulsing effect
            startPulseAnimation();
        });

        slideAndFade.play();
    }

    private void startPulseAnimation() {
        ScaleTransition pulse = new ScaleTransition(Duration.seconds(1), dashboardLabel);
        pulse.setFromX(1.0);
        pulse.setFromY(1.0);
        pulse.setToX(1.1);
        pulse.setToY(1.1);
        pulse.setCycleCount(Animation.INDEFINITE);
        pulse.setAutoReverse(true);
        pulse.play();
    }

    @FXML
    public void handleOpenExpensesPieChart() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/expenses_chart.fxml"));
            Parent root = loader.load();

            ExpensesPieChartController controller = loader.getController();
            controller.setUser(currentUser);

            Stage stage = new Stage();
            stage.setTitle("Expenses pie chart");
            stage.setScene(new Scene(root));
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.setWidth(900);
            stage.setHeight(900);
            stage.setResizable(false);
            stage.show();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @FXML
    public void handleOpenIncomesPieChart() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/income_chart.fxml"));
            Parent root = loader.load();

            IncomePieChartController controller = loader.getController();
            controller.setUser(currentUser);

            Stage stage = new Stage();
            stage.setTitle("Incomes pie chart");
            stage.setScene(new Scene(root));
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.setWidth(900);
            stage.setHeight(900);
            stage.setResizable(false);
            stage.initModality(Modality.WINDOW_MODAL);
            stage.show();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void filterIncomeTable() {
        List<Transaction> result = transactionDao.getTransactionsByType(
                currentUser.getId(),
                "income",
                incomeSearchField.getText(),
                incomeFromDatePicker.getValue(),
                incomeToDatePicker.getValue()
        );
        incomeTable.setItems(FXCollections.observableArrayList(result));
    }

    private void filterExpenseTable() {
        List<Transaction> result = transactionDao.getTransactionsByType(
                currentUser.getId(),
                "expense",
                expenseSearchField.getText(),
                expenseFromDatePicker.getValue(),
                expenseToDatePicker.getValue()
        );
        expenseTable.setItems(FXCollections.observableArrayList(result));
    }

    private void filterAssetTable() {
        List<Asset> filtered = assetDao.searchAssets(
                currentUser.getId(),
                assetSearchField.getText(),
                assetFromDatePicker.getValue(),
                assetToDatePicker.getValue()
        );
        assetTable.setItems(FXCollections.observableArrayList(filtered));
    }

    private void filterLiabilityTable() {
        List<Liability> filtered = liabilityDao.searchLiabilities(
                currentUser.getId(),
                liabilitySearchField.getText(),
                liabilityFromDatePicker.getValue(),
                liabilityToDatePicker.getValue()
        );
        liabilityTable.setItems(FXCollections.observableArrayList(filtered));
    }

    @FXML
    public void handleLogout() {
        try {
            currentUser = null;

            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/login.fxml"));
            Parent loginRoot = loader.load();

            Stage currentStage = (Stage) usernameLabel.getScene().getWindow();
            currentStage.setScene(new Scene(loginRoot));
            currentStage.setTitle("Login");
            currentStage.centerOnScreen();

        } catch (IOException e) {
            logger.error("Failed to logout and return to login screen", e);
            e.printStackTrace();
        }
    }

    @FXML
    private void openUserProfile() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/user_profile.fxml"));
            Parent root = loader.load();

            UserProfileController controller = loader.getController();
            controller.setUser(currentUser, true);

            Stage stage = new Stage();
            stage.setTitle("User Profile");
            stage.setScene(new Scene(root));
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.show();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @FXML
    private void handleOpenNetWorthForm() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/net_worth_form.fxml"));
            Parent root = loader.load();

            NetWorthFormController controller = loader.getController();
            controller.setUser(currentUser);

            Stage stage = new Stage();
            stage.setTitle("Add Net Worth Record");
            stage.setScene(new Scene(root));
            stage.initModality(Modality.APPLICATION_MODAL);

            stage.showAndWait();

            refresh();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @FXML
    public void handleOpenAssetForm() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/asset_form.fxml"));
            Parent assetRoot = loader.load();

            AssetFormController controller = loader.getController();
            controller.setUser(currentUser);

            Stage stage = new Stage();
            stage.setTitle("Add Asset");
            stage.setScene(new Scene(assetRoot));
            stage.initModality(Modality.APPLICATION_MODAL);

            stage.setOnHidden(windowEvent -> refresh());

            stage.showAndWait();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @FXML
    private void handleOpenAddLiabilityForm() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/liability_form.fxml"));
            Parent root = loader.load();

            LiabilityFormController controller = loader.getController();
            controller.setUser(currentUser);

            Stage stage = new Stage();
            stage.setTitle("Add New Liability");
            stage.setScene(new Scene(root));
            stage.initModality(Modality.APPLICATION_MODAL);

            stage.setOnHidden(windowEvent -> refresh());

            stage.showAndWait();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public void setTableViews(User user) {

        List<Asset> assets = assetDao.findAllByUser(user);
        assetTable.setItems(FXCollections.observableArrayList(assets));

        List<Liability> liabilities = liabilityDao.findAllByUserId(user);
        liabilityTable.setItems(FXCollections.observableArrayList(liabilities));

        List<Transaction> incomes = transactionDao.findAllIncomesByUser(user);
        incomeTable.setItems(FXCollections.observableArrayList(incomes));

        List<Transaction> expenses = transactionDao.findAllExpensesByUser(user);
        expenseTable.setItems(FXCollections.observableArrayList(expenses));

        // assets
        nameColumn.setCellValueFactory(new PropertyValueFactory<>("name"));
        typeColumn.setCellValueFactory(new PropertyValueFactory<>("type"));
        valueColumn.setCellValueFactory(cellData ->
                new javafx.beans.property.SimpleStringProperty(
                        MyUtils.formatCurrency(cellData.getValue().getValue(), user.getCurrencySymbol())
                )
        );
        acquiredDateColumn.setCellValueFactory(new PropertyValueFactory<>("acquiredDate"));
        liquidColumn.setCellValueFactory(cellData -> {
            boolean isLiquid = cellData.getValue().isLiquid();
            String text = isLiquid ? "liquid" : "not liquid";
            return new javafx.beans.property.SimpleStringProperty(text);
        });
        notesColumns.setCellValueFactory(new PropertyValueFactory<>("notes"));

        // liabilities
        liabilityNameColumn.setCellValueFactory(new PropertyValueFactory<>("name"));
        liabilityTypeColumn.setCellValueFactory(new PropertyValueFactory<>("type"));
        amountColumn.setCellValueFactory(cellData ->
                new javafx.beans.property.SimpleStringProperty(
                        MyUtils.formatCurrency(cellData.getValue().getAmount(), user.getCurrencySymbol())
                )
        );
        remainingColumn.setCellValueFactory(cellData ->
                new javafx.beans.property.SimpleStringProperty(
                        MyUtils.formatCurrency(cellData.getValue().getAmountRemaining(), user.getCurrencySymbol())
                )
        );
        rateColumn.setCellValueFactory(new PropertyValueFactory<>("interestRate"));
        startColumn.setCellValueFactory(new PropertyValueFactory<>("startDate"));
        dueColumn.setCellValueFactory(new PropertyValueFactory<>("dueDate"));
        activeColumn.setCellValueFactory(cellData -> {
            boolean isLiquid = cellData.getValue().isActive();
            String text = isLiquid ? "active" : "closed";
            return new javafx.beans.property.SimpleStringProperty(text);
        });
        liabilityNotesColumn.setCellValueFactory(new PropertyValueFactory<>("notes"));

        // incomes
        incomesNameColumn.setCellValueFactory(new PropertyValueFactory<>("name"));
        incomesDateColumn.setCellValueFactory(cellData ->
                new javafx.beans.property.SimpleStringProperty(
                        cellData.getValue().getDate().toString()));
        incomesAmountColumn.setCellValueFactory(cellData ->
                new javafx.beans.property.SimpleStringProperty(
                        MyUtils.formatCurrency(cellData.getValue().getAmount(), user.getCurrencySymbol())
                )
        );
        incomesCategoryColumn.setCellValueFactory(new PropertyValueFactory<>("categoryName"));
        incomesDescriptionColumn.setCellValueFactory(new PropertyValueFactory<>("description"));

        // expenses
        expensesNameColumn.setCellValueFactory(new PropertyValueFactory<>("name"));
        expensesDateColumn.setCellValueFactory(cellData ->
                new javafx.beans.property.SimpleStringProperty(
                        cellData.getValue().getDate().toString()));
        expensesAmountColumn.setCellValueFactory(cellData ->
                new javafx.beans.property.SimpleStringProperty(
                        MyUtils.formatCurrency(cellData.getValue().getAmount(), user.getCurrencySymbol())
                )
        );
        expensesCategoryColumn.setCellValueFactory(new PropertyValueFactory<>("categoryName"));
        expensesDescriptionColumn.setCellValueFactory(new PropertyValueFactory<>("description"));
    }

    public void refresh() {
        UserDao userDao = new UserDaoImpl();
        currentUser = userDao.getUserById(currentUser.getId()).get();
        setUser(currentUser);
    }

    @FXML
    private void handleOpenTransactionForm() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/transaction_form.fxml"));
            Parent root = loader.load();

            TransactionFormController controller = loader.getController();
            controller.setCurrentUser(currentUser);

            Stage stage = new Stage();
            stage.setTitle("Add transaction or category");
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.setScene(new Scene(root));
            stage.showAndWait();

            refresh();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @FXML
    public void handleOpenShop() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/shop.fxml"));
            Parent root = loader.load();

            ShopController controller = loader.getController();
            controller.setCurrentUser(currentUser);

            Stage stage = new Stage();
            stage.setTitle("Shop");
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.setScene(new Scene(root));
            stage.setResizable(false);
            stage.showAndWait();

            refresh();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @FXML
    private void handleSaveProfile() {
        String username = usernameField.getText();
        String email = emailField.getText();
        String firstName = firstNameField.getText();
        String lastName = lastNameField.getText();

        String checkSql = "SELECT COUNT(*) FROM users WHERE (username = ? OR email = ?) AND id != ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setString(1, username);
            checkStmt.setString(2, email);
            checkStmt.setInt(3, currentUser.getId());

            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                MyUtils.showWarning("Conflitto", "Username o email già in uso.");
                return;
            }

            // If no conflicts, update
            String updateSql = "UPDATE users SET username = ?, email = ?, first_name = ?, last_name = ? WHERE id = ?";

            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setString(1, username);
                updateStmt.setString(2, email);
                updateStmt.setString(3, firstName);
                updateStmt.setString(4, lastName);
                updateStmt.setInt(5, currentUser.getId());

                int rows = updateStmt.executeUpdate();

                if (rows > 0) {
                    MyUtils.showInfo("Successo", "Profilo aggiornato con successo.");
                } else {
                    MyUtils.showWarning("Nessuna modifica", "Nessuna modifica salvata.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            MyUtils.showError("Errore", "Errore durante il salvataggio del profilo.");
        }
    }



    @FXML
    private void handleApplyTheme() {
        String theme = themeChoiceBox.getValue().toLowerCase();

        String sql = "UPDATE users SET theme = ? WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, theme);
            stmt.setInt(2, currentUser.getId());
            stmt.executeUpdate();

            MyUtils.showInfo("Theme updated!", "Tema aggiornato a: " + theme);
        } catch (SQLException e) {
            e.printStackTrace();
            MyUtils.showError("Error", "Errore durante l'aggiornamento del tema.");
        }
    }


    @FXML
    private void handleUpdateCurrency() {
        String currency = currencyChoiceBox.getValue();

        // Split to get symbol from choice: "EUR (€)"
        String[] parts = currency.split(" ");
        String currencyCode = parts[0];
        String currencySymbol = parts[1].replace("(", "").replace(")", "");

        String sql = "UPDATE users SET preferred_currency = ?, currency_symbol = ? WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, currencyCode);
            stmt.setString(2, currencySymbol);
            stmt.setInt(3, currentUser.getId());
            stmt.executeUpdate();

            MyUtils.showInfo("Currency updated!", "Valuta aggiornata: " + currencyCode);
        } catch (SQLException e) {
            e.printStackTrace();
            MyUtils.showError("Error", "Errore durante l'aggiornamento della valuta.");
        }
    }

    @FXML
    private void handleChangePassword() {
        String current = currentPasswordField.getText();
        String newPass = newPasswordField.getText();
        String confirm = confirmPasswordField.getText();

        if (!newPass.equals(confirm)) {
            MyUtils.showError("Password mismatch", "Le nuove password non corrispondono.");
            return;
        }

        String sql = "SELECT password_hash FROM users WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, currentUser.getId());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hash = rs.getString("password_hash");

                if (!BCrypt.checkpw(current, hash)) {
                    MyUtils.showError("Error", "La password attuale non è corretta.");
                    return;
                }

                // Update password
                String newHash = BCrypt.hashpw(newPass, BCrypt.gensalt());
                String updateSql = "UPDATE users SET password_hash = ? WHERE id = ?";

                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, newHash);
                    updateStmt.setInt(2, currentUser.getId());
                    updateStmt.executeUpdate();
                    MyUtils.showInfo("Password updated!", "Password cambiata con successo.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            MyUtils.showError("Error", "Errore durante il cambio password.");
        }
    }

}
