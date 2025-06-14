package dao;

import model.Liability;
import model.User;
import utils.DbConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class LiabilityDaoImpl implements LiabilityDao {


    @Override
    public boolean insert(Liability liability) {
        String sql = "INSERT INTO liabilities (user_id, name, type, amount, amount_remaining, interest_rate, " +
                "start_date, due_date, notes, is_active, created_at, last_updated, is_deleted) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DbConnection.connect(); PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, liability.getUserId());
            stmt.setString(2, liability.getName());
            stmt.setString(3, liability.getType());
            stmt.setBigDecimal(4, liability.getAmount());
            stmt.setBigDecimal(5, liability.getAmountRemaining());
            stmt.setBigDecimal(6, liability.getInterestRate());
            stmt.setObject(7, liability.getStartDate());
            stmt.setObject(8, liability.getDueDate());
            stmt.setString(9, liability.getNotes());
            stmt.setBoolean(10, liability.isActive());
            stmt.setObject(11, liability.getCreatedAt());
            stmt.setObject(12, liability.getLastUpdated());
            stmt.setBoolean(13, liability.isDeleted());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                liability.setId(rs.getInt(1));
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Optional<Liability> findById(int id) {
        String sql = "SELECT * FROM liabilities WHERE id = ? AND is_deleted = false";

        try (Connection connection = DbConnection.connect(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return Optional.of(mapResultSetToLiability(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return Optional.empty();
    }

    @Override
    public double sumAllLiabilitiesAmount(User user) {
        String sql = """
        SELECT SUM(amount) as summed_liabilities FROM liabilities WHERE user_id = ? AND is_deleted = false
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("summed_liabilities");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }

    @Override
    public List<Liability> findAllByUserId(User user) {
        List<Liability> liabilities = new ArrayList<>();
        String sql = "SELECT * FROM liabilities WHERE user_id = ? AND is_deleted = false";

        try (Connection connection = DbConnection.connect(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                liabilities.add(mapResultSetToLiability(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return liabilities;
    }

    @Override
    public void update(Liability liability) {
        String sql = "UPDATE liabilities SET name = ?, type = ?, amount = ?, amount_remaining = ?, interest_rate = ?, " +
                "start_date = ?, due_date = ?, notes = ?, is_active = ?, last_updated = ?, is_deleted = ? WHERE id = ?";

        try (Connection connection = DbConnection.connect(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, liability.getName());
            stmt.setString(2, liability.getType());
            stmt.setBigDecimal(3, liability.getAmount());
            stmt.setBigDecimal(4, liability.getAmountRemaining());
            stmt.setBigDecimal(5, liability.getInterestRate());
            stmt.setObject(6, liability.getStartDate());
            stmt.setObject(7, liability.getDueDate());
            stmt.setString(8, liability.getNotes());
            stmt.setBoolean(9, liability.isActive());
            stmt.setObject(10, liability.getLastUpdated());
            stmt.setBoolean(11, liability.isDeleted());
            stmt.setInt(12, liability.getId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "UPDATE liabilities SET is_deleted = true, is_active = false, last_updated = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection connection = DbConnection.connect(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Liability mapResultSetToLiability(ResultSet rs) throws SQLException {
        Liability liability = new Liability();

        liability.setId(rs.getInt("id"));
        liability.setUserId(rs.getInt("user_id"));
        liability.setName(rs.getString("name"));
        liability.setType(rs.getString("type"));
        liability.setAmount(rs.getBigDecimal("amount"));
        liability.setAmountRemaining(rs.getBigDecimal("amount_remaining"));
        liability.setInterestRate(rs.getBigDecimal("interest_rate"));
        liability.setStartDate(rs.getObject("start_date", LocalDate.class));
        liability.setDueDate(rs.getObject("due_date", LocalDate.class));
        liability.setNotes(rs.getString("notes"));
        liability.setActive(rs.getBoolean("is_active"));
        liability.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
        liability.setLastUpdated(rs.getObject("last_updated", LocalDateTime.class));
        liability.setDeleted(rs.getBoolean("is_deleted"));

        return liability;
    }
}
