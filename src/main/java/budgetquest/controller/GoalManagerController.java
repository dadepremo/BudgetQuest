package budgetquest.controller;

import budgetquest.dao.GoalDao.GoalDao;
import budgetquest.dao.GoalDao.GoalDaoImpl;
import budgetquest.model.Goal;
import budgetquest.model.User;
import budgetquest.utils.MyUtils;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URL;
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

        Platform.runLater(() -> {
            Scene scene = nameField.getScene();
            if (scene != null) {
                try {
                    URL cssUrl = getClass().getResource("/style/goals_light.css");
                    if (cssUrl != null) {
                        scene.getStylesheets().clear();
                        scene.getStylesheets().add(cssUrl.toExternalForm());
                    } else {
                        System.err.println("CSS file not found: /style/goals_light.css");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

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
            goalList.setFillWidth(true);
            goalList.setStyle("-fx-padding: 10;");

            for (Goal goal : entry.getValue()) {
                HBox row = createGoalRow(goal);
                goalList.getChildren().add(row);
            }

            ScrollPane scrollPane = new ScrollPane(goalList);
            scrollPane.setFitToWidth(true);
            scrollPane.setPrefHeight(300);
            scrollPane.setStyle("-fx-background-color: transparent;");

            TitledPane pane = new TitledPane(type.toUpperCase(), scrollPane);
            pane.setStyle("-fx-font-size: 16px; -fx-font-weight: bold;");
            goalAccordion.getPanes().add(pane);

        }
    }


    private HBox createGoalRow(Goal goal) {
        Label name = new Label(goal.getName());
        name.setStyle("-fx-font-size: 19px; -fx-font-weight: bold;");

        BigDecimal progress;
        BigDecimal target = goal.getTargetAmount();
        BigDecimal current = goal.getCurrentAmount();

        if (target.compareTo(BigDecimal.ZERO) > 0) {
            BigDecimal ratio = current.divide(target, 4, RoundingMode.HALF_UP);
            progress = ratio.min(BigDecimal.ONE);
        } else {
            progress = BigDecimal.ZERO;
        }

        ProgressBar progressBar = new ProgressBar(progress.doubleValue());
        progressBar.setPrefWidth(250);
        progressBar.setStyle("-fx-accent: #4CAF50;"); // verde moderno

        double percentage = target.compareTo(BigDecimal.ZERO) > 0
                ? current.divide(target, 4, RoundingMode.HALF_UP).multiply(BigDecimal.valueOf(100)).doubleValue()
                : 0.0;

        Label amount = new Label(
                MyUtils.formatCurrency(current, user.getCurrencySymbol()) +
                        " / " +
                        MyUtils.formatCurrency(target, user.getCurrencySymbol()) +
                        String.format(" (%.1f%%)", Math.min(percentage, 100.0))
        );

        amount.setStyle("-fx-text-fill: #777; -fx-font-size: 13px;");

        VBox textSection = new VBox(5, name, amount, progressBar);
        textSection.setStyle("-fx-padding: 10;");

        HBox row = new HBox(textSection);
        row.setStyle("-fx-background-color: #f4f4f4; -fx-border-radius: 10px; -fx-background-radius: 10px; -fx-padding: 10px; -fx-cursor: hand;");
        row.setOnMouseEntered(e -> row.setStyle("-fx-background-color: #e0e0e0; -fx-border-radius: 10px; -fx-background-radius: 10px; -fx-padding: 10px; -fx-cursor: hand;"));
        row.setOnMouseExited(e -> row.setStyle("-fx-background-color: #f4f4f4; -fx-border-radius: 10px; -fx-background-radius: 10px; -fx-padding: 10px; -fx-cursor: hand;"));
        row.setOnMouseClicked(e -> loadGoalIntoEditor(goal));

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
