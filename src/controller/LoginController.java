package controller;

import dao.*;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Stage;
import model.Achievement;
import model.Transaction;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import utils.Logger;
import utils.MyUtils;

import java.io.IOException;
import java.math.BigDecimal;
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
            LocalDate today = LocalDate.now();
            LocalDate lastStreakDate = user.getLastStreakDate();

            // Update streak logic
            if (lastStreakDate == null || !lastStreakDate.equals(today)) {
                if (lastStreakDate != null && lastStreakDate.equals(today.minusDays(1))) {
                    // Continued streak
                    user.setCurrentStreak(user.getCurrentStreak() + 1);
                } else {
                    // Reset streak
                    user.setCurrentStreak(1);
                }
                user.setLastStreakDate(today);

                // Save streak update
                userDao.updateLastLoginForStreak(user);

                // Add login entry
                LoginEntryDao loginEntryDao = new LoginEntryDaoImpl();
                loginEntryDao.addLoginEntry(user.getId(), today);
            }

            checkStreakAchievements(user);
            userDao.updateLastLogin(user);

            try {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/dashboard.fxml"));
                Scene dashboardScene = new Scene(loader.load());

                DashboardController controller = loader.getController();
                if (controller != null) {
                    controller.setUser(user);
                } else {
                    System.err.println("DashboardController is null. Check fx:controller in dashboard.fxml");
                }

                Stage stage = (Stage) usernameField.getScene().getWindow();
                stage.setScene(dashboardScene);
                stage.centerOnScreen();

                Logger.info("Login successful: " + user.getUsername());
                Logger.info("Dashboard loaded");
            } catch (IOException e) {
                e.printStackTrace();
                Logger.error("Failed to load dashboard");
                statusLabel.setText("Failed to load dashboard.");
            }
        } else {
            Logger.info("Invalid credentials");
            MyUtils.showWarning("Invalid credentials", "Invalid credentials.");
        }
    }


    private void checkStreakAchievements(User user) {

        if (user.getCurrentStreak() == 7) {
            tryUnlockAchievement("LOGIN_STREAK_7_DAYS", user);
        }

        if (user.getCurrentStreak() == 14) {
            tryUnlockAchievement("LOGIN_STREAK_14_DAYS", user);
        }

        if (user.getCurrentStreak() == 30) {
            tryUnlockAchievement("LOGIN_STREAK_30_DAYS", user);
        }

    }

    private void tryUnlockAchievement(String code, User user) {
        UserAchievementDao userAchievementDao = new UserAchievementDaoImpl();
        AchievementDao achievementDao = new AchievementDaoImpl();
        UserDao userDao = new UserDaoImpl();
        if (!userAchievementDao.isAchievementUnlocked(user, code)) {
            Achievement achievement = achievementDao.findByCode(code);
            if (achievement != null) {
                userAchievementDao.unlockAchievement(user, code);
                MyUtils.showInfo(
                        "Achievement unlocked",
                        "You unlocked a new achievement!\n\n" +
                                achievement.getName() + "\n" +
                                achievement.getDescription() + "\n\n+ " +
                                achievement.getXpReward() + " XP\n+ " +
                                achievement.getPointsReward() + " DP points"
                );
                userDao.updateUserLevel(user, achievement.getXpReward());
                userDao.updateUserPoints(user, achievement.getPointsReward());
            }
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
