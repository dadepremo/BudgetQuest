package budgetquest.controller;

import budgetquest.dao.*;
import budgetquest.model.Liability;
import budgetquest.model.User;
import budgetquest.utils.MyUtils;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Objects;

public class LiabilityFormController {

    private static final Logger logger = LogManager.getLogger(LiabilityFormController.class);

    @FXML private VBox rootVBox;

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

    private final XpGiverDao xpGiverDao = new XpGiverDaoImpl();
    private final UserDao userDao = new UserDaoImpl();
    private final int normalLiabilityBonus = xpGiverDao.getValueByName("normalLiabilityBonus");

    private User loggedUser;

    public void setUser(User user) {
        this.loggedUser = user;
        if ("light".equals(user.getTheme())) {
            switchToLightTheme();
        } else if ("dark".equals(user.getTheme())) {
            switchToDarkTheme();
        }
    }

    @FXML
    private void handleSaveLiability() {
        if (loggedUser == null) {
            MyUtils.showError("Authorization Error", "No user is currently logged in.");
            return;
        }

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

        Liability liability = new Liability();
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
        liability.setCreatedAt(LocalDateTime.now());
        liability.setLastUpdated(LocalDateTime.now());

        LiabilityDao liabilityDao = new LiabilityDaoImpl();
        boolean saved = liabilityDao.insert(liability, loggedUser.getId());

        if (saved) {
            MyUtils.showInfo("Success", "Liability saved successfully!");
            userDao.updateUserLevel(loggedUser, normalLiabilityBonus);
            clearForm();
        } else {
            MyUtils.showError("Error", "Error saving liability.");
        }
    }

    private String getSafeText(TextField field) {
        return field.getText() != null ? field.getText().trim() : null;
    }

    private void clearForm() {
        nameField.clear();
        typeField.clear();
        amountField.clear();
        amountRemainingField.clear();
        interestRateField.clear();
        startDatePicker.setValue(null);
        dueDatePicker.setValue(null);
        notesArea.clear();
        paymentFrequencyField.clear();
        nextPaymentDuePicker.setValue(null);
        minimumPaymentField.clear();
        monthlyPaymentField.clear();
        liabilityStatusField.clear();
        categoryField.clear();
        totalPaidField.clear();
        lastPaymentDatePicker.setValue(null);
        creditorNameField.clear();
        creditorContactField.clear();
        reminderEnabledCheckBox.setSelected(false);
        reminderDaysBeforeField.clear();
    }

    public void switchToDarkTheme() {
        rootVBox.getStylesheets().clear();
        rootVBox.getStylesheets().add(Objects.requireNonNull(getClass().getResource("/style/liability_form_dark.css")).toExternalForm());
    }

    public void switchToLightTheme() {
        rootVBox.getStylesheets().clear();
        rootVBox.getStylesheets().add(Objects.requireNonNull(getClass().getResource("/style/liability_form_light.css")).toExternalForm());
    }
}
