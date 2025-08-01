package budgetquest.dao.LiabilityDao;

import budgetquest.model.Liability;
import budgetquest.model.User;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface LiabilityDao {

    void updateLiability(Liability liability, User user) throws SQLException;

    List<Liability> searchLiabilities(int userId, String nameFilter, LocalDate fromDate, LocalDate toDate);

    boolean insert(Liability  liability, int userId);

    Optional<Liability> findById(int id);

    double sumAllLiabilitiesAmount(User user);

    List<Liability> findAllByUserId(User user);

    void update(Liability liability);

    void delete(int id);

    void softDelete(Liability liability);

}
