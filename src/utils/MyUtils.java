package utils;

import javafx.scene.control.Alert;
import javafx.scene.control.ChoiceDialog;
import javafx.scene.control.TextInputDialog;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

public class MyUtils {

    /**
     * This method formats a double number to be displayed with normal currency display rules.
     * @param amount the amount to be displayed with formatting
     * @return String of the formatted amount as currency number
     */
    public static String formatCurrency(double amount, String symbol) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');  // thousands separator
        symbols.setDecimalSeparator(',');   // decimal separator
        DecimalFormat formatter = new DecimalFormat("#,##0.00", symbols);
        return formatter.format(amount) + " " + symbol;
    }

    public static String formatCurrency(BigDecimal amount, String symbol) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');  // thousands separator
        symbols.setDecimalSeparator(',');   // decimal separator
        DecimalFormat formatter = new DecimalFormat("#,##0.00", symbols);
        return formatter.format(amount) + " " + symbol;
    }

    public static String formatDpPoints(int points) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.'); // Use dot as thousands separator
        DecimalFormat formatter = new DecimalFormat("#,##0", symbols);
        return formatter.format(points) + " DP";
    }

    public static void showWarning(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.WARNING);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    public static void showInfo(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    public static void showError(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    public static void showConfirmation(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    public static String showUserTextInput(String title, String defaultValue, String prompt) {
        TextInputDialog dialog = new TextInputDialog(defaultValue);
        dialog.setTitle(title);
        dialog.setHeaderText(prompt);
        Optional<String> result = dialog.showAndWait();
        return result.orElse("");
    }

    public static String showUserChoiceInput(String title, String header, List<String> options, String optionsFieldName) {
        ChoiceDialog<String> dialog = new ChoiceDialog<>(optionsFieldName, options);
        dialog.setTitle(title);
        dialog.setHeaderText(header);
        Optional<String> result = dialog.showAndWait();
        return result.orElse("");
    }

    public static String localDateFormattedDisplay(LocalDate localDate) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return localDate.format(formatter);
    }

    public static String localDateTimeFormattedDisplay(LocalDateTime localDateTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        return localDateTime.format(formatter);
    }

}
