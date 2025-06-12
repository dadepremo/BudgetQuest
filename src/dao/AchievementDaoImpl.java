package dao;

import model.Achievement;
import utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AchievementDaoImpl implements AchievementDao {

    @Override
    public Achievement findById(int id) {
        String sql = "SELECT * FROM achievements WHERE id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Achievement findByCode(String code) {
        String sql = "SELECT * FROM achievements WHERE code = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Achievement> findAll() {
        String sql = "SELECT * FROM achievements";
        List<Achievement> list = new ArrayList<>();
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void save(Achievement achievement) {
        String sql = """
            INSERT INTO achievements (code, name, description, points_reward, xp_reward, icon)
            VALUES (?, ?, ?, ?, ?, ?)
            ON CONFLICT (code) DO UPDATE SET
                name = EXCLUDED.name,
                description = EXCLUDED.description,
                points_reward = EXCLUDED.points_reward,
                xp_reward = EXCLUDED.xp_reward
        """;
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, achievement.getCode());
            stmt.setString(2, achievement.getName());
            stmt.setString(3, achievement.getDescription());
            stmt.setInt(4, achievement.getPointsReward());
            stmt.setInt(5, achievement.getXpReward());
            stmt.setString(6, achievement.getIcon());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteById(int id) {
        String sql = "DELETE FROM achievements WHERE id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Achievement mapRow(ResultSet rs) throws SQLException {
        Achievement a = new Achievement();
        a.setId(rs.getInt("id"));
        a.setCode(rs.getString("code"));
        a.setName(rs.getString("name"));
        a.setDescription(rs.getString("description"));
        a.setPointsReward(rs.getInt("points_reward"));
        a.setXpReward(rs.getInt("xp_reward"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        return a;
    }
}

