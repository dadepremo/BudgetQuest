package budgetquest.dao;

import budgetquest.controller.AssetFormController;
import budgetquest.model.Achievement;
import budgetquest.model.Category;
import budgetquest.model.User;
import budgetquest.utils.DbConnection;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mindrot.jbcrypt.BCrypt;
import budgetquest.utils.MyUtils;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserDaoImpl implements UserDao {

    private static final Logger logger = LogManager.getLogger(UserDaoImpl.class);

    @Override
    public Optional<User> getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ? AND is_deleted = false";
        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return Optional.of(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public Optional<User> getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ? AND is_deleted = false";
        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return Optional.of(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE is_deleted = false";
        try (Connection conn = DbConnection.connect();
             Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public boolean createUser(User user) {
        String sql = "INSERT INTO users (username, first_name, last_name, email, password_hash, created_at, is_deleted, xp, level, points) VALUES (?, ?, ?, ?, ?, ?, false, ?, ?, ?)";
        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastName());
            ps.setString(4, user.getEmail());

            String hashedPassword = BCrypt.hashpw(user.getPasswordHash(), BCrypt.gensalt());
            ps.setString(5, hashedPassword);

            ps.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            ps.setInt(7, user.getXp());
            ps.setInt(8, user.getLevel());
            ps.setInt(9, user.getPoints());

            int affectedRows = ps.executeUpdate();
            User u = getUserByUsername(user.getUsername()).get();

            CategoryDao categoryDao = new CategoryDaoImpl();
            categoryDao.insertForNew(user, new Category(u.getId(), "Not Categorized", "expense", false));
            categoryDao.insertForNew(user, new Category(u.getId(), "Not Categorized", "income", false));

            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET username=?, first_name=?, last_name=?, email=?, password_hash=?, xp=?, level=?, points=? WHERE id=?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPasswordHash());  // Make sure this is hashed already if changed
            ps.setInt(6, user.getXp());
            ps.setInt(7, user.getLevel());
            ps.setInt(8, user.getPoints());
            ps.setInt(9, user.getId());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteUser(int id) {
        // Soft delete
        String sql = "UPDATE users SET is_deleted = true WHERE id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void updateLastLoginForStreak(User user) {
        String sql = "UPDATE users SET last_streak_date = ?, current_streak = ? WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (user.getLastStreakDate() != null) {
                stmt.setDate(1, Date.valueOf(user.getLastStreakDate()));
            } else {
                stmt.setNull(1, java.sql.Types.DATE);
            }

            stmt.setInt(2, user.getCurrentStreak());
            stmt.setInt(3, user.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void updateLastLogin(User user) {
        String sql = "UPDATE users SET last_login = ? WHERE username = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(2, user.getUsername());
            ps.execute();
            logger.info("Last login updated to: " + Timestamp.valueOf(LocalDateTime.now()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public LocalDate getLastStreakDate(User user) {
        String sql = "SELECT last_streak_date FROM users WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDate("last_streak_date").toLocalDate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return LocalDate.now();
    }

    @Override
    public int getUserXp(User user) {
        String sql = "SELECT xp FROM users WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("xp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int getUserPoints(User user) {
        String sql = "SELECT points FROM users WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("points");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public void updateUserPoints(User user, int points) {
        String sql = "UPDATE users SET points = ? WHERE id = ?";
        int prevUserPoints = getUserPoints(user);
        logger.info("User points change: " + points);
        points += prevUserPoints;
        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, points);
            ps.setInt(2, user.getId());
            ps.executeUpdate();
            logger.info("User points updated: " + prevUserPoints + " -> " + points);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getUserLevel(User user) {
        String sql = "SELECT level FROM users WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("level");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public void grantAchievement(User user, String code) {
        AchievementDao achievementDao = new AchievementDaoImpl();
        Achievement achievement = achievementDao.findByCode(code);
        if (achievement != null) {
            UserAchievementDao userAchievementDao = new UserAchievementDaoImpl();
            userAchievementDao.unlockAchievement(user, achievement.getCode());

            UserDao userDao = new UserDaoImpl();
            userDao.updateUserPoints(user, achievement.getPointsReward());
            userDao.updateUserLevel(user, achievement.getXpReward());

            MyUtils.showInfo("Achievement unlocked", "You unlocked a new achievement!\n" + achievement.getName() + "\n\n+ " + achievement.getXpReward() + " XP\n+ " + achievement.getPointsReward());
        }
    }

    @Override
    public void updateUserLevel(User user, int xp) {
        String sql = "UPDATE users SET xp = ?, level = ? WHERE id = ?";

        int userXp = getUserXp(user);
        int userLevel = getUserLevel(user);

        logger.info("Xp change: " + xp);
        logger.info("User details before xp change: userXp=" + userXp + " userLevel=" + userLevel);

        // Calculate current stats
        int xpToNextLevel = (userLevel + 1) * 500;

        // Apply XP change
        userXp += xp;

        // Optional: Level down (if you support it)
        while (userXp < 0 && userLevel > 1) {
            userLevel--;
            int xpForPreviousLevel = (userLevel + 1) * 500;
            userXp += xpForPreviousLevel;
            xpToNextLevel = (userLevel + 1) * 500;
            MyUtils.showInfo("Level down!", "You dropped to level " + userLevel);
        }

        // Clamp XP to 0 (if no level down or still negative after level-down)
        if (userXp < 0) {
            userXp = 0;
        }

        // Level up loop
        while (userXp >= xpToNextLevel) {
            userXp -= xpToNextLevel;
            userLevel++;
            xpToNextLevel = (userLevel + 1) * 500;
            if(userLevel % 100 != 0) {
                MyUtils.showInfo("Level up!", "You levelled up to level " + userLevel);
            } else {
                MyUtils.showInfo("Level up!", "Congrats you reached a big milestone!\nLevel " + userLevel);
            }
        }

        logger.info("User details after xp change: userXp=" + userXp + " userLevel=" + userLevel);

        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userXp);
            ps.setInt(2, userLevel);
            ps.setInt(3, user.getId());
            ps.executeUpdate();
            checkLevelUpAchievements(user, userLevel);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void checkLevelUpAchievements(User user, int level) {
        logger.info("Level up achievement check");
        if (level >= 10 && level < 50) {
            tryUnlockAchievement(user, "LEVEL_10");
        }
        if (level >= 50 && level < 100) {
            tryUnlockAchievement(user, "LEVEL_50");
        }
        if (level >= 100) {
            tryUnlockAchievement(user, "LEVEL_100");
        }
    }

    private void tryUnlockAchievement(User currentUser, String code) {
        UserAchievementDao userAchievementDao = new UserAchievementDaoImpl();
        AchievementDao achievementDao = new AchievementDaoImpl();
        UserDao userDao = new UserDaoImpl();
        if (!userAchievementDao.isAchievementUnlocked(currentUser, code)) {
            Achievement achievement = achievementDao.findByCode(code);
            if (achievement != null) {
                userAchievementDao.unlockAchievement(currentUser, code);
                MyUtils.showInfo(
                        "Achievement unlocked",
                        "You unlocked a new achievement!\n\n" +
                                achievement.getName() + "\n" +
                                achievement.getDescription() + "\n\n+ " +
                                achievement.getXpReward() + " XP\n+ " +
                                achievement.getPointsReward() + " DP points"
                );
                userDao.updateUserLevel(currentUser, achievement.getXpReward());
                userDao.updateUserPoints(currentUser, achievement.getPointsReward());
            }
        }
    }

    @Override
    public void deleteUserData(User user) {
        String deleteTransactions = "DELETE FROM transactions WHERE category_id IN (SELECT id FROM categories WHERE user_id = ?)";
        String deleteCategories = "DELETE FROM categories WHERE user_id = ?";
        String deleteUser = "DELETE FROM users WHERE id = ?";

        try (Connection conn = DbConnection.connect()) {
            conn.setAutoCommit(false); // Start transaction

            try (PreparedStatement stmt1 = conn.prepareStatement(deleteTransactions);
                 PreparedStatement stmt2 = conn.prepareStatement(deleteCategories);
                 PreparedStatement stmt3 = conn.prepareStatement(deleteUser)) {

                stmt1.setInt(1, user.getId());
                stmt1.executeUpdate();

                stmt2.setInt(1, user.getId());
                stmt2.executeUpdate();

                stmt3.setInt(1, user.getId());
                stmt3.executeUpdate();

                conn.commit(); // Commit if all succeeded

            } catch (SQLException e) {
                conn.rollback(); // Rollback if any failed
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateLoginStreak(User user) {
        String sql = "UPDATE users SET last_streak_date = ?, current_streak = ? WHERE id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDate(1, Date.valueOf(user.getLastStreakDate()));
            stmt.setInt(2, user.getCurrentStreak());
            stmt.setInt(3, user.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateUserTheme(User user) {
        String sql = "update users set theme = ? where id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getTheme());
            stmt.setInt(2, user.getId());
            stmt.executeUpdate();
            logger.info("Updated user theme to " + user.getTheme());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setXp(rs.getInt("xp"));
        user.setLevel(rs.getInt("level"));
        user.setPoints(rs.getInt("points"));
        user.setCurrency(rs.getString("preferred_currency"));
        user.setCurrencySymbol(rs.getString("currency_symbol"));
        user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        user.setLastStreakDate(rs.getDate("last_streak_date") != null ? rs.getDate("last_streak_date").toLocalDate() : null);
        user.setCurrentStreak(rs.getInt("current_streak"));
        user.setTheme(rs.getString("theme"));
        return user;
    }

}
