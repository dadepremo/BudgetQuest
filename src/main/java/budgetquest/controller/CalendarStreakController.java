package budgetquest.controller;

import budgetquest.dao.LoginHistoryDao.LoginHistoryDaoImpl;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.geometry.Pos;
import budgetquest.dao.LoginHistoryDao.LoginHistoryDao;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.TextStyle;
import java.util.*;

public class CalendarStreakController {

    @FXML private GridPane calendarGrid;
    @FXML private Label monthLabel;
    @FXML private Button prevMonthButton, nextMonthButton;

    private final LoginHistoryDao loginHistoryDao = new LoginHistoryDaoImpl(); // implement this
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

        // Day headers
        // Day headers
        String[] days = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
        for (int i = 0; i < days.length; i++) {
            Label header = new Label(days[i]);
            header.setPrefSize(60, 30);
            header.setAlignment(Pos.CENTER);

            // Style Sunday in red
            if (i == 6) {
                header.setStyle("-fx-background-color: #d63a3a; -fx-text-fill: white; -fx-font-weight: bold; -fx-background-radius: 6;");
            } else {
                header.setStyle("-fx-background-color: #3b82f6; -fx-text-fill: white; -fx-font-weight: bold; -fx-background-radius: 6;");
            }

            calendarGrid.add(header, i, 0);
        }


        LocalDate today = LocalDate.now();

        for (int day = 1; day <= daysInMonth; day++) {
            LocalDate date = currentMonth.atDay(day);
            Label dayLabel = new Label(String.valueOf(day));
            dayLabel.setPrefSize(60, 60);
            dayLabel.setAlignment(Pos.CENTER);
            dayLabel.setStyle("-fx-background-color: #f3f4f6; -fx-border-color: #e5e7eb; -fx-border-radius: 8; -fx-background-radius: 8;");

            if (loginDates.contains(date)) {
                dayLabel.setStyle(dayLabel.getStyle() +
                        "-fx-background-color: #fdbe8a; -fx-effect: dropshadow(two-pass-box, #f97316, 5, 0, 0, 0);");
            }

            if (date.equals(today)) {
                dayLabel.setStyle(dayLabel.getStyle() +
                        "-fx-border-color: #2563eb; -fx-border-width: 2; -fx-font-weight: bold;");
            }

            int col = (firstWeekday + day - 2) % 7;
            int row = ((firstWeekday + day - 2) / 7) + 1;
            calendarGrid.add(dayLabel, col, row);
        }
    }

}
