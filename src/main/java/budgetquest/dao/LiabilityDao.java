package budgetquest.dao;

import budgetquest.model.Liability;
import budgetquest.model.User;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface LiabilityDao {

    List<Liability> searchLiabilities(int userId, String nameFilter, LocalDate fromDate, LocalDate toDate);

    boolean insert(Liability liability);

    Optional<Liability> findById(int id);

    double sumAllLiabilitiesAmount(User user);

    List<Liability> findAllByUserId(User user);

    void update(Liability liability);

    void delete(int id);

}
