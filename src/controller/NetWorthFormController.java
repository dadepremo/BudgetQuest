package controller;

import dao.*;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.stage.Stage;
import model.User;
import utils.Logger;
import utils.MyUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Optional;

public class NetWorthFormController {

    @FXML private DatePicker datePicker;
    @FXML private TextField assetsField;
    @FXML private TextField liabilitiesField;
    @FXML private Label netWorthLabel;

    private final NetWorthHistoryDao netWorthDao = new NetWorthHistoryDaoImpl();
    private User currentUser;
    private final AssetDao assetDao = new AssetDaoImpl();
    private final LiabilityDao liabilityDao = new LiabilityDaoImpl();

    private double sumAssets;
    private double sumLiabilities;

    public void setUser(User user) {
        this.currentUser = user;
        sumAssets = assetDao.sumAllAssetValues(currentUser);
        sumLiabilities = liabilityDao.sumAllLiabilitiesAmount(currentUser);
        retrieveNetworthValues();
    }

    @FXML
    public void retrieveNetworthValues() {

        assetsField.setText(String.valueOf(sumAssets));
        liabilitiesField.setText(String.valueOf(sumLiabilities));

        assetsField.textProperty().addListener((obs, oldVal, newVal) -> updateNetWorthLabel());
        liabilitiesField.textProperty().addListener((obs, oldVal, newVal) -> updateNetWorthLabel());

        updateNetWorthLabel();
    }

    private void updateNetWorthLabel() {
        try {
            BigDecimal assets = new BigDecimal(assetsField.getText());
            BigDecimal liabilities = new BigDecimal(liabilitiesField.getText());
            BigDecimal netWorth = assets.subtract(liabilities);
            netWorthLabel.setText("Max Assets: " + MyUtils.formatCurrency(sumAssets, "€") + "\nMax Liabilities: " + MyUtils.formatCurrency(sumLiabilities, "€") + "\nNet Worth: " + MyUtils.formatCurrency(netWorth, "€"));
        } catch (Exception e) {
            netWorthLabel.setText("Net Worth: € ?");
        }
    }

    @FXML
    private void handleSave() {
        if (currentUser == null) {
            MyUtils.showError("Authorization problem", "Error: No user set.");
            Logger.error("User not set");
            return;
        }

        LocalDate date = datePicker.getValue();
        if (date == null) {
            MyUtils.showWarning("Validation problem", "Please select a date");
            return;
        }

        Optional<LocalDate> lastDateOpt = netWorthDao.findLastForUser(currentUser);
        if (lastDateOpt.isPresent()) {
            if (!date.isAfter(lastDateOpt.get())) {
                MyUtils.showWarning("Validation problem", "The date must be after the last net worth record date\n\nLast net worth update was on: " + MyUtils.localDateFormattedDisplay(lastDateOpt.get()));
                return;
            }
        }

        if (assetsField.getText().isEmpty()) {
            MyUtils.showWarning("Validation problem", "Please add assets value");
            return;
        }

        if (liabilitiesField.getText().isEmpty()) {
            MyUtils.showWarning("Validation problem", "Please add liabilities value");
            return;
        }

        try {
            BigDecimal assets = new BigDecimal(assetsField.getText());
            BigDecimal liabilities = new BigDecimal(liabilitiesField.getText());

            if(assets.compareTo(assets.abs()) < 0) {
                MyUtils.showWarning("Validation problem", "Assets value must be greater than 0");
                return;
            }

            if(liabilities.compareTo(liabilities.abs()) < 0) {
                MyUtils.showWarning("Validation problem", "Liabilities value must be greater than 0");
                return;
            }

            if(assets.compareTo(BigDecimal.valueOf(sumAssets)) > 0) {
                MyUtils.showWarning("Validation problem", "Enter a lower asset value");
                Logger.info("Tried to add assets for " + assets + " max: " + sumAssets);
                return;
            }

            if(liabilities.compareTo(BigDecimal.valueOf(sumLiabilities)) > 0) {
                MyUtils.showWarning("Validation problem", "Enter a lower liabilities value");
                Logger.info("Tried to add liabilities for " + liabilities + " max: " + sumLiabilities);
                return;
            }

            netWorthDao.insert(currentUser.getId(), date, assets, liabilities);

            MyUtils.showInfo("Success!", "Net worth saved successfully.");
            closeForm();

        } catch (NumberFormatException e) {
            MyUtils.showWarning("Validation problem", "Invalid number format.");
        } catch (Exception e) {
            MyUtils.showError("Error", "Error saving data.");
            e.printStackTrace();
        }
    }

    private void closeForm() {
        Stage stage = (Stage) datePicker.getScene().getWindow();
        stage.close();
    }
}
