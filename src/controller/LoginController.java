package controller;

import dao.UserDao;
import dao.UserDaoImpl;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Stage;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import utils.Logger;
import utils.MyUtils;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Optional;

/**
 * @author ChatGPT <br><br>
 *
 * Class that handles the login process. <br>
 * Has a main method called the handleLogin that contains all the logic for the logic process.
 *
 */
public class LoginController {

    @FXML private TextField usernameField;
    @FXML private PasswordField passwordField;
    @FXML private Label statusLabel;

    /**
     * Method that handles all the login process. <br><br>
     * Completed the password and username checks, if the result is positive,
     * it memorizes the user logging in, and it loads the main dashboard.
     */
    @FXML
    public void handleLogin() {
        String username = usernameField.getText();
        String password = passwordField.getText();

        UserDao userDao = new UserDaoImpl();
        Optional<User> userOpt = userDao.getUserByUsername(username);

        if (userOpt.isPresent() && BCrypt.checkpw(password, userOpt.get().getPasswordHash())) {
            User user = userOpt.get();

            // Update streak
            LocalDate today = LocalDate.now();
            LocalDate lastDate = user.getLastStreakDate();

            if (lastDate.equals(today) && user.getCurrentStreak() == 0) {
                user.setCurrentStreak(1);
                user.setLastStreakDate(today);
            } else if (lastDate.equals(today.minusDays(1))) {
                // Continued streak
                user.setCurrentStreak(user.getCurrentStreak() + 1);
                user.setLastStreakDate(today);
            } else {
                // Missed one or more days, reset streak
                user.setCurrentStreak(1);
                user.setLastStreakDate(today);
            }

            // Save streak update to DB
            userDao.updateLoginStreak(user);

            try {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/dashboard.fxml"));
                Scene dashboardScene = new Scene(loader.load());

                DashboardController controller = loader.getController();
                if (controller != null) {
                    Logger.info("Login successful: " + user.getUsername());
                    Logger.info("Dashboard loading...");
                    Logger.info("Executing update last login");
                    userDao.updateLastLogin(user);
                    controller.setUser(user);
                } else {
                    System.err.println("DashboardController is null. Check fx:controller in dashboard.fxml");
                }

                Stage stage = (Stage) usernameField.getScene().getWindow();
                stage.setScene(dashboardScene);
                stage.centerOnScreen();
            } catch (Exception e) {
                e.printStackTrace();
                Logger.error("Failed to load dashboard");
                statusLabel.setText("Failed to load dashboard.");
            }
        } else {
            Logger.info("Invalid credentials");
            MyUtils.showWarning("Invalid credentials", "Invalid credentials.");
        }
    }


    @FXML
    public void switchToRegister() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/register.fxml"));
            Scene scene = new Scene(loader.load());
            Stage stage = (Stage) usernameField.getScene().getWindow();
            stage.setScene(scene);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
