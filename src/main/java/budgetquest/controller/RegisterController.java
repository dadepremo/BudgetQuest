package budgetquest.controller;

import budgetquest.dao.LoginEntryDaoImpl;
import budgetquest.dao.UserDaoImpl;
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

        boolean registered = userService.registerUser(username, firstName, lastName, email, password);
        if (registered) {
            MyUtils.showInfo("Registration successful", "✅ Registered successfully!");
            logger.info("Registered new user");
            clearForm();
        } else {
            MyUtils.showError("Registration error", "❌ Registration failed.");
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
