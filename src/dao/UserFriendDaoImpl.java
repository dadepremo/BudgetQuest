package dao;

import model.UserFriend;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserFriendDaoImpl implements UserFriendDao {

    private final Connection connection;

    public UserFriendDaoImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void sendFriendRequest(int userId, int friendId) {
        String sql = "INSERT INTO user_friends (user_id, friend_id, status, requested_at) VALUES (?, ?, 'pending', CURRENT_TIMESTAMP)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error sending friend request", e);
        }
    }

    @Override
    public void acceptFriendRequest(int userId, int friendId) {
        String sql = "UPDATE user_friends SET status = 'accepted', accepted_at = CURRENT_TIMESTAMP WHERE user_id = ? AND friend_id = ? AND status = 'pending'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            int updated = stmt.executeUpdate();

            // Optional: Add reverse friendship record (for bidirectional friendship)
            if (updated > 0) {
                String reverseSql = "INSERT INTO user_friends (user_id, friend_id, status, requested_at, accepted_at) VALUES (?, ?, 'accepted', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP) " +
                        "ON CONFLICT (user_id, friend_id) DO NOTHING";
                try (PreparedStatement revStmt = connection.prepareStatement(reverseSql)) {
                    revStmt.setInt(1, friendId);
                    revStmt.setInt(2, userId);
                    revStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error accepting friend request", e);
        }
    }

    @Override
    public void blockFriend(int userId, int friendId) {
        String sql = "UPDATE user_friends SET status = 'blocked' WHERE user_id = ? AND friend_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error blocking friend", e);
        }
    }

    @Override
    public void removeFriend(int userId, int friendId) {
        String sql = "DELETE FROM user_friends WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            stmt.setInt(3, friendId);
            stmt.setInt(4, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error removing friend", e);
        }
    }

    @Override
    public List<UserFriend> getFriends(int userId) {
        String sql = "SELECT * FROM user_friends WHERE user_id = ? AND status = 'accepted'";
        List<UserFriend> friends = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                friends.add(mapRowToUserFriend(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching friends", e);
        }
        return friends;
    }

    @Override
    public List<UserFriend> getPendingRequests(int userId) {
        String sql = "SELECT * FROM user_friends WHERE friend_id = ? AND status = 'pending'";
        List<UserFriend> pending = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                pending.add(mapRowToUserFriend(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching pending requests", e);
        }
        return pending;
    }

    @Override
    public boolean areFriends(int userId, int friendId) {
        String sql = "SELECT 1 FROM user_friends WHERE user_id = ? AND friend_id = ? AND status = 'accepted'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new RuntimeException("Error checking friendship", e);
        }
    }

    @Override
    public Optional<UserFriend> getFriendship(int userId, int friendId) {
        String sql = "SELECT * FROM user_friends WHERE user_id = ? AND friend_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return Optional.of(mapRowToUserFriend(rs));
            } else {
                return Optional.empty();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching friendship", e);
        }
    }

    private UserFriend mapRowToUserFriend(ResultSet rs) throws SQLException {
        UserFriend uf = new UserFriend();
        uf.setUserId(rs.getInt("user_id"));
        uf.setFriendId(rs.getInt("friend_id"));
        uf.setStatus(rs.getString("status"));
        Timestamp requestedTs = rs.getTimestamp("requested_at");
        if (requestedTs != null) {
            uf.setRequestedAt(requestedTs.toLocalDateTime());
        }
        Timestamp acceptedTs = rs.getTimestamp("accepted_at");
        if (acceptedTs != null) {
            uf.setAcceptedAt(acceptedTs.toLocalDateTime());
        }
        return uf;
    }
}
