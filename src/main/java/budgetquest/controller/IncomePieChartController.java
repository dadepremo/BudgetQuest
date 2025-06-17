package budgetquest.controller;

import budgetquest.dao.TransactionDao;
import budgetquest.dao.TransactionDaoImpl;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.chart.PieChart;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.AnchorPane;
import budgetquest.model.User;

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

        // Optional: improve appearance
        pieChart.setClockwise(true);
        pieChart.setStartAngle(90);

        // Bind chart size to container
        pieChart.prefWidthProperty().bind(chartContainer.widthProperty());
        pieChart.prefHeightProperty().bind(chartContainer.heightProperty());

        chartContainer.getChildren().clear();
        chartContainer.getChildren().add(pieChart);

        // OR anchor it to all sides (alternative to binding)
        AnchorPane.setTopAnchor(pieChart, 0.0);
        AnchorPane.setBottomAnchor(pieChart, 0.0);
        AnchorPane.setLeftAnchor(pieChart, 0.0);
        AnchorPane.setRightAnchor(pieChart, 0.0);
    }
}
