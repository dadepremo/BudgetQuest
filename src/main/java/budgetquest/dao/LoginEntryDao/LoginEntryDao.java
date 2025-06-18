package budgetquest.dao.LoginEntryDao;

import java.time.LocalDate;
import java.util.List;

public interface LoginEntryDao {

    List<LocalDate> getLoginDatesForUser(int userId);

    void addLoginEntry(int userId, LocalDate loginDate);
}
