package controller;

import dao.UserDaoImpl;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Stage;
import model.User;
import service.UserService;
import utils.DbConnection;

import java.sql.Connection;
import java.time.LocalDateTime;

public class RegisterController {

    @FXML private TextField usernameField;
    @FXML private TextField firstNameField;
    @FXML private TextField lastNameField;
    @FXML private TextField emailField;
    @FXML private PasswordField passwordField;
    @FXML private Label statusLabel;

    private UserService userService;

    @FXML
    public void initialize() {
        try {
            userService = new UserService(new UserDaoImpl());
        } catch (Exception e) {
            statusLabel.setText("Database error.");
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
            statusLabel.setText("All fields are required.");
            return;
        }

        boolean registered = userService.registerUser(username, firstName, lastName, email, password);
        if (registered) {
            statusLabel.setText("✅ Registered successfully!");
            clearForm();
        } else {
            statusLabel.setText("❌ Registration failed.");
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
