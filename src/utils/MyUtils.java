package utils;

import javafx.animation.AnimationTimer;
import javafx.animation.KeyFrame;
import javafx.animation.PauseTransition;
import javafx.animation.Timeline;
import javafx.scene.control.*;
import javafx.util.Duration;

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

    public static String formatInt(int number) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.'); // Use dot as thousands separator
        DecimalFormat formatter = new DecimalFormat("#,##0", symbols);
        return formatter.format(number);
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

    public static Tooltip createInstantTooltip(String text) {
        Tooltip tooltip = new Tooltip(text);
        tooltip.setShowDelay(Duration.ZERO);
        tooltip.setHideDelay(Duration.ZERO);
        tooltip.setShowDuration(Duration.seconds(10));
        return tooltip;
    }

    public static void animateTyping(Label targetLabel, String text, Duration delayBetweenChars, Duration initialDelay) {
        targetLabel.setText("");

        // Wrap the animation in a Timeline
        Timeline timeline = new Timeline();

        for (int i = 0; i <= text.length(); i++) {
            final String partial = text.substring(0, i);
            KeyFrame keyFrame = new KeyFrame(
                    delayBetweenChars.multiply(i),
                    e -> targetLabel.setText(partial)
            );
            timeline.getKeyFrames().add(keyFrame);
        }

        // Pause first, then start the animation
        PauseTransition pause = new PauseTransition(initialDelay);
        pause.setOnFinished(e -> timeline.play());
        pause.play();
    }

    public static void animateNumber(Label targetLabel, double targetValue, Duration duration, boolean isInteger, String suffix, Duration startDelay) {
        double startValue = 0;
        int framesPerSecond = 60;
        int totalFrames = (int) (duration.toMillis() / (1000.0 / framesPerSecond));
        Timeline timeline = new Timeline();

        for (int i = 0; i <= totalFrames; i++) {
            double progress = (double) i / totalFrames;
            double currentValue = startValue + (targetValue - startValue) * progress;

            KeyFrame keyFrame = new KeyFrame(
                    Duration.millis(i * (1000.0 / framesPerSecond)),
                    e -> {
                        String text;
                        if ("DP".equals(suffix) && isInteger) {
                            // Use custom formatting for DP points
                            text = formatDpPoints((int) currentValue);
                        } else if ("EUR".equals(suffix) && !isInteger) {
                            text = formatCurrency(currentValue, "€");
                        } else if ("USD".equals(suffix) && !isInteger) {
                            text = formatCurrency(currentValue, "$");
                        } else if ("AED".equals(suffix) && !isInteger) {
                            text = formatCurrency(currentValue, "د.إ");
                        } else if ("JPY".equals(suffix) && !isInteger) {
                            text = formatCurrency(currentValue, "¥");
                        } else {
                            // Default formatting
                            text = isInteger
                                    ? ((int) currentValue) + suffix
                                    : String.format("%.2f%s", currentValue, suffix);
                        }
                        targetLabel.setText(text);
                    }
            );
            timeline.getKeyFrames().add(keyFrame);
        }

        PauseTransition delay = new PauseTransition(startDelay);
        delay.setOnFinished(e -> timeline.play());
        delay.play();
    }



    public static void animateInteger(Label targetLabel, int targetValue, Duration duration, String suffix, Duration delay) {
        final long startDelay = (long) delay.toMillis();
        final long animationDuration = (long) duration.toMillis();

        AnimationTimer timer = new AnimationTimer() {
            private long startTime = -1;

            @Override
            public void handle(long now) {
                if (startTime < 0) {
                    startTime = now;
                    return;
                }

                long elapsedMillis = (now - startTime) / 1_000_000;

                if (elapsedMillis < startDelay) {
                    // waiting for delay to finish, don't update yet
                    return;
                }

                long animationElapsed = elapsedMillis - startDelay;
                if (animationElapsed >= animationDuration) {
                    targetLabel.setText(targetValue + suffix);
                    stop();
                    return;
                }

                double progress = (double) animationElapsed / animationDuration;
                int currentValue = (int) (progress * targetValue);
                targetLabel.setText(currentValue + suffix);
            }
        };

        timer.start();
    }




}
