package model;

import java.time.LocalDateTime;

public class UserAchievement {
    private int userId;
    private int achievementId;
    private LocalDateTime unlockedAt;

    public UserAchievement() {}

    public UserAchievement(int userId, int achievementId, LocalDateTime unlockedAt) {
        this.userId = userId;
        this.achievementId = achievementId;
        this.unlockedAt = unlockedAt;
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getAchievementId() { return achievementId; }
    public void setAchievementId(int achievementId) { this.achievementId = achievementId; }

    public LocalDateTime getUnlockedAt() { return unlockedAt; }
    public void setUnlockedAt(LocalDateTime unlockedAt) { this.unlockedAt = unlockedAt; }
}

