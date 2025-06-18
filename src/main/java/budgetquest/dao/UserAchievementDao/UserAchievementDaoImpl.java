package budgetquest.dao.UserAchievementDao;

import budgetquest.dao.AchievementDao.AchievementDao;
import budgetquest.dao.AchievementDao.AchievementDaoImpl;
import budgetquest.model.User;
import budgetquest.model.UserAchievement;
import budgetquest.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserAchievementDaoImpl implements UserAchievementDao {


    private final AchievementDao achievementDao  = new AchievementDaoImpl();

    @Override
    public void unlockAchievement(User user, String code) {
        String sql = "INSERT INTO user_achievements (user_id, achievement_id) VALUES (?, ?) ON CONFLICT DO NOTHING";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            stmt.setInt(2, achievementDao.findByCode(code).getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean isAchievementUnlocked(User user, String code) {
        String sql = "SELECT 1 FROM user_achievements u " +
                "INNER JOIN achievements a ON u.achievement_id = a.id " +
                "WHERE u.user_id = ? AND a.code = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            stmt.setString(2, code);

            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public String getUnlockedAt(User user, String code) {
        String sql = "SELECT u.unlocked_at FROM user_achievements u " +
                "JOIN achievements a ON u.achievement_id = a.id " +
                "WHERE u.user_id = ? AND a.code = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            stmt.setString(2, code);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Timestamp ts = rs.getTimestamp("unlocked_at");
                return ts != null ? ts.toLocalDateTime().toString() : "Unknown";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "";
    }

    @Override
    public List<UserAchievement> getAchievementsForUser(int userId) {
        List<UserAchievement> list = new ArrayList<>();
        String sql = "SELECT user_id, achievement_id, unlocked_at FROM user_achievements WHERE user_id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                UserAchievement ua = new UserAchievement(
                        rs.getInt("user_id"),
                        rs.getInt("achievement_id"),
                        rs.getTimestamp("unlocked_at").toLocalDateTime()
                );
                list.add(ua);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

