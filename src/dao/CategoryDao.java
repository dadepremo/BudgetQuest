package dao;

import model.Category;
import model.User;

import java.util.List;

public interface CategoryDao {

    List<Category> findAllByUser(User user);

    void insert(User user, Category category);

    List<Category> findCategoriesByUserAndType(User currentUser, String type);

    Category findCategorieByUserAndTypeAndName(User currentUser, String type, String name);

}

