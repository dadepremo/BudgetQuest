package budgetquest.controller;

import budgetquest.dao.AchievementDao.AchievementDao;
import budgetquest.dao.AchievementDao.AchievementDaoImpl;
import budgetquest.dao.AppSettingsDao.AppSettingsDao;
import budgetquest.dao.AppSettingsDao.AppSettingsDaoImpl;
import budgetquest.dao.LoginEntryDao.LoginEntryDao;
import budgetquest.dao.LoginEntryDao.LoginEntryDaoImpl;
import budgetquest.dao.ShopItemDao.ShopItemDao;
import budgetquest.dao.ShopItemDao.ShopItemDaoImpl;
import budgetquest.dao.UserAchievementDao.UserAchievementDao;
import budgetquest.dao.UserAchievementDao.UserAchievementDaoImpl;
import budgetquest.dao.UserDao.UserDao;
import budgetquest.dao.UserDao.UserDaoImpl;
import budgetquest.utils.DbConnection;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;
import budgetquest.model.Achievement;
import budgetquest.model.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mindrot.jbcrypt.BCrypt;
import budgetquest.service.MotivationalQuotePopup;
import budgetquest.utils.MyUtils;

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

    private static final Logger logger = LogManager.getLogger(LoginController.class);

    @FXML private TextField usernameField;
    @FXML private PasswordField passwordField;
    @FXML private Label statusLabel;
    @FXML private Label appSettings;
    @FXML private ComboBox<String> envComboBox;

    private final ShopItemDao shopItemDao = new ShopItemDaoImpl();

    @FXML
    public void initialize() {
        AppSettingsDao appSettingsDao = new AppSettingsDaoImpl();
        String version = appSettingsDao.getSetting("app.version");
        String env = appSettingsDao.getSetting("env.mode");
        envComboBox.getSelectionModel().select("DEV");

        envComboBox.getSelectionModel().selectedItemProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null) {
                DbConnection.setEnvironment(newVal);
                appSettings.setText("v" + version + " - " + newVal.toUpperCase());
            }
        });

        DbConnection.setEnvironment(envComboBox.getValue());

        appSettings.setText("v" + version + " - " + env.toUpperCase());


        logger.info("App initialized. Version: " + version + ", Environment: " + env);
    }


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
                    logger.warn("DashboardController is null. Check fx:controller in dashboard.fxml");
                }

                Stage stage = (Stage) usernameField.getScene().getWindow();
                stage.setScene(dashboardScene);
                stage.centerOnScreen();

                if (shopItemDao.getItemByNameForUser("Daily Motivation Quotes", user.getId()) != null) MotivationalQuotePopup.showPopup(stage);

                logger.info("Login successful: " + user.getUsername());
                logger.info("Dashboard loaded");
            } catch (IOException e) {
                e.printStackTrace();
                logger.error("Failed to load dashboard");
                statusLabel.setText("Failed to load dashboard.");
            }
        } else {
            logger.info("Invalid credentials");
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
