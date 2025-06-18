package budgetquest.controller;

import budgetquest.dao.UserDao.UserDaoImpl;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Stage;
import budgetquest.service.UserService;
import budgetquest.utils.MyUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class RegisterController {

    private static final Logger logger = LogManager.getLogger(RegisterController.class);

    @FXML private Label usernameError;
    @FXML private Label emailError;

    @FXML private TextField usernameField;
    @FXML private TextField firstNameField;
    @FXML private TextField lastNameField;
    @FXML private TextField emailField;
    @FXML private PasswordField passwordField;

    private UserService userService;

    @FXML
    public void initialize() {
        try {
            userService = new UserService(new UserDaoImpl());
        } catch (Exception e) {
            MyUtils.showError("Database error", "We've encountered a database error, try later.");
            e.printStackTrace();
        }

        addValidation();
        setupLiveValidation();
    }

    private void setupLiveValidation() {
        usernameField.textProperty().addListener((obs, oldText, newText) -> {
            if (!newText.matches("^[a-zA-Z][a-zA-Z0-9._]{2,19}$")) {
                usernameError.setText("Invalid username (3–20 chars, start with a letter)");
            } else {
                usernameError.setText("");
            }
        });

        emailField.textProperty().addListener((obs, oldText, newText) -> {
            if (!newText.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                emailError.setText("Invalid email format");
            } else {
                emailError.setText("");
            }
        });
    }

    private void addValidation() {
        // Username: starts with a letter, allows letters, digits, ., _
        usernameField.setTextFormatter(new TextFormatter<>(change -> {
            String newText = change.getControlNewText();
            if (newText.matches("[a-zA-Z][a-zA-Z0-9._]{0,19}") || newText.isEmpty()) {
                return change;
            }
            return null;
        }));
        usernameField.setTooltip(new Tooltip("Start with a letter. Use letters, numbers, . or _. Max 20 characters."));

        // Email: Basic email format validation
        emailField.setTextFormatter(new TextFormatter<>(change -> {
            String newText = change.getControlNewText();
            if (newText.length() > 50) return null; // limit length
            return change;
        }));
        emailField.setTooltip(new Tooltip("Enter a valid email (e.g. name@example.com)"));

        // Optional: Limit password to 32 characters
        passwordField.setTextFormatter(new TextFormatter<>(change -> {
            if (change.getControlNewText().length() <= 32) {
                return change;
            }
            return null;
        }));
        passwordField.setTooltip(new Tooltip("Password up to 32 characters."));
    }


    @FXML
    public void handleRegister() {
        String username = usernameField.getText().trim();
        String firstName = firstNameField.getText().trim();
        String lastName = lastNameField.getText().trim();
        String email = emailField.getText().trim();
        String password = passwordField.getText();

        if (username.isEmpty() || firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || password.isEmpty()) {
            MyUtils.showWarning("Validation error", "All fields are required.");
            return;
        }

        if (!username.matches("^[a-zA-Z][a-zA-Z0-9._]{2,19}$")) {
            MyUtils.showWarning("Validation error", "Username must start with a letter and contain only letters, numbers, dot or underscore. (3–20 characters)");
            return;
        }

        if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            MyUtils.showWarning("Validation error", "Please enter a valid email address.");
            return;
        }

        if (password.length() < 6) {
            MyUtils.showWarning("Validation error", "Password must be at least 6 characters long.");
            return;
        }

        boolean registered = userService.registerUser(username, firstName, lastName, email, password);
        if (registered) {
            MyUtils.showInfo("Registration successful", "Registered successfully!");
            logger.info("Registered new user");
            clearForm();
        } else {
            MyUtils.showError("Registration error", "Registration failed.");
            logger.info("Register new user error");
        }
    }


    private void clearForm() {
        usernameField.clear();
        firstNameField.clear();
        lastNameField.clear();
        emailField.clear();
        passwordField.clear();
    }

    @FXML
    public void switchToLogin() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/login.fxml"));
            Scene scene = new Scene(loader.load());
            Stage stage = (Stage) usernameField.getScene().getWindow();
            stage.setScene(scene);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
