package budgetquest.controller;

import budgetquest.dao.AchievementDao.AchievementDao;
import budgetquest.dao.AchievementDao.AchievementDaoImpl;
import budgetquest.dao.UserAchievementDao.UserAchievementDao;
import budgetquest.dao.UserAchievementDao.UserAchievementDaoImpl;
import javafx.fxml.FXML;
import javafx.scene.layout.VBox;
import budgetquest.model.Achievement;
import budgetquest.model.User;
import budgetquest.service.AchievementCard;

import java.util.List;

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
