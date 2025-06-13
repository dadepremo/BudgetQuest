package controller;

import dao.*;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import model.Liability;
import model.User;
import utils.Logger;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class LiabilityFormController {

    @FXML private TextField nameField;
    @FXML private TextField typeField;
    @FXML private TextField amountField;
    @FXML private TextField interestRateField;
    @FXML private DatePicker startDatePicker;
    @FXML private DatePicker dueDatePicker;
    @FXML private TextArea notesArea;
    @FXML private Label statusLabel;
    @FXML private VBox rootVBox;

    private XpGiverDao xpGiverDao = new XpGiverDaoImpl();
    private int normalLiabilityBonus = xpGiverDao.getValueByName("normalLiabilityBonus");

    private User loggedUser;
    private UserDao userDao = new UserDaoImpl();

    public void setUser(User user) {
        this.loggedUser = user;
        if (user.getTheme().equals("light")) {
            switchToLightTheme();
        } else if (user.getTheme().equals("dark")){
            switchToDarkTheme();
        }
    }

    @FXML
    private void handleSaveLiability() {
        statusLabel.setTextFill(Color.BLACK);
        statusLabel.setText("");

        String name = nameField.getText().trim();
        String type = typeField.getText().trim();
        String amountStr = amountField.getText().trim();
        String interestStr = interestRateField.getText().trim();
        LocalDate startDate = startDatePicker.getValue();
        LocalDate dueDate = dueDatePicker.getValue();
        String notes = notesArea.getText().trim();


        if (loggedUser == null) {
            statusLabel.setText("No user logged in.");
            Logger.warn("No user logged in");
            return;
        }

        if (name.isEmpty()) {
            statusLabel.setTextFill(Color.RED);
            statusLabel.setText("Please enter the liability name.");
            return;
        }

        if (type.isEmpty()) {
            statusLabel.setTextFill(Color.RED);
            statusLabel.setText("Please enter the liability type.");
            return;
        }

        if (amountStr.isEmpty()) {
            statusLabel.setTextFill(Color.RED);
            statusLabel.setText("Please enter the amount.");
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

        if(interestStr.isEmpty()) {
            interestStr = "0.0";
        }

        Double interestRate = null;
        try {
            interestRate = Double.parseDouble(interestStr);
            if (interestRate > 100) {
                statusLabel.setTextFill(Color.RED);
                statusLabel.setText("Interest rate cannot be greater than 100%.");
                return;
            }
            if (interestRate < 0) {
                statusLabel.setTextFill(Color.RED);
                statusLabel.setText("Interest rate cannot be negative.");
                return;
            }
        } catch (NumberFormatException e) {
            statusLabel.setTextFill(Color.RED);
            statusLabel.setText("Invalid interest rate format.");
            return;
        }

        if (startDate != null && dueDate != null && dueDate.isBefore(startDate)) {
            statusLabel.setTextFill(Color.RED);
            statusLabel.setText("Due Date cannot be before Start Date.");
            return;
        }

        try {


            Liability liability = new Liability();
            liability.setUserId(loggedUser.getId());
            liability.setName(nameField.getText());
            liability.setType(typeField.getText());
            liability.setAmount(BigDecimal.valueOf(amount));
            liability.setInterestRate(BigDecimal.valueOf(interestRate == null ? 0.0 : interestRate));
            liability.setStartDate(startDate);
            liability.setDueDate(dueDate);
            liability.setNotes(notesArea.getText());
            liability.setActive(true);
            liability.setAmountRemaining(BigDecimal.valueOf(amount));
            liability.setCreatedAt(LocalDateTime.now());
            liability.setDeleted(false);
            liability.setLastUpdated(LocalDateTime.now());

            LiabilityDao liabilityDao = new LiabilityDaoImpl();
            boolean saved = liabilityDao.insert(liability);
            if(saved) {
                Logger.info("Liability saved successfully");
                statusLabel.setText("Liability saved successfully!");
                userDao.updateUserLevel(loggedUser, normalLiabilityBonus);
            } else {
                Logger.info("Error saving liability");
                statusLabel.setText("Error saving liability.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            statusLabel.setText("Invalid input or system error.");
            Logger.error("Invalid input or system error", (IOException) e);
        }

        statusLabel.setTextFill(Color.GREEN);
        statusLabel.setText("Liability saved successfully!");

        clearForm();
    }

    public void switchToDarkTheme() {
        rootVBox.getStylesheets().clear();
        rootVBox.getStylesheets().add(getClass().getResource("/style/liability_form_dark.css").toExternalForm());
    }

    public void switchToLightTheme() {
        rootVBox.getStylesheets().clear();
        rootVBox.getStylesheets().add(getClass().getResource("/style/liability_form_light.css").toExternalForm());
    }

    private void clearForm() {
        nameField.clear();
        typeField.clear();
        amountField.clear();
        interestRateField.clear();
        startDatePicker.setValue(null);
        dueDatePicker.setValue(null);
        notesArea.clear();
    }
}
