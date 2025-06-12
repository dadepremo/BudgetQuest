package controller;

import dao.*;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.PieChart;
import javafx.scene.chart.XYChart;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.KeyCode;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import model.*;
import utils.Logger;
import utils.MyUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

public class DashboardController {

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

    // labels assets table view
    @FXML private TableView<Asset> assetTable;
    @FXML private TableColumn<Asset, String> nameColumn;
    @FXML private TableColumn<Asset, String> typeColumn;
    @FXML private TableColumn<Asset, String> valueColumn;
    @FXML private TableColumn<Asset, LocalDate> acquiredDateColumn;
    @FXML private TableColumn<Asset, String> liquidColumn;
    @FXML private TableColumn<Asset, String> notesColumns;

    // labels liabilities table view
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

    @FXML private TableView<Transaction> expenseTable;
    @FXML private TableColumn<Transaction, String> expensesNameColumn;
    @FXML private TableColumn<Transaction, String> expensesDateColumn;
    @FXML private TableColumn<Transaction, String> expensesAmountColumn;
    @FXML private TableColumn<Transaction, String> expensesCategoryColumn;
    @FXML private TableColumn<Transaction, String> expensesDescriptionColumn;


    @FXML private TableView<Transaction> incomeTable;
    @FXML private TableColumn<Transaction, String> incomesNameColumn;
    @FXML private TableColumn<Transaction, String> incomesDateColumn;
    @FXML private TableColumn<Transaction, String> incomesAmountColumn;
    @FXML private TableColumn<Transaction, String> incomesCategoryColumn;
    @FXML private TableColumn<Transaction, String> incomesDescriptionColumn;

    @FXML private LineChart<String, Number> lineChart;

    private final NetWorthHistoryDao netWorthDao = new NetWorthHistoryDaoImpl();
    private final TransactionDao transactionDao = new TransactionDaoImpl();

    private User currentUser;
    private AssetDao assetDao;
    private LiabilityDao liabilityDao;

    public void setUser(User user) {
        this.currentUser = user;
        this.assetDao = new AssetDaoImpl();
        this.liabilityDao = new LiabilityDaoImpl();


        Logger.info("Dashboard infos displayed");
        usernameLabel.setText("Welcome, " + user.getUsername() + "!");
        levelLabel.setText("Level " + user.getLevel());
        xpLabel.setText(user.getXp() + " / " + ((user.getLevel() + 1) * 500) + " XP");
        xpBar.setProgress((double) user.getXp() / ((user.getLevel() + 1) * 500));
        dpLabel.setText(user.getPoints() + " DP");

        BigDecimal lastMonthExpenses = transactionDao.getLastMonthExpensesSum(user);
        BigDecimal lastMonthIncomes = transactionDao.getLastMonthIncomesSum(user);
        if (lastMonthExpenses != null && lastMonthExpenses.compareTo(BigDecimal.valueOf(0)) > 0) {
            expensesLabel.setText(MyUtils.formatCurrency(lastMonthExpenses, user.getCurrencySymbol()));
        } else {
            expensesLabel.setText("No expenses last month");
        }
        if (lastMonthIncomes != null && lastMonthIncomes.compareTo(BigDecimal.valueOf(0)) > 0) {
            incomesLabel.setText(MyUtils.formatCurrency(lastMonthIncomes, user.getCurrencySymbol()));
        } else {
            incomesLabel.setText("No income last month");
        }


        // display sum of the assets value
        double assetsValue = assetDao.sumAllAssetValues(user);
        if (assetsValue == 0) {
            assetsLabel.setText("No assets found");
        } else {
            assetsLabel.setText(MyUtils.formatCurrency(assetsValue, user.getCurrencySymbol()));
        }

        // display sum of the liabilities assetsValue
        double liabilitiesAmount = liabilityDao.sumAllLiabilitiesAmount(user);
        if (liabilitiesAmount == 0) {
            liabilitiesLabel.setText("No liabilities found");
        } else {
            liabilitiesLabel.setText("- " + MyUtils.formatCurrency(liabilitiesAmount, user.getCurrencySymbol()));
        }

        double netWorth = assetsValue - liabilitiesAmount;
        networthLabel.setText(MyUtils.formatCurrency(netWorth, user.getCurrencySymbol()));

        if (netWorth < 0) {
            networthLabel.setStyle("-fx-text-fill: red;");
        } else {
            networthLabel.setStyle("-fx-text-fill: green;");
        }

        loadNetWorthChart(currentUser);
        setTableViews(currentUser);
        setTooltips();

        Scene scene = usernameLabel.getScene();
        if (scene != null) {
            scene.setOnKeyPressed(event -> {
                if (event.getCode() == KeyCode.R) {
                    refresh();
                }
            });
        } else {
            Logger.info("Refresh manually the first time");
        }

    }

    private void setTooltips() {
        assetsLabel.setTooltip(new Tooltip("Total value of your owned assets."));
        liabilitiesLabel.setTooltip(new Tooltip("Total value of your liabilities or debts."));
        usernameLabel.setTooltip(new Tooltip("Your username."));
        xpBar.setTooltip(new Tooltip("Your experience progress toward the next level."));
        xpLabel.setTooltip(new Tooltip("Current XP out of the total needed to level up."));
        dpLabel.setTooltip(new Tooltip("Your points to spend in the store."));
        levelLabel.setTooltip(new Tooltip("Your current level."));
        networthLabel.setTooltip(new Tooltip("Your total net worth (assets minus liabilities)."));
        expensesLabel.setTooltip(new Tooltip("Last month expenses"));
        incomesLabel.setTooltip(new Tooltip("Last month income"));
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

//        Platform.runLater(() -> {
//            Node line = series.getNode().lookup(".chart-series-line");
//            if (line != null) {
//                line.setStyle("-fx-stroke: green;");
//            }
//
//            for (XYChart.Data<String, Number> data : series.getData()) {
//                Node node = data.getNode();
//                if (node != null) {
//                    node.setStyle("-fx-background-color: green, white;");
//                }
//            }
//        });
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
            stage.setResizable(false);
            stage.setWidth(500);
            stage.setHeight(500);
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
            stage.setResizable(false);
            stage.setWidth(500);
            stage.setHeight(500);
            stage.show();
        } catch (IOException e) {
            e.printStackTrace();
        }
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
            Logger.error("Failed to logout and return to login screen", e);
            e.printStackTrace();
        }
    }

    @FXML
    private void openUserProfile() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/user_profile.fxml"));
            Parent root = loader.load();

            UserProfileController controller = loader.getController();
            controller.setUser(currentUser);

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

}
