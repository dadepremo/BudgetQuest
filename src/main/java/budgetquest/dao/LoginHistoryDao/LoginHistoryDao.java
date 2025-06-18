package budgetquest.dao.LoginHistoryDao;


import java.time.LocalDate;
import java.util.*;

public interface LoginHistoryDao {

    List<LocalDate> getLoginDatesForUser(int userId);

}

