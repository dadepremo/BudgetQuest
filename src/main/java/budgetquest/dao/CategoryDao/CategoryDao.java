package budgetquest.dao.CategoryDao;

import budgetquest.model.Category;
import budgetquest.model.User;

import java.util.List;

public interface CategoryDao {

    List<Category> findAllByUser(User user);

    void insert(User user, Category category);

    void insertGetId(User user, Category category);

    void insertForNew(User user, Category category);

    List<Category> findCategoriesByUserAndType(User currentUser, String type);

    Category findCategorieByUserAndTypeAndName(User currentUser, String type, String name);

    void update(Category c, int userId);
}

