package budgetquest.controller;

import budgetquest.dao.TransactionDao.TransactionDao;
import budgetquest.dao.TransactionDao.TransactionDaoImpl;
import budgetquest.model.Transaction;
import budgetquest.model.User;
import budgetquest.utils.MyUtils;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.stage.Stage;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;

public class TransactionEditorController {

    private static final Logger logger = LogManager.getLogger(TransactionEditorController.class);

    @FXML private TextField nameField;
    @FXML private TextField amountField;
    @FXML private DatePicker datePicker;
    @FXML private TextArea notesArea;
    @FXML private Label titleLabel;

    private Transaction transaction;
    private User loggedUser;
    private String transactionType; // "income" or "expense"


    public void setTransaction(Transaction transaction, User user, String type) {
        this.transaction = transaction;
        this.loggedUser = user;
        this.transactionType = type;

        titleLabel.setText(type.equals("income") ? "Edit Income" : "Edit Expense");
        amountField.setText(transaction.getAmount() != null ? transaction.getAmount().toPlainString() : "");
        nameField.setText(transaction.getName());
        datePicker.setValue(transaction.getDate() != null ? transaction.getDate() : LocalDate.now());
        notesArea.setText(transaction.getDescription());
    }

    @FXML
    private void handleSave() {
        String name = nameField.getText().trim();
        String amountStr = amountField.getText().trim();

        if (loggedUser == null) {
            MyUtils.showWarning("Credentials error", "No user logged in.");
            return;
        }

        if (name.isEmpty()) {
            MyUtils.showWarning("Invalid value", "Please insert a name.");
            return;
        }

        if (amountStr.isEmpty()) {
            MyUtils.showWarning("Invalid value", "Please enter the amount.");
            return;
        }

        BigDecimal amount;
        try {
            amount = new BigDecimal(amountStr);
        } catch (NumberFormatException e) {
            MyUtils.showWarning("Invalid input", "Amount must be a number.");
            return;
        }

        if (amount.compareTo(BigDecimal.ZERO) < 0) {
            MyUtils.showWarning("Invalid input", "Amount must be non-negative.");
            return;
        }


        transaction.setName(name);
        transaction.setAmount(amount);
        transaction.setDate(datePicker.getValue());
        transaction.setDescription(notesArea.getText());
        transaction.setUserId(loggedUser.getId());

        try {
            TransactionDao transactionDao = new TransactionDaoImpl();
            transactionDao.updateTransaction(transaction);
        } catch (SQLException e) {
            MyUtils.showError("Database Error", "Could not save transaction.");
            e.printStackTrace();
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
