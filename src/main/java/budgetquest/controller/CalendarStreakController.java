package budgetquest.controller;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.geometry.Pos;
import budgetquest.dao.LoginHistoryDao;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.TextStyle;
import java.util.*;

public class CalendarStreakController {

    @FXML private GridPane calendarGrid;
    @FXML private Label monthLabel;
    @FXML private Button prevMonthButton, nextMonthButton;

    private final LoginHistoryDao loginHistoryDao = new LoginHistoryDao(); // implement this
    private int userId;
    private YearMonth currentMonth = YearMonth.now();

    public void setUserId(int userId) {
        this.userId = userId;
        updateCalendar();
    }

    @FXML
    public void initialize() {
        prevMonthButton.setOnAction(e -> {
            currentMonth = currentMonth.minusMonths(1);
            updateCalendar();
        });

        nextMonthButton.setOnAction(e -> {
            currentMonth = currentMonth.plusMonths(1);
            updateCalendar();
        });
    }

    private void updateCalendar() {
        List<LocalDate> loginDates = loginHistoryDao.getLoginDatesForUser(userId);
        calendarGrid.getChildren().clear();

        monthLabel.setText(currentMonth.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH) + " " + currentMonth.getYear());

        LocalDate firstDay = currentMonth.atDay(1);
        int daysInMonth = currentMonth.lengthOfMonth();
        int firstWeekday = firstDay.getDayOfWeek().getValue(); // 1 = Monday

        // Add day headers
        String[] days = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
        for (int i = 0; i < days.length; i++) {
            Label header = new Label(days[i]);
            header.setStyle("-fx-font-weight: bold;");
            calendarGrid.add(header, i, 0);
        }

        LocalDate today = LocalDate.now();

        for (int day = 1; day <= daysInMonth; day++) {
            LocalDate date = currentMonth.atDay(day);
            Label dayLabel = new Label(String.valueOf(day));
            dayLabel.setPrefSize(60, 60);
            dayLabel.setAlignment(Pos.CENTER);
            dayLabel.setStyle("-fx-border-color: #ccc; -fx-background-radius: 4;");

            if (loginDates.contains(date)) {
                dayLabel.setStyle(dayLabel.getStyle() + "-fx-background-color: lightgreen;");
            }

            if (date.equals(today)) {
                dayLabel.setStyle(dayLabel.getStyle() +
                        "-fx-border-color: green; " +
                        "-fx-border-width: 2; " +
                        "-fx-border-radius: 3;");
            }

            int col = (firstWeekday + day - 2) % 7;
            int row = ((firstWeekday + day - 2) / 7) + 1;
            calendarGrid.add(dayLabel, col, row);
        }


    }
}
