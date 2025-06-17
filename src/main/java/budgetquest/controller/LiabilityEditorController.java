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
import java.time.LocalDate;
import java.time.LocalDateTime;

public class LiabilityEditorController {

    @FXML private TextField nameField;
    @FXML private TextField typeField;
    @FXML private TextField amountField;
    @FXML private TextField amountRemainingField;
    @FXML private TextField interestRateField;
    @FXML private DatePicker startDatePicker;
    @FXML private DatePicker dueDatePicker;
    @FXML private TextArea notesArea;
    @FXML private TextField paymentFrequencyField;
    @FXML private DatePicker nextPaymentDuePicker;
    @FXML private TextField minimumPaymentField;
    @FXML private TextField monthlyPaymentField;
    @FXML private TextField liabilityStatusField;
    @FXML private TextField categoryField;
    @FXML private TextField totalPaidField;
    @FXML private DatePicker lastPaymentDatePicker;
    @FXML private TextField creditorNameField;
    @FXML private TextField creditorContactField;
    @FXML private CheckBox reminderEnabledCheckBox;
    @FXML private TextField reminderDaysBeforeField;

    private Liability liability;
    private User loggedUser;

    public void setLiability(Liability liability, User user) {
        this.liability = liability;
        this.loggedUser = user;

        nameField.setText(liability.getName());
        typeField.setText(liability.getType());
        amountField.setText(liability.getAmount() != null ? liability.getAmount().toPlainString() : "");
        amountRemainingField.setText(liability.getAmountRemaining() != null ? liability.getAmountRemaining().toPlainString() : "");
        interestRateField.setText(liability.getInterestRate() != null ? liability.getInterestRate().toPlainString() : "");
        startDatePicker.setValue(liability.getStartDate());
        dueDatePicker.setValue(liability.getDueDate());
        notesArea.setText(liability.getNotes());

        paymentFrequencyField.setText(liability.getPaymentFrequency());
        nextPaymentDuePicker.setValue(liability.getNextPaymentDue());
        minimumPaymentField.setText(liability.getMinimumPayment().toPlainString());
        monthlyPaymentField.setText(liability.getMonthlyPayment().toPlainString());
        liabilityStatusField.setText(liability.getLiabilityStatus());
        categoryField.setText(liability.getCategory());
        totalPaidField.setText(liability.getTotalPaid().toPlainString());
        lastPaymentDatePicker.setValue(liability.getLastPaymentDate());
        creditorNameField.setText(liability.getCreditorName());
        creditorContactField.setText(liability.getCreditorContact());
        reminderEnabledCheckBox.setSelected(liability.isReminderEnabled());
        reminderDaysBeforeField.setText(liability.getReminderDaysBefore().toString());
    }

    @FXML
    private void handleSave() {
        String name = nameField.getText().trim();
        String type = typeField.getText().trim();

        // name checks
        if (name.isEmpty()) {
            MyUtils.showWarning("Validation error", "Liability name is required.");
            return;
        }

        // type checks
        if (type.isEmpty()) {
            MyUtils.showWarning("Validation error", "Liability type is required.");
            return;
        }

        // amount checks
        BigDecimal amount;
        if (amountField.getText().trim().isEmpty()) {
            MyUtils.showWarning("Validation error", "Liability amount is required.");
            return;
        }
        try {
            amount = new BigDecimal(amountField.getText().trim());
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                MyUtils.showWarning("Validation error", "Liability amount must be greater than 0.");
                return;
            }
        } catch (NumberFormatException e) {
            MyUtils.showWarning("Validation error", "Invalid number format for liability amount.");
            return;
        }

        // remaining amount checks
        BigDecimal amountRemaining;
        if (!amountRemainingField.getText().trim().isEmpty()) {
            try {
                amountRemaining = new BigDecimal(amountRemainingField.getText().trim());
                if (amountRemaining.compareTo(amount) > 0) {
                    MyUtils.showWarning("Validation error", "Remaining amount can't be greater than amount.");
                    return;
                } else if ((amountRemaining.compareTo(BigDecimal.ZERO) < 0)) {
                    MyUtils.showWarning("Validation error", "Remaining amount can't be less than 0.");
                    return;
                }
            } catch (NumberFormatException e) {
                MyUtils.showWarning("Validation error", "Invalid number format for liability remaining amount.");
                return;
            }
        } else {
            amountRemaining = amount;
        }

        // interest rate checks
        BigDecimal interestRate;
        if (!interestRateField.getText().trim().isEmpty()) {
            try {
                interestRate = new BigDecimal(interestRateField.getText().trim());
                if (interestRate.compareTo(BigDecimal.ZERO) <= 0 || interestRate.compareTo(BigDecimal.valueOf(100)) > 0) {
                    MyUtils.showWarning("Validation error", "Interest rate must be 0% or greater and less than 100%");
                    return;
                }
            } catch (NumberFormatException e) {
                MyUtils.showWarning("Validation error", "Invalid number format for liability interest rate.");
                return;
            }
        } else {
            interestRate = BigDecimal.ZERO;
        }

        // min payment checks
        BigDecimal minPayment;
        if (!minimumPaymentField.getText().trim().isEmpty()) {
            try {
                minPayment = new BigDecimal(minimumPaymentField.getText().trim());
                if (minPayment.compareTo(BigDecimal.ZERO) < 0) {
                    MyUtils.showWarning("Validation error", "Minimum payment must be positive.");
                    return;
                }
            } catch (NumberFormatException e) {
                MyUtils.showWarning("Validation error", "Invalid number format for liability minimum payment.");
                return;
            }
        } else {
            minPayment = BigDecimal.ZERO;
        }

        // monthly payment checks
        BigDecimal monthlyPayment;
        if (!monthlyPaymentField.getText().trim().isEmpty()) {
            try {
                monthlyPayment = new BigDecimal(monthlyPaymentField.getText().trim());
                if (monthlyPayment.compareTo(BigDecimal.ZERO) < 0) {
                    MyUtils.showWarning("Validation error", "Monthly payment must be positive.");
                    return;
                }
            } catch (NumberFormatException e) {
                MyUtils.showWarning("Validation error", "Monthly number format for liability monthly payment.");
                return;
            }
        } else {
            monthlyPayment = BigDecimal.ZERO;
        }

        // total paid checks
        BigDecimal totalPaid;
        if (!totalPaidField.getText().trim().isEmpty()) {
            try {
                totalPaid = new BigDecimal(totalPaidField.getText().trim());
                if (totalPaid.compareTo(BigDecimal.ZERO) < 0) {
                    MyUtils.showWarning("Validation error", "Total paid must be positive.");
                    return;
                } else if (totalPaid.compareTo(amount.subtract(amountRemaining)) < 0) {
                    MyUtils.showWarning("Validation error", "Total paid can't be less than what you already paid.");
                    return;
                }
            } catch (NumberFormatException e) {
                MyUtils.showWarning("Validation error", "Monthly number format for liability total paid.");
                return;
            }
        } else {
            totalPaid = amount.subtract(amountRemaining);
        }

        // reminder days checks
        int reminderDays = 0;
        if (!reminderDaysBeforeField.getText().trim().isEmpty()) {
            try {
                reminderDays = Integer.parseInt(reminderDaysBeforeField.getText().trim());
                if (reminderDays < 0) {
                    MyUtils.showWarning("Validation error", "The count must be positive.");
                    return;
                }
            } catch (NumberFormatException e) {
                MyUtils.showWarning("Validation error", "The count must be an integer.");
                return;
            }
        }


        LocalDate startDate = startDatePicker.getValue();
        LocalDate dueDate = dueDatePicker.getValue();

        if (startDate != null && dueDate != null && dueDate.isBefore(startDate)) {
            MyUtils.showWarning("Validation error", "Due Date cannot be before Start Date.");
            return;
        }

        liability.setUserId(loggedUser.getId());
        liability.setName(name);
        liability.setType(type);
        liability.setAmount(amount);
        liability.setAmountRemaining(amountRemaining);
        liability.setInterestRate(interestRate);
        liability.setStartDate(startDate);
        liability.setDueDate(dueDate);
        liability.setNotes(notesArea.getText());
        liability.setPaymentFrequency(getSafeText(paymentFrequencyField));
        liability.setNextPaymentDue(nextPaymentDuePicker.getValue());
        liability.setMinimumPayment(minPayment);
        liability.setMonthlyPayment(monthlyPayment);
        liability.setLiabilityStatus(getSafeText(liabilityStatusField));
        liability.setCategory(getSafeText(categoryField));
        liability.setTotalPaid(totalPaid);
        liability.setLastPaymentDate(lastPaymentDatePicker.getValue());
        liability.setCreditorName(getSafeText(creditorNameField));
        liability.setCreditorContact(getSafeText(creditorContactField));
        liability.setReminderEnabled(reminderEnabledCheckBox.isSelected());
        liability.setReminderDaysBefore(reminderDays);
        liability.setActive(true);
        liability.setDeleted(false);
        liability.setLastUpdated(LocalDateTime.now());

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

    private String getSafeText(TextField field) {
        return field.getText() != null ? field.getText().trim() : null;
    }

}
