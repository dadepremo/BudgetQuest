package budgetquest.dao.GoalDao;

import budgetquest.model.Goal;
import budgetquest.model.User;
import budgetquest.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GoalDaoImpl implements GoalDao {

    @Override
    public void create(Goal goal) {
        String sql = "INSERT INTO goals (user_id, name, description, goal_type, target_amount, current_amount, start_date, end_date, is_completed, is_deleted) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, false)";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, goal.getUserId());
            stmt.setString(2, goal.getName());
            stmt.setString(3, goal.getDescription());
            stmt.setString(4, goal.getGoalType());
            stmt.setBigDecimal(5, goal.getTargetAmount());
            stmt.setBigDecimal(6, goal.getCurrentAmount());
            stmt.setDate(7, Date.valueOf(goal.getStartDate()));
            stmt.setDate(8, Date.valueOf(goal.getEndDate()));
            stmt.setBoolean(9, goal.isCompleted());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Goal> findAllByUser(User user) {
        List<Goal> goals = new ArrayList<>();
        String sql = "SELECT * FROM goals WHERE user_id = ? AND is_deleted = false ORDER BY end_date";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Goal goal = mapRow(rs);
                goals.add(goal);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return goals;
    }

    @Override
    public Goal findById(int id) {
        String sql = "SELECT * FROM goals WHERE id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(Goal goal) {
        String sql = "UPDATE goals SET name=?, description=?, goal_type=?, target_amount=?, current_amount=?, start_date=?, end_date=?, is_completed=?, is_deleted=? WHERE id=?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, goal.getName());
            stmt.setString(2, goal.getDescription());
            stmt.setString(3, goal.getGoalType());
            stmt.setBigDecimal(4, goal.getTargetAmount());
            stmt.setBigDecimal(5, goal.getCurrentAmount());
            stmt.setDate(6, Date.valueOf(goal.getStartDate()));
            stmt.setDate(7, Date.valueOf(goal.getEndDate()));
            stmt.setBoolean(8, goal.isCompleted());
            stmt.setBoolean(9, goal.isDeleted());
            stmt.setInt(10, goal.getId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "UPDATE goals SET is_deleted = true WHERE id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Goal mapRow(ResultSet rs) throws SQLException {
        Goal goal = new Goal();
        goal.setId(rs.getInt("id"));
        goal.setUserId(rs.getInt("user_id"));
        goal.setName(rs.getString("name"));
        goal.setDescription(rs.getString("description"));
        goal.setGoalType(rs.getString("goal_type"));
        goal.setTargetAmount(rs.getBigDecimal("target_amount"));
        goal.setCurrentAmount(rs.getBigDecimal("current_amount"));
        goal.setStartDate(rs.getDate("start_date").toLocalDate());
        goal.setEndDate(rs.getDate("end_date").toLocalDate());
        goal.setCompleted(rs.getBoolean("is_completed"));
        goal.setDeleted(rs.getBoolean("is_deleted"));
        return goal;
    }
}
