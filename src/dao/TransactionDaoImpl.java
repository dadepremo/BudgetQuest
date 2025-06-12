package dao;

// TransactionDaoImpl.java
import model.Category;
import model.Transaction;
import model.User;
import utils.DbConnection;
import utils.Logger;
import utils.MyUtils;

import java.math.BigDecimal;
import java.sql.*;
import java.sql.Date;
import java.util.*;

public class TransactionDaoImpl implements TransactionDao {

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
                tx.setAccountId(rs.getObject("account_id") != null ? rs.getInt("account_id") : null);
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
                tx.setAmount(rs.getBigDecimal("amount").negate());
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
        WHERE c.user_id = ?
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
        WHERE c.user_id = ?
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
                Logger.info("The number of expenses is " + result);
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
                Logger.info("The number of incomes is " + result);
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
                if (Objects.equals(category.getType(), "expense")) {
                    userDao.updateUserLevel(user, -50);
                } else {
                    userDao.updateUserLevel(user, 50);
                }
            } else if (xp < 10000) {
                if (Objects.equals(category.getType(), "expense")) {
                    userDao.updateUserLevel(user, -100);
                } else {
                    userDao.updateUserLevel(user, 100);
                }
            } else {
                if (Objects.equals(category.getType(), "expense")) {
                    userDao.updateUserLevel(user, -500);
                } else {
                    userDao.updateUserLevel(user, 500);
                }
            }

            stmt.executeUpdate();
            Logger.info("Transaction saved: " + MyUtils.formatCurrency(transaction.getAmount(), user.getCurrencySymbol()) + " in " + category.getName() + " (" + category.getType() + ")");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
