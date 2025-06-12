package utils;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @author Davide Premoli <br><br>
 * Used to log information you want to display for debugging purposes.
 * Logs will be visualized in the terminal, and they will not be visible in the application.
 *
 */
public class Logger {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private static final String RESET = "\u001B[0m";
    private static final String BLUE = "\u001B[34m";
    private static final String YELLOW = "\u001B[33m";
    private static final String RED = "\u001B[31m";
    private static final String CYAN = "\u001B[36m";
    private static final String BLACK = "\u001B[30m";
    private static final String GREEN = "\u001B[32m";
    private static final String PURPLE = "\u001B[35m";
    private static final String WHITE = "\u001B[37m";


    private static void log(String level, String color, String message) {
        String timestamp = LocalDateTime.now().format(FORMATTER);
        System.out.println(color + "[" + timestamp + "] " + level + " " + message + RESET);
    }

    public static void info(String message) {
        log("[INFO]", GREEN, message);
    }

    public static void warn(String message) {
        log("[WARN]", YELLOW, message);
    }

    public static void error(String message, IOException e) {
        log("[ERROR]", RED, message);
    }

    public static void error(String message) {
        log("[ERROR]", RED, message);
    }

    public static void debug(String message) {
        log("[DEBUG]", CYAN, message);
    }
}