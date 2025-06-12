package controller;

import dao.*;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import model.Achievement;
import model.Category;
import model.Transaction;
import model.User;
import utils.MyUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class TransactionFormController {

    // Expense Fields
    @FXML private TextField expenseNameField;
    @FXML private TextField expenseAmountField;
    @FXML private DatePicker expenseDatePicker;
    @FXML private ComboBox<String> expenseCategoryComboBox;
    @FXML private TextArea expenseNotesField;

    // Income Fields
    @FXML private TextField incomeNameField;
    @FXML private TextField incomeAmountField;
    @FXML private DatePicker incomeDatePicker;
    @FXML private ComboBox<String> incomeCategoryComboBox;
    @FXML private TextArea incomeNotesField;

    // Category Fields
    @FXML private TextField categoryNameField;
    @FXML private ComboBox<String> categoryTypeComboBox;

    private final CategoryDao categoryDao = new CategoryDaoImpl();
    private final TransactionDao transactionDao = new TransactionDaoImpl();
    private final UserDao userDao = new UserDaoImpl();
    private final UserAchievementDao userAchievementDao = new UserAchievementDaoImpl();
    private final AchievementDao achievementDao = new AchievementDaoImpl();

    private User currentUser;

    public void setCurrentUser(User user) {
        this.currentUser = user;
        loadExpenseCategories();
        loadIncomeCategories();

        expenseNameField.setTooltip(new Tooltip("Enter the expense name"));
        expenseAmountField.setTooltip(new Tooltip("Enter the expense amount"));
        expenseDatePicker.setTooltip(new Tooltip("Enter the expense date"));
        expenseCategoryComboBox.setTooltip(new Tooltip("Choose an expense category"));
        expenseNotesField.setTooltip(new Tooltip("Enter eventual notes on the expense"));

        incomeNameField.setTooltip(new Tooltip("Enter the income name"));
        incomeAmountField.setTooltip(new Tooltip("Enter the income amount"));
        incomeDatePicker.setTooltip(new Tooltip("Enter the income date"));
        incomeCategoryComboBox.setTooltip(new Tooltip("Choose an income category"));
        incomeNotesField.setTooltip(new Tooltip("Enter eventual notes on the income"));

        categoryNameField.setTooltip(new Tooltip("Enter the category name"));
        categoryTypeComboBox.setTooltip(new Tooltip("Choose type of category"));

    }

    @FXML
    private void handleSaveExpense() {
        String name = expenseNameField.getText();
        String amount = expenseAmountField.getText();
        String date = (expenseDatePicker.getValue() != null) ? expenseDatePicker.getValue().toString() : "";
        String category = expenseCategoryComboBox.getValue();
        String notes = expenseNotesField.getText();

        if (name.isEmpty() || amount.isEmpty() || date.isEmpty() || category == null) {
            MyUtils.showWarning("Validation warning", "Please fill in all required expense fields.");
            return;
        }

        Category cat = categoryDao.findCategorieByUserAndTypeAndName(currentUser, "expense", category);

        Transaction transaction = new Transaction();
        transaction.setDate(LocalDate.parse(date));
        transaction.setAmount(BigDecimal.valueOf(Double.parseDouble(amount)));
        transaction.setName(name);
        transaction.setDescription(notes);

        transactionDao.insert(currentUser, transaction, cat);

        checkExpensesAchievements(transaction);

        clearExpenseFields();

        MyUtils.showInfo("Expense", "Expense inserted successfully");
    }

    /**
     * All expenses related achievements
     * */
    private void checkExpensesAchievements(Transaction transaction) {
        int expensesCounter = transactionDao.countExpenses(currentUser);

        if (expensesCounter == 1) {
            tryUnlockAchievement("FIRST_EXPENSE");
        }

        if (transaction.getAmount().compareTo(BigDecimal.valueOf(100000)) >= 0) {
            tryUnlockAchievement("FIRST_BIG_EXPENSE");
        }

    }

    private void tryUnlockAchievement(String code) {
        if (!userAchievementDao.isAchievementUnlocked(currentUser, code)) {
            Achievement achievement = achievementDao.findByCode(code);
            if (achievement != null) {
                userAchievementDao.unlockAchievement(currentUser, code);
                MyUtils.showInfo(
                        "Achievement unlocked",
                        "You unlocked a new achievement!\n\n" +
                                achievement.getName() + "\n" +
                                achievement.getDescription() + "\n\n+ " +
                                achievement.getXpReward() + " XP\n+ " +
                                achievement.getPointsReward() + " DP points"
                );
                userDao.updateUserLevel(currentUser, achievement.getXpReward());
                userDao.updateUserPoints(currentUser, achievement.getPointsReward());
            }
        }
    }

    @FXML
    private void handleSaveIncome() {
        String name = incomeNameField.getText();
        String amount = incomeAmountField.getText();
        String date = (incomeDatePicker.getValue() != null) ? incomeDatePicker.getValue().toString() : "";
        String category = incomeCategoryComboBox.getValue();
        String notes = incomeNotesField.getText();

        if (name.isEmpty() || amount.isEmpty() || date.isEmpty() || category == null) {
            MyUtils.showWarning("Validation warning", "Please fill in all required income fields.");
            return;
        }


        Category cat = categoryDao.findCategorieByUserAndTypeAndName(currentUser, "income", category);

        Transaction transaction = new Transaction();
        transaction.setDate(LocalDate.parse(date));
        transaction.setAmount(BigDecimal.valueOf(Double.parseDouble(amount)));
        transaction.setName(name);
        transaction.setDescription(notes);

        transactionDao.insert(currentUser, transaction, cat);

        checkIncomesAchievements(transaction);

        clearIncomeFields();

        MyUtils.showInfo("Income", "Income inserted successfully");
    }

    private void checkIncomesAchievements(Transaction transaction) {
        int incomesCounter = transactionDao.countIncomes(currentUser);

        if (incomesCounter == 1) {
            tryUnlockAchievement("FIRST_INCOME");
        }

        if (transaction.getAmount().compareTo(BigDecimal.valueOf(100000)) >= 0) {
            tryUnlockAchievement("FIRST_BIG_INCOME");
        }
    }

    @FXML
    private void handleAddCategory() {
        String name = categoryNameField.getText();
        String type = categoryTypeComboBox.getValue();

        if (name.isEmpty() || type == null) {
            MyUtils.showWarning("Validation warning", "Please fill in both category name and type.");
            return;
        }

        Category category = new Category();
        category.setName(name);
        category.setType(type);
        categoryDao.insert(currentUser, category);

        MyUtils.showInfo("Category", "Category inserted successfully");

        categoryNameField.clear();
        categoryTypeComboBox.getSelectionModel().clearSelection();

        loadExpenseCategories();
        loadIncomeCategories();
    }

    private void clearExpenseFields() {
        expenseNameField.clear();
        expenseAmountField.clear();
        expenseDatePicker.setValue(null);
        expenseCategoryComboBox.getSelectionModel().clearSelection();
        expenseNotesField.clear();
    }

    private void clearIncomeFields() {
        incomeNameField.clear();
        incomeAmountField.clear();
        incomeDatePicker.setValue(null);
        incomeCategoryComboBox.getSelectionModel().clearSelection();
        incomeNotesField.clear();
    }

    private void loadExpenseCategories() {
        if (currentUser != null) {
            expenseCategoryComboBox.getItems().clear();

            List<Category> expenseCategories = categoryDao.findCategoriesByUserAndType(currentUser, "Expense");
            for (Category category : expenseCategories) {
                expenseCategoryComboBox.getItems().add(category.getName());
            }
        }
    }

    private void loadIncomeCategories() {
        if (currentUser != null) {
            incomeCategoryComboBox.getItems().clear();

            List<Category> incomeCategories = categoryDao.findCategoriesByUserAndType(currentUser, "Income");
            for (Category category : incomeCategories) {
                incomeCategoryComboBox.getItems().add(category.getName());
            }
        }
    }


}
