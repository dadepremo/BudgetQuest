package budgetquest.controller;

import budgetquest.dao.AssetDao;
import budgetquest.dao.AssetDaoImpl;
import budgetquest.model.Asset;
import budgetquest.model.User;
import budgetquest.utils.MyUtils;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.stage.Stage;

import java.math.BigDecimal;
import java.sql.SQLException;

public class AssetEditorController {

    @FXML private TextField nameField;
    @FXML private TextField typeField;
    @FXML private TextField valueField;
    @FXML private DatePicker acquiredDatePicker;
    @FXML private CheckBox liquidCheckBox;
    @FXML private TextArea notesArea;

    private Asset asset;
    private User loggedUser;

    public void setAsset(Asset asset, User user) {
        this.asset = asset;
        this.loggedUser = user;

        nameField.setText(asset.getName());
        typeField.setText(asset.getType());
        valueField.setText(asset.getValue() != null ? asset.getValue().toPlainString() : "");
        acquiredDatePicker.setValue(asset.getAcquiredDate());
        liquidCheckBox.setSelected(asset.isLiquid());
        notesArea.setText(asset.getNotes());
    }

    @FXML
    private void handleSave() {

        String name = nameField.getText().trim();
        String type = typeField.getText().trim();
        String amountStr = valueField.getText().trim();

        // Validate value field as BigDecimal
        BigDecimal value;
        try {
            value = new BigDecimal(valueField.getText());
        } catch (NumberFormatException e) {
            MyUtils.showWarning("Invalid value", "Please enter a valid number for Value.");
            return;
        }

        if (value.compareTo(BigDecimal.ZERO) < 0) {
            MyUtils.showWarning("Invalid value", "Please enter a valid number for Value.");
            return;
        }

        if (loggedUser == null) {
            MyUtils.showWarning("Credentials error", "No user logged in.");
            return;
        }

        if (name.isEmpty()) {
            MyUtils.showWarning("Invalid value", "Please insert the name.");
            return;
        }

        if (type.isEmpty()) {
            MyUtils.showWarning("Invalid value", "Please insert the type.");
            return;
        }

        if (amountStr.isEmpty()) {
            MyUtils.showWarning("Invalid value", "Please enter the value");
            return;
        }

        asset.setName(nameField.getText());
        asset.setType(typeField.getText());
        asset.setValue(value);
        asset.setAcquiredDate(acquiredDatePicker.getValue());
        asset.setLiquid(liquidCheckBox.isSelected());
        asset.setNotes(notesArea.getText());

        try {
            AssetDao assetDao = new AssetDaoImpl();
            assetDao.updateAsset(asset, loggedUser);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // Close window
        closeWindow();
    }

    @FXML
    private void handleCancel() {
        closeWindow();
    }

    private void closeWindow() {
        Stage stage = (Stage) nameField.getScene().getWindow();
        stage.close();
    }

}
