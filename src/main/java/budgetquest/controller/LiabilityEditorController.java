package budgetquest.controller;

import budgetquest.dao.LiabilityDao;
import budgetquest.dao.LiabilityDaoImpl;
import budgetquest.model.Liability;
import budgetquest.model.User;
import budgetquest.utils.MyUtils;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

import java.math.BigDecimal;
import java.sql.SQLException;

public class LiabilityEditorController {

    @FXML private TextField nameField;
    @FXML private TextField typeField;
    @FXML private TextField amountField;
    @FXML private TextField remainingField;
    @FXML private TextField interestField;
    @FXML private DatePicker startDatePicker;
    @FXML private DatePicker dueDatePicker;
    @FXML private CheckBox activeCheckBox;
    @FXML private TextArea notesArea;

    private Liability liability;
    private User loggedUser;

    public void setLiability(Liability liability, User user) {
        this.liability = liability;
        this.loggedUser = user;

        nameField.setText(liability.getName());
        typeField.setText(liability.getType());
        amountField.setText(liability.getAmount() != null ? liability.getAmount().toPlainString() : "");
        remainingField.setText(liability.getAmountRemaining() != null ? liability.getAmountRemaining().toPlainString() : "");
        interestField.setText(liability.getInterestRate() != null ? liability.getInterestRate().toPlainString() : "");
        startDatePicker.setValue(liability.getStartDate());
        dueDatePicker.setValue(liability.getDueDate());
        activeCheckBox.setSelected(liability.isActive());
        notesArea.setText(liability.getNotes());
    }

    @FXML
    private void handleSave() {
        String name = nameField.getText().trim();
        String type = typeField.getText().trim();
        String amountStr = amountField.getText().trim();
        String amountRemainingStr = remainingField.getText().trim();
        String interestStr = interestField.getText().trim();


        // Basic required fields check
        if (name.isEmpty()) {
            MyUtils.showWarning("Invalid input", "Please insert the name.");
            return;
        }

        if (type.isEmpty()) {
            MyUtils.showWarning("Invalid input", "Please insert the type.");
            return;
        }

        if (amountStr.isEmpty() || amountRemainingStr.isEmpty()) {
            MyUtils.showWarning("Invalid input", "Please enter the amount.");
            return;
        }

        if (loggedUser == null) {
            MyUtils.showWarning("Credentials error", "No user logged in.");
            return;
        }

        // Validate numerical fields
        BigDecimal amount;
        try {
            amount = new BigDecimal(amountStr);
            if (amount.compareTo(BigDecimal.ZERO) < 0) {
                MyUtils.showWarning("Invalid input", "Amount must be greater than zero.");
                return;
            }
        } catch (NumberFormatException e) {
            MyUtils.showWarning("Invalid input", "Amount is not a valid number.");
            return;
        }

        BigDecimal amountRemaining;
        try {
            amountRemaining = new BigDecimal(amountRemainingStr);
            if (amountRemaining.compareTo(BigDecimal.ZERO) < 0) {
                MyUtils.showWarning("Invalid input", "Amount must be greater than zero.");
                return;
            }
        } catch (NumberFormatException e) {
            MyUtils.showWarning("Invalid input", "Amount is not a valid number.");
            return;
        }

        BigDecimal interest = null;
        try {
            if (!interestField.getText().isBlank())
                interest = new BigDecimal(interestField.getText().trim());
        } catch (NumberFormatException e) {
            MyUtils.showWarning("Invalid input", "Remaining or Interest fields contain invalid numbers.");
            return;
        }

        if(interestStr.isEmpty()) {
            interestStr = "0.0";
        }

        Double interestRate = null;
        try {
            interestRate = Double.parseDouble(interestStr);
            if (interestRate > 100) {
                MyUtils.showWarning("Invalid input", "Interest rate cannot be greater than 100%.");
                return;
            }
            if (interestRate < 0) {
                MyUtils.showWarning("Invalid input", "Interest rate cannot be negative.");
                return;
            }
        } catch (NumberFormatException e) {
            MyUtils.showWarning("Invalid input", "Invalid interest rate format.");
            return;
        }

        // Set liability data
        liability.setName(name);
        liability.setType(type);
        liability.setAmount(amount);
        liability.setAmountRemaining(amountRemaining);
        liability.setInterestRate(BigDecimal.valueOf(interestRate));
        liability.setStartDate(startDatePicker.getValue());
        liability.setDueDate(dueDatePicker.getValue());
        liability.setActive(activeCheckBox.isSelected());
        liability.setNotes(notesArea.getText());

        try {
            LiabilityDao liabilityDao = new LiabilityDaoImpl();
            liabilityDao.updateLiability(liability, loggedUser);
        } catch (SQLException e) {
            e.printStackTrace();
            MyUtils.showWarning("Database Error", "Could not save the liability.");
            return;
        }

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
