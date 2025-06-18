package budgetquest.dao.TransactionDao;

import budgetquest.dao.UserDao.UserDao;
import budgetquest.dao.UserDao.UserDaoImpl;
import budgetquest.model.Category;
import budgetquest.model.Transaction;
import budgetquest.model.User;
import budgetquest.utils.DbConnection;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.math.BigDecimal;
import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

public class TransactionDaoImpl implements TransactionDao {

    private static final Logger logger = LogManager.getLogger(TransactionDaoImpl.class);

    @Override
    public List<Transaction> getTransactionsByType(int userId, String type, String nameFilter, LocalDate fromDate, LocalDate toDate) {
        List<Transaction> transactions = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT t.id, t.user_id, t.category_id, t.date, t.amount, t.description, t.name,
               c.name AS category_name
        FROM transactions t
        LEFT JOIN categories c ON t.category_id = c.id AND c.is_deleted = false
        WHERE t.user_id = ?
          AND (c.type = ? OR c.type IS NULL)
          AND (t.name ILIKE ? OR c.name ILIKE ?)
    """);

        if (fromDate != null) {
            sql.append(" AND t.date >= ? ");
        }
        if (toDate != null) {
            sql.append(" AND t.date <= ? ");
        }

        sql.append(" ORDER BY t.date DESC ");

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            stmt.setInt(paramIndex++, userId);
            stmt.setString(paramIndex++, type);
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
                Transaction tx = new Transaction(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getInt("category_id"),
                        rs.getDate("date").toLocalDate(),
                        rs.getBigDecimal("amount"),
                        rs.getString("description"),
                        rs.getString("name")
                );
                tx.setCategoryName(rs.getString("category_name"));
                transactions.add(tx);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return transactions;
    }

    @Override
    public void updateTransaction(Transaction transaction) throws SQLException {
        String sql = """
        UPDATE transactions
        SET name = ?, amount = ?, date = ?, description = ?, category_id = ?, user_id = ?
        WHERE id = ?
    """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, transaction.getName());
            stmt.setBigDecimal(2, transaction.getAmount());
            stmt.setDate(3, transaction.getDate() != null ? java.sql.Date.valueOf(transaction.getDate()) : null);
            stmt.setString(4, transaction.getDescription());

            if (transaction.getCategoryId() != null) {
                stmt.setInt(5, transaction.getCategoryId());
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }

            stmt.setInt(6, transaction.getUserId());
            stmt.setInt(7, transaction.getId());

            stmt.executeUpdate();
        }
    }

    @Override
    public List<Transaction> findAllByUser(User user) {
        String sql = "SELECT * FROM transactions WHERE user_id = ?";
        List<Transaction> transactions = new ArrayList<>();

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Transaction tx = new Transaction();
                tx.setId(rs.getInt("id"));
                tx.setUserId(rs.getInt("user_id"));
                tx.setCategoryId(rs.getObject("category_id") != null ? rs.getInt("category_id") : null);
                tx.setDate(rs.getDate("date").toLocalDate());
                tx.setAmount(rs.getBigDecimal("amount"));
                tx.setDescription(rs.getString("description"));
                transactions.add(tx);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }

    @Override
    public List<Transaction> findAllExpensesByUser(User user) {
        List<Transaction> expenses = new ArrayList<>();

        String sql = """
                SELECT t.id, t.user_id, t.category_id, t.date, t.amount, t.description, t.name AS transaction_name, c.name AS category_name
                FROM transactions t
                JOIN categories c ON t.category_id = c.id
                WHERE c.type = 'expense' AND c.is_deleted = false AND t.user_id = ?
                ORDER BY t.date DESC
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Transaction tx = new Transaction();
                tx.setId(rs.getInt("id"));
                tx.setUserId(rs.getInt("user_id"));
                tx.setCategoryId(rs.getInt("category_id"));
                tx.setDate(rs.getDate("date").toLocalDate());
                tx.setAmount(rs.getBigDecimal("amount"));
                tx.setDescription(rs.getString("description"));
                tx.setName(rs.getString("transaction_name"));
                tx.setCategoryName(rs.getString("category_name"));
                expenses.add(tx);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return expenses;
    }

    @Override
    public List<Transaction> findAllIncomesByUser(User user) {
        List<Transaction> expenses = new ArrayList<>();

        String sql = """
                SELECT t.id, t.user_id, t.category_id, t.date, t.amount, t.description, t.name AS transaction_name, c.name AS category_name
                FROM transactions t
                JOIN categories c ON t.category_id = c.id
                WHERE c.type = 'income' AND c.is_deleted = false AND t.user_id = ?
                ORDER BY t.date DESC
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Transaction tx = new Transaction();
                tx.setId(rs.getInt("id"));
                tx.setUserId(rs.getInt("user_id"));
                tx.setCategoryId(rs.getInt("category_id"));
                tx.setDate(rs.getDate("date").toLocalDate());
                tx.setAmount(rs.getBigDecimal("amount"));
                tx.setDescription(rs.getString("description"));
                tx.setName(rs.getString("transaction_name"));
                tx.setCategoryName(rs.getString("category_name"));
                expenses.add(tx);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return expenses;
    }

    @Override
    public Map<String, BigDecimal> getExpensesGroupedByCategory(User user) {
        String sql = """
        SELECT c.name AS category_name, SUM(t.amount) AS total
        FROM transactions t
        JOIN categories c ON t.category_id = c.id
        WHERE t.user_id = ? AND c.type = 'expense' AND c.is_deleted = false
        GROUP BY c.name
    """;

        Map<String, BigDecimal> results = new HashMap<>();

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                results.put(rs.getString("category_name"), rs.getBigDecimal("total"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return results;
    }

    @Override
    public Map<String, BigDecimal> getIncomesGroupedByCategory(User user) {
        String sql = """
        SELECT c.name AS category_name, SUM(t.amount) AS total
        FROM transactions t
        JOIN categories c ON t.category_id = c.id
        WHERE t.user_id = ? AND c.type = 'income' AND c.is_deleted = false
        GROUP BY c.name
    """;

        Map<String, BigDecimal> results = new HashMap<>();

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                results.put(rs.getString("category_name"), rs.getBigDecimal("total"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return results;
    }

    @Override
    public BigDecimal getLastMonthExpensesSum(User user) {
        String sql = """
        SELECT SUM(t.amount) AS summed_expenses
        FROM transactions t
        INNER JOIN categories c ON t.category_id = c.id
        WHERE t.user_id = ?
          AND c.type = 'expense'
          AND t.date >= date_trunc('month', CURRENT_DATE) - INTERVAL '1 month'
          AND t.date < date_trunc('month', CURRENT_DATE);
    """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                BigDecimal result = rs.getBigDecimal("summed_expenses");
                return result != null ? result : BigDecimal.ZERO;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return BigDecimal.ZERO;  // fallback if query fails or has no rows
    }


    @Override
    public BigDecimal getLastMonthIncomesSum(User user) {
        String sql = """
        SELECT SUM(t.amount) AS summed_incomes
        FROM transactions t
        INNER JOIN categories c ON t.category_id = c.id
        WHERE t.user_id = ?
          AND c.type = 'income'
          AND t.date >= date_trunc('month', CURRENT_DATE) - INTERVAL '1 month'
          AND t.date < date_trunc('month', CURRENT_DATE);
    """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                BigDecimal result = rs.getBigDecimal("summed_incomes");
                return result != null ? result : BigDecimal.ZERO;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return BigDecimal.ZERO;
    }

    @Override
    public int countExpenses(User user) {
        String sql = """
        select count(*) as counter from transactions t inner join categories c on t.category_id = c.id where c.user_id = ? and c."type" = 'expense'
    """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int result = rs.getInt("counter");
                logger.info("The number of expenses is " + result);
                return result;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public int countIncomes(User user) {
        String sql = """
        select count(*) as counter from transactions t inner join categories c on t.category_id = c.id where c.user_id = ? and c."type" = 'income'
    """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int result = rs.getInt("counter");
                logger.info("The number of incomes is " + result);
                return result;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public void insert(User user, Transaction transaction, Category category) {
        String sql = """
            INSERT INTO transactions (user_id, category_id, name, date, amount, description) VALUES (?, ?, ?, ?, ?, ?);
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            stmt.setInt(2, category.getId());
            stmt.setString(3, transaction.getName());
            stmt.setDate(4, Date.valueOf(transaction.getDate()));
            stmt.setBigDecimal(5, transaction.getAmount());
            stmt.setString(6, transaction.getDescription());

            UserDao userDao = new UserDaoImpl();
            int xp = transaction.getAmount().intValue();

            if (xp < 1000) {
                userDao.updateUserLevel(user, 50);
            } else if (xp < 10000) {
                userDao.updateUserLevel(user, 100);
            } else {
                userDao.updateUserLevel(user, 500);
            }

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void insertFile(User user, Transaction transaction, Category category) {
        String sql = """
            INSERT INTO transactions (user_id, category_id, name, date, amount, description) VALUES (?, ?, ?, ?, ?, ?);
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            stmt.setInt(2, category.getId());
            stmt.setString(3, transaction.getName());
            stmt.setDate(4, Date.valueOf(transaction.getDate()));
            stmt.setBigDecimal(5, transaction.getAmount());
            stmt.setString(6, transaction.getDescription());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
