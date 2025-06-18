package budgetquest.dao.LiabilityDao;

import budgetquest.model.Liability;
import budgetquest.model.User;
import budgetquest.utils.DbConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class LiabilityDaoImpl implements LiabilityDao {

    @Override
    public void updateLiability(Liability liability, User user) throws SQLException {
        String sql = """
        UPDATE public.liabilities
        SET user_id = ?,
            name = ?,
            type = ?,
            amount = ?,
            amount_remaining = ?,
            interest_rate = ?,
            start_date = ?,
            due_date = ?,
            notes = ?,
            is_active = ?,
            last_updated = CURRENT_TIMESTAMP,
            payment_frequency = ?,
            next_payment_due = ?,
            minimum_payment = ?,
            liability_status = ?,
            category = ?,
            total_paid = ?,
            last_payment_date = ?,
            creditor_name = ?,
            creditor_contact = ?,
            reminder_enabled = ?,
            reminder_days_before = ?,
            monthly_payment = ?
        WHERE id = ? AND is_deleted = false
    """;

        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            stmt.setString(2, liability.getName());
            stmt.setString(3, liability.getType());
            stmt.setBigDecimal(4, liability.getAmount());
            stmt.setBigDecimal(5, liability.getAmountRemaining());
            stmt.setBigDecimal(6, liability.getInterestRate());
            stmt.setObject(7, liability.getStartDate());
            stmt.setObject(8, liability.getDueDate());
            stmt.setString(9, liability.getNotes());
            stmt.setBoolean(10, liability.isActive());
            stmt.setString(11, liability.getPaymentFrequency());
            stmt.setObject(12, liability.getNextPaymentDue());
            stmt.setBigDecimal(13, liability.getMinimumPayment());
            stmt.setString(14, liability.getLiabilityStatus());
            stmt.setString(15, liability.getCategory());
            stmt.setBigDecimal(16, liability.getTotalPaid());
            stmt.setObject(17, liability.getLastPaymentDate());
            stmt.setString(18, liability.getCreditorName());
            stmt.setString(19, liability.getCreditorContact());
            stmt.setBoolean(20, liability.isReminderEnabled());

            if (liability.getReminderDaysBefore() != null) {
                stmt.setInt(21, liability.getReminderDaysBefore());
            } else {
                stmt.setNull(21, Types.INTEGER);
            }

            stmt.setBigDecimal(22, liability.getMonthlyPayment());

            stmt.setInt(23, liability.getId());

            int rows = stmt.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Updating liability failed, no rows affected.");
            }
        }
    }

    @Override
    public void softDelete(Liability liability) {
        String sql = """
        UPDATE public.liabilities
        SET is_deleted = true
        WHERE id = ? AND user_id = ?
    """;

        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, liability.getId());
            stmt.setInt(2, liability.getUserId());

            int rows = stmt.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Updating liability failed, no rows affected.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Liability> searchLiabilities(int userId, String nameFilter, LocalDate fromDate, LocalDate toDate) {
        List<Liability> liabilities = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT *
        FROM liabilities
        WHERE user_id = ?
          AND is_deleted = false
          AND (name ILIKE ? OR type ILIKE ? OR notes ILIKE ?)
    """);

        if (fromDate != null) {
            sql.append(" AND start_date >= ? ");
        }
        if (toDate != null) {
            sql.append(" AND due_date <= ? ");
        }

        sql.append(" ORDER BY start_date DESC ");

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            stmt.setInt(paramIndex++, userId);
            stmt.setString(paramIndex++, "%" + nameFilter + "%");
            stmt.setString(paramIndex++, "%" + nameFilter + "%");
            stmt.setString(paramIndex++, "%" + nameFilter + "%");

            if (fromDate != null) {
                stmt.setDate(paramIndex++, Date.valueOf(fromDate));
            }
            if (toDate != null) {
                stmt.setDate(paramIndex++, Date.valueOf(toDate));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Liability liability = new Liability();
                liability.setId(rs.getInt("id"));
                liability.setUserId(rs.getInt("user_id"));
                liability.setName(rs.getString("name"));
                liability.setType(rs.getString("type"));
                liability.setAmount(rs.getBigDecimal("amount"));
                liability.setAmountRemaining(rs.getBigDecimal("amount_remaining"));
                liability.setInterestRate(rs.getBigDecimal("interest_rate"));

                java.sql.Date startDateSql = rs.getDate("start_date");
                liability.setStartDate(startDateSql != null ? startDateSql.toLocalDate() : null);

                java.sql.Date dueDateSql = rs.getDate("due_date");
                liability.setDueDate(dueDateSql != null ? dueDateSql.toLocalDate() : null);

                liability.setNotes(rs.getString("notes"));
                liability.setActive(rs.getBoolean("is_active"));
                liability.setDeleted(rs.getBoolean("is_deleted"));
                liability.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                liability.setLastUpdated(rs.getTimestamp("last_updated").toLocalDateTime());
                liability.setPaymentFrequency(rs.getString("payment_frequency"));
                liability.setNextPaymentDue(rs.getObject("next_payment_due", LocalDate.class));
                liability.setMinimumPayment(rs.getBigDecimal("minimum_payment"));
                liability.setLiabilityStatus(rs.getString("liability_status"));
                liability.setCategory(rs.getString("category"));
                liability.setTotalPaid(rs.getBigDecimal("total_paid"));
                liability.setLastPaymentDate(rs.getObject("last_payment_date", LocalDate.class));
                liability.setCreditorName(rs.getString("creditor_name"));
                liability.setCreditorContact(rs.getString("creditor_contact"));
                liability.setReminderEnabled(rs.getBoolean("reminder_enabled"));
                liability.setReminderDaysBefore(rs.getObject("reminder_days_before") != null ? rs.getInt("reminder_days_before") : null);
                liability.setMonthlyPayment(rs.getBigDecimal("monthly_payment"));

                liabilities.add(liability);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return liabilities;
    }

    @Override
    public boolean insert(Liability liability, int userId) {
        String sql = "INSERT INTO liabilities (" +
                "user_id, name, type, amount, amount_remaining, interest_rate, " +
                "start_date, due_date, notes, is_active, created_at, last_updated, is_deleted, " +
                "payment_frequency, next_payment_due, minimum_payment, liability_status, category, " +
                "total_paid, last_payment_date, creditor_name, creditor_contact, " +
                "reminder_enabled, reminder_days_before, monthly_payment" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, userId);
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
            stmt.setString(14, liability.getPaymentFrequency());
            stmt.setObject(15, liability.getNextPaymentDue());
            stmt.setBigDecimal(16, liability.getMinimumPayment());
            stmt.setString(17, liability.getLiabilityStatus());
            stmt.setString(18, liability.getCategory());
            stmt.setBigDecimal(19, liability.getTotalPaid());
            stmt.setObject(20, liability.getLastPaymentDate());
            stmt.setString(21, liability.getCreditorName());
            stmt.setString(22, liability.getCreditorContact());
            stmt.setBoolean(23, liability.isReminderEnabled());

            if (liability.getReminderDaysBefore() != null) {
                stmt.setInt(24, liability.getReminderDaysBefore());
            } else {
                stmt.setNull(24, Types.INTEGER);
            }

            stmt.setBigDecimal(25, liability.getMonthlyPayment());

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
        SELECT SUM(amount_remaining) as summed_liabilities FROM liabilities WHERE user_id = ? AND is_deleted = false
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
                "start_date = ?, due_date = ?, notes = ?, is_active = ?, last_updated = ?, is_deleted = ?, " +
                "payment_frequency = ?, next_payment_due = ?, minimum_payment = ?, liability_status = ?, " +
                "category = ?, total_paid = ?, last_payment_date = ?, creditor_name = ?, creditor_contact = ?, " +
                "reminder_enabled = ?, reminder_days_before = ?, monthly_payment = ? WHERE id = ?";

        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

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

            // New fields
            stmt.setString(12, liability.getPaymentFrequency());
            stmt.setObject(13, liability.getNextPaymentDue());
            stmt.setBigDecimal(14, liability.getMinimumPayment());
            stmt.setString(15, liability.getLiabilityStatus());
            stmt.setString(16, liability.getCategory());
            stmt.setBigDecimal(17, liability.getTotalPaid());
            stmt.setObject(18, liability.getLastPaymentDate());
            stmt.setString(19, liability.getCreditorName());
            stmt.setString(20, liability.getCreditorContact());
            stmt.setBoolean(21, liability.isReminderEnabled());
            if (liability.getReminderDaysBefore() != null) {
                stmt.setInt(22, liability.getReminderDaysBefore());
            } else {
                stmt.setNull(22, Types.INTEGER);
            }
            stmt.setBigDecimal(23, liability.getMonthlyPayment());

            // WHERE clause
            stmt.setInt(24, liability.getId());

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

        // Extended fields
        liability.setPaymentFrequency(rs.getString("payment_frequency"));
        liability.setNextPaymentDue(rs.getObject("next_payment_due", LocalDate.class));
        liability.setMinimumPayment(rs.getBigDecimal("minimum_payment"));
        liability.setLiabilityStatus(rs.getString("liability_status"));
        liability.setCategory(rs.getString("category"));
        liability.setTotalPaid(rs.getBigDecimal("total_paid"));
        liability.setLastPaymentDate(rs.getObject("last_payment_date", LocalDate.class));
        liability.setCreditorName(rs.getString("creditor_name"));
        liability.setCreditorContact(rs.getString("creditor_contact"));
        liability.setReminderEnabled(rs.getBoolean("reminder_enabled"));
        liability.setReminderDaysBefore(rs.getObject("reminder_days_before") != null ? rs.getInt("reminder_days_before") : null);
        liability.setMonthlyPayment(rs.getBigDecimal("monthly_payment"));

        return liability;
    }

}
