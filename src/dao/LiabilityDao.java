package dao;

import model.Liability;
import model.User;

import java.util.List;
import java.util.Optional;

public interface LiabilityDao {

    boolean insert(Liability liability);

    Optional<Liability> findById(int id);

    double sumAllLiabilitiesAmount(User user);

    List<Liability> findAllByUserId(User user);

    void update(Liability liability);

    void delete(int id);

}
