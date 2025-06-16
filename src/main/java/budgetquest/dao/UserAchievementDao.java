package budgetquest.dao;

import budgetquest.model.User;
import budgetquest.model.UserAchievement;

import java.util.List;

public interface UserAchievementDao {

    void unlockAchievement(User user, String code);

    boolean isAchievementUnlocked(User user, String code);

    List<UserAchievement> getAchievementsForUser(int userId);

    String getUnlockedAt(User currentUser, String code);
}

