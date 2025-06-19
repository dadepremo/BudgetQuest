package budgetquest.dao.TransactionDao;

import budgetquest.model.Category;
import budgetquest.model.Transaction;
import budgetquest.model.User;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;

public interface TransactionDao {

    double getTotalByTypeAndMonth(int userId, String type, YearMonth month);

    List<Transaction> getTransactionsByType(int userId, String type, String nameFilter, LocalDate fromDate, LocalDate toDate);

    void updateTransaction(Transaction transaction) throws SQLException;

    void delete(Transaction transaction) throws SQLException;

    List<Transaction> findAllByUser(User user);

    List<Transaction> findAllIncomesByUser(User user);

    Map<String, BigDecimal> getExpensesGroupedByCategory(User user);

    Map<String, BigDecimal> getIncomesGroupedByCategory(User user);

    BigDecimal getLastMonthExpensesSum(User user);

    BigDecimal getLastMonthIncomesSum(User user);

    void insert(User user, Transaction transaction, Category category);

    List<Transaction> findAllExpensesByUser(User user);

    int countExpenses(User currentUser);

    int countIncomes(User currentUser);

    void insertFile(User user, Transaction transaction, Category category);

}

