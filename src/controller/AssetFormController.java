package controller;

import dao.*;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.paint.Color;
import model.Asset;
import model.User;
import utils.Logger;
import utils.MyUtils;

import java.io.IOException;
import java.math.BigDecimal;

public class AssetFormController {

    @FXML private TextField nameField;
    @FXML private TextField typeField;
    @FXML private TextField valueField;
    @FXML private DatePicker acquiredDatePicker;
    @FXML private TextArea notesArea;
    @FXML private CheckBox isLiquidCheckBox;
    @FXML private Label statusLabel;

    private XpGiverDao xpGiverDao = new XpGiverDaoImpl();
    private int normalAssetBonus = xpGiverDao.getValueByName("normalAssetBonus");

    private final AssetDao assetDao = new AssetDaoImpl();
    private User loggedUser;
    private UserDao userDao = new UserDaoImpl();

    public void setUser(User user) {
        this.loggedUser = user;
    }

    @FXML
    public void handleSaveAsset() {

        //TODO: fare check convalida dati perché ora come ora posso mettere anche delle stringhe nel value e va in errore il tutto
        String name = nameField.getText().trim();
        String type = typeField.getText().trim();
        String amountStr = valueField.getText().trim();

        if (loggedUser == null) {
            statusLabel.setText("No user logged in.");
            Logger.warn("No user logged in");
            return;
        }

        if (name.isEmpty()) {
            statusLabel.setText("Please insert the name.");
            Logger.warn("No asset name inserted");
            return;
        }

        if (type.isEmpty()) {
            statusLabel.setText("Please insert the type.");
            Logger.warn("No asset type inserted");
            return;
        }

        if (amountStr.isEmpty()) {
            statusLabel.setText("Please enter the value");
            Logger.warn("No asset value inserted");
            return;
        }

        double amount;
        try {
            amount = Double.parseDouble(amountStr);
            if (amount <= 0) {
                statusLabel.setTextFill(Color.RED);
                statusLabel.setText("Amount must be greater than zero.");
                return;
            }
        } catch (NumberFormatException e) {
            statusLabel.setTextFill(Color.RED);
            statusLabel.setText("Invalid amount format.");
            return;
        }

        try {
            Asset asset = new Asset();
            asset.setUserId(loggedUser.getId());
            asset.setName(nameField.getText());
            asset.setType(typeField.getText());
            asset.setValue(new BigDecimal(valueField.getText()));
            asset.setAcquiredDate(acquiredDatePicker.getValue());
            asset.setNotes(notesArea.getText());
            asset.setLiquid(isLiquidCheckBox.isSelected());

            boolean saved = assetDao.insertAsset(asset);
            if(saved) {
                Logger.info("Asset saved successfully");
                statusLabel.setText("Asset saved successfully!");
                userDao.updateUserLevel(loggedUser, normalAssetBonus);
                if (asset.getValue().compareTo(BigDecimal.valueOf(100000)) >= 0 && asset.getValue().compareTo(BigDecimal.valueOf(500000)) < 0) {
                    userDao.updateUserPoints(loggedUser, 200);
                    MyUtils.showInfo("Points added!", "That was a pretty big acquisition!\n\nProud of you...\nWe added 200 DP to your balance!");
                } else if (asset.getValue().compareTo(BigDecimal.valueOf(500000)) >= 0 && asset.getValue().compareTo(BigDecimal.valueOf(1000000)) < 0) {
                    userDao.updateUserPoints(loggedUser, 500);
                    MyUtils.showInfo("Points added!", "That was a big acquisition!\n\nProud of you...\nWe added 500 DP to your balance!");
                } else if (asset.getValue().compareTo(BigDecimal.valueOf(1000000)) >= 0 && asset.getValue().compareTo(BigDecimal.valueOf(10000000)) < 0) {
                    userDao.updateUserPoints(loggedUser, 750);
                    MyUtils.showInfo("Points added!", "You're becoming a shark!\n\nProud of you...\nWe added 750 DP to your balance!");
                } else if (asset.getValue().compareTo(BigDecimal.valueOf(10000000)) >= 0) {
                    userDao.updateUserPoints(loggedUser, 1000);
                    MyUtils.showInfo("Points added!", "Your portfolio is becoming impressive!\n\nProud of you...\nWe added 1000 DP to your balance!");
                } else {
                    userDao.updateUserPoints(loggedUser, 10);
                    MyUtils.showInfo("Points added!", "Even the smaller assets matter!\n\nProud of you...\nWe added 10 DP to your balance!");
                }
            } else {
                Logger.info("Error saving asset");
                statusLabel.setText("Error saving asset.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            statusLabel.setText("Invalid input or system error.");
            Logger.error("Invalid input or system error", (IOException) e);
        }
    }
}
