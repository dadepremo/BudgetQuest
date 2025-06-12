package dao;

import model.User;
import utils.DbConnection;
import org.mindrot.jbcrypt.BCrypt;
import utils.Logger;
import utils.MyUtils;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserDaoImpl implements UserDao {

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
    public void updateLastLogin(User user) {
        String sql = "UPDATE users SET last_login = ? WHERE username = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(2, user.getUsername());
            ps.execute();
            Logger.info("Last login updated to: " + Timestamp.valueOf(LocalDateTime.now()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
        Logger.info("User points change: " + points);
        points += prevUserPoints;
        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, points);
            ps.setInt(2, user.getId());
            ps.executeUpdate();
            Logger.info("User points updated: " + prevUserPoints + " -> " + points);
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
    public void updateUserLevel(User user, int xp) {
        String sql = "UPDATE users SET xp = ?, level = ? WHERE id = ?";

        int userXp = getUserXp(user);
        int userLevel = getUserLevel(user);

        Logger.info("Xp change: " + xp);
        Logger.info("User details before xp change: userXp=" + userXp + " userLevel=" + userLevel);

        // Calculate current stats
        int xpToNextLevel = (userLevel + 1) * 500;

        // Apply XP change
        userXp += xp;

        // Optional: Level down (if you support it)
        while (userXp < 0 && userLevel > 0) {
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


        Logger.info("User details after xp change: userXp=" + userXp + " userLevel=" + userLevel);

        try (Connection conn = DbConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userXp);
            ps.setInt(2, userLevel);
            ps.setInt(3, user.getId());
            ps.executeUpdate();
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
        user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return user;
    }

}
