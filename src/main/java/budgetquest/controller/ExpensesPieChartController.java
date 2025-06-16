package budgetquest.controller;

import budgetquest.dao.TransactionDao;
import budgetquest.dao.TransactionDaoImpl;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.chart.PieChart;
import javafx.scene.layout.AnchorPane;
import budgetquest.model.User;

import java.math.BigDecimal;
import java.util.Map;

public class ExpensesPieChartController {

    @FXML private AnchorPane chartContainer;


    TransactionDao transactionDao = new TransactionDaoImpl();
    User user = new User();

    public void setUser(User user) {
        this.user = user;
        loadExpensePieChart();
    }

    public void loadExpensePieChart() {
        Map<String, BigDecimal> categoryTotals = transactionDao.getExpensesGroupedByCategory(user);

        ObservableList<PieChart.Data> pieChartData = FXCollections.observableArrayList();

        for (Map.Entry<String, BigDecimal> entry : categoryTotals.entrySet()) {
            pieChartData.add(new PieChart.Data(entry.getKey(), entry.getValue().doubleValue()));
        }

        PieChart pieChart = new PieChart(pieChartData);
        pieChart.setTitle("Expenses by Category");
        pieChart.setLegendVisible(true);
        pieChart.setLabelsVisible(true);

        chartContainer.getChildren().clear();
        chartContainer.getChildren().add(pieChart);
    }
}
