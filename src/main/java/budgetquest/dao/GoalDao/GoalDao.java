package budgetquest.dao.GoalDao;

import budgetquest.model.Goal;
import budgetquest.model.User;

import java.util.List;

public interface GoalDao {

    void create(Goal goal);

    List<Goal> findAllByUser(User user);

    Goal findById(int id);

    void update(Goal goal);

    void delete(int id);

}
