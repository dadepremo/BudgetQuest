package budgetquest.controller;

import budgetquest.dao.GoalDao.GoalDao;
import budgetquest.dao.GoalDao.GoalDaoImpl;
import budgetquest.model.Goal;
import budgetquest.model.User;
import budgetquest.utils.MyUtils;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;

public class GoalManagerController {

    @FXML private Accordion goalAccordion;

    @FXML private TextField nameField;
    @FXML private TextArea descriptionField;
    @FXML private TextField goalTypeField;
    @FXML private TextField targetAmountField;
    @FXML private TextField currentAmountField;
    @FXML private DatePicker startDatePicker;
    @FXML private DatePicker endDatePicker;
    @FXML private CheckBox completedCheckBox;
    @FXML private Button saveButton;
    @FXML private Button deleteButton;
    @FXML private Label statusLabel;

    private final GoalDao goalDao = new GoalDaoImpl();
    private User user;
    private Goal selectedGoal;

    public void setUser(User user) {
        this.user = user;
        loadGoals();
    }

    private void loadGoals() {
        List<Goal> goals = goalDao.findAllByUser(user);

        // Group by goalType
        Map<String, List<Goal>> grouped = goals.stream()
                .collect(Collectors.groupingBy(Goal::getGoalType));

        goalAccordion.getPanes().clear();

        for (Map.Entry<String, List<Goal>> entry : grouped.entrySet()) {
            String type = entry.getKey();
            VBox goalList = new VBox(10);

            for (Goal goal : entry.getValue()) {
                HBox row = createGoalRow(goal);
                goalList.getChildren().add(row);
            }

            TitledPane pane = new TitledPane(type.toUpperCase(), goalList);
            goalAccordion.getPanes().add(pane);
        }
    }

    private HBox createGoalRow(Goal goal) {
        Label name = new Label(goal.getName());
        name.setMinWidth(150);

        BigDecimal progress;

        if (goal.getTargetAmount().compareTo(BigDecimal.ZERO) > 0) {
            BigDecimal ratio = goal.getCurrentAmount()
                    .divide(goal.getTargetAmount(), 4, RoundingMode.HALF_UP); // Safe division
            progress = ratio.min(BigDecimal.ONE); // Cap at 1.0
        } else {
            progress = BigDecimal.ZERO;
        }


        ProgressBar bar = new ProgressBar(progress.doubleValue());
        bar.setPrefWidth(150);

        HBox row = new HBox(10, name, bar);
        row.setOnMouseClicked(e -> loadGoalIntoEditor(goal));
        row.setStyle("-fx-cursor: hand; -fx-padding: 5;");

        return row;
    }

    private void loadGoalIntoEditor(Goal goal) {
        selectedGoal = goal;

        nameField.setText(goal.getName());
        descriptionField.setText(goal.getDescription());
        goalTypeField.setText(goal.getGoalType());
        targetAmountField.setText(String.valueOf(goal.getTargetAmount()));
        currentAmountField.setText(String.valueOf(goal.getCurrentAmount()));
        startDatePicker.setValue(goal.getStartDate());
        endDatePicker.setValue(goal.getEndDate());
        completedCheckBox.setSelected(goal.isCompleted());

        statusLabel.setText("Editing goal: " + goal.getName());
    }

    @FXML
    private void handleSaveGoal() {
        try {
            boolean isNew = selectedGoal == null || selectedGoal.getId() == 0;

            if (selectedGoal == null) {
                selectedGoal = new Goal();
                selectedGoal.setUserId(user.getId());
            }

            if (nameField.getText().trim().isEmpty()) {
                MyUtils.showWarning("Validation error", "Please insert a name");
                return;
            }

            if (goalTypeField.getText().trim().isEmpty()) {
                MyUtils.showWarning("Validation error", "Please insert a type");
                return;
            }

            if (targetAmountField.getText().trim().isEmpty()) {
                MyUtils.showWarning("Validation error", "Please insert an amount");
            }

            BigDecimal amount;
            try {
                amount = new BigDecimal(targetAmountField.getText());
                if (amount.compareTo(BigDecimal.ZERO) < 0) {
                    MyUtils.showWarning("Validation error", "The amount must be grater than 0");
                    return;
                }
            } catch (Exception e) {
                MyUtils.showWarning("Validation error", "The amount must be a number");
                return;
            }

            BigDecimal currentAmount;
            try {
                currentAmount = new BigDecimal(targetAmountField.getText());
                if (currentAmount.compareTo(BigDecimal.ZERO) < 0) {
                    MyUtils.showWarning("Validation error", "The target amount must be grater than 0");
                    return;
                } else if (currentAmount.compareTo(BigDecimal.ZERO) == 0) {
                    currentAmount = amount;
                }
            } catch (Exception e) {
                MyUtils.showWarning("Validation error", "The target amount must be a number");
                return;
            }

            if (endDatePicker.getValue() == null || startDatePicker.getValue() == null) {
                MyUtils.showWarning("Validation error", "Please insert the start and end date");
                return;
            }

            selectedGoal.setName(nameField.getText());
            selectedGoal.setDescription(descriptionField.getText());
            selectedGoal.setGoalType(goalTypeField.getText());
            selectedGoal.setTargetAmount(amount);
            selectedGoal.setCurrentAmount(currentAmount);
            selectedGoal.setStartDate(startDatePicker.getValue());
            selectedGoal.setEndDate(endDatePicker.getValue());
            selectedGoal.setCompleted(completedCheckBox.isSelected());
            selectedGoal.setDeleted(false); // Make sure it's not marked deleted

            if (isNew) {
                goalDao.create(selectedGoal); // INSERT
                MyUtils.showInfo("Goals", "Goal created!");
            } else {
                goalDao.update(selectedGoal); // UPDATE
                MyUtils.showInfo("Goals", "Goal updated!");
            }

            clearEditor();
            loadGoals();
        } catch (Exception e) {
            MyUtils.showWarning("Goals", "Couldn't save goal");
            e.printStackTrace();
        }
    }

    @FXML
    private void handleDeleteGoal() {
        if (selectedGoal == null) return;

        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle("Confirm Deletion");
        alert.setHeaderText("Are you sure you want to delete this goal?");
        alert.setContentText("Goal: " + selectedGoal.getName());

        Optional<ButtonType> result = alert.showAndWait();
        if (result.isPresent() && result.get() == ButtonType.OK) {
            goalDao.delete(selectedGoal.getId());
            statusLabel.setText("Goal deleted.");
            clearEditor();
            loadGoals();
        } else {
            statusLabel.setText("Deletion canceled.");
        }
    }

    private void clearEditor() {
        nameField.clear();
        descriptionField.clear();
        goalTypeField.clear();
        targetAmountField.clear();
        currentAmountField.clear();
        startDatePicker.setValue(null);
        endDatePicker.setValue(null);
        completedCheckBox.setSelected(false);
        selectedGoal = null;
        statusLabel.setText("");
    }
}
