package controller;

import dao.TransactionDao;
import dao.TransactionDaoImpl;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.chart.PieChart;
import javafx.scene.layout.AnchorPane;
import model.User;

import java.math.BigDecimal;
import java.util.Map;

public class IncomePieChartController {

    @FXML
    private AnchorPane chartContainer;

    private final TransactionDao transactionDao = new TransactionDaoImpl();
    private User user;

    public void setUser(User user) {
        this.user = user;
        loadIncomePieChart();
    }

    private void loadIncomePieChart() {
        Map<String, BigDecimal> incomeData = transactionDao.getIncomesGroupedByCategory(user);

        ObservableList<PieChart.Data> pieChartData = FXCollections.observableArrayList();
        incomeData.forEach((categoryName, totalAmount) ->
                pieChartData.add(new PieChart.Data(categoryName, totalAmount.doubleValue()))
        );

        PieChart pieChart = new PieChart(pieChartData);
        pieChart.setTitle("Income by Category");
        pieChart.setLegendVisible(true);
        pieChart.setLabelsVisible(true);

        chartContainer.getChildren().clear();
        chartContainer.getChildren().add(pieChart);
    }
}
