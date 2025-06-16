package dao;

import model.Category;
import model.Transaction;
import model.User;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface TransactionDao {

    List<Transaction> getTransactionsByType(int userId, String type, String nameFilter, LocalDate fromDate, LocalDate toDate);

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
}

