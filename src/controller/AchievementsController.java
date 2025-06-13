package controller;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import model.Achievement;
import model.User;
import dao.*;
import service.AchievementCard;

import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

public class AchievementsController {

    @FXML private VBox achievementList;
    @FXML private VBox rootVBox;

    private User currentUser;

    public void setUser(User user) {
        this.currentUser = user;
        if (user.getTheme().equals("light")) {
            switchToLightTheme();
        } else if (user.getTheme().equals("dark")){
            switchToDarkTheme();
        }
        loadAchievements();
    }

    private void loadAchievements() {
        AchievementDao achievementDao = new AchievementDaoImpl();
        UserAchievementDao userAchievementDao = new UserAchievementDaoImpl();

        List<Achievement> all = achievementDao.findAll();

        for (Achievement a : all) {
            boolean unlocked = userAchievementDao.isAchievementUnlocked(currentUser, a.getCode());
            String unlockedAt = unlocked ? userAchievementDao.getUnlockedAt(currentUser, a.getCode()) : null;

            AchievementCard card = new AchievementCard(a, unlocked, unlockedAt);
            achievementList.getChildren().add(card);
        }
    }

    public void switchToLightTheme() {
        rootVBox.getStylesheets().clear();
        rootVBox.getStylesheets().add(getClass().getResource("/style/achievements_light.css").toExternalForm());
    }

    public void switchToDarkTheme() {
        rootVBox.getStylesheets().clear();
        rootVBox.getStylesheets().add(getClass().getResource("/style/achievements_dark.css").toExternalForm());
    }
}
