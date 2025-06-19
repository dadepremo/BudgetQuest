package budgetquest.dao.NetWorthHistoryDao;

import budgetquest.model.NetWorthHistory;
import budgetquest.model.User;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface NetWorthHistoryDao {

    void insert(int userId, LocalDate date, BigDecimal assets, BigDecimal liabilities);

    Optional<LocalDate> findLastForUser(User user);

    List<NetWorthHistory> findAllByUser(User user);

}
