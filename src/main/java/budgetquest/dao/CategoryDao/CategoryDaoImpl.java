package budgetquest.dao.CategoryDao;

// CategoryDaoImpl.java
import budgetquest.dao.UserDao.UserDao;
import budgetquest.dao.UserDao.UserDaoImpl;
import budgetquest.model.Category;
import budgetquest.model.User;
import budgetquest.utils.DbConnection;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao {

    private static final Logger logger = LogManager.getLogger(CategoryDaoImpl.class);

    @Override
    public List<Category> findAllByUser(User user) {
        String sql = "SELECT * FROM categories WHERE user_id = ? AND is_deleted = false and name != 'Not categorized'";
        List<Category> categories = new ArrayList<>();

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Category cat = new Category();
                cat.setId(rs.getInt("id"));
                cat.setUserId(rs.getInt("user_id"));
                cat.setName(rs.getString("name"));
                cat.setType(rs.getString("type"));
                cat.setDeleted(rs.getBoolean("is_deleted"));
                categories.add(cat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    @Override
    public void insert(User user, Category category) {
        String sql = """
            INSERT INTO categories (user_id, "name", "type", is_deleted) VALUES(?, ?, ?, false);
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            stmt.setString(2, category.getName());
            stmt.setString(3, category.getType().toLowerCase());

            stmt.executeUpdate();
            logger.info("Category added: " + category.getName() + " (" + category.getType() + ")");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void insertForNew(User user, Category category) {
        String sql = """
            INSERT INTO categories (user_id, "name", "type", is_deleted) VALUES(?, ?, ?, false);
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            UserDao userDao = new UserDaoImpl();
            User user1 = userDao.getUserByUsername(user.getUsername()).get();

            stmt.setInt(1, user1.getId());
            stmt.setString(2, category.getName());
            stmt.setString(3, category.getType().toLowerCase());

            stmt.executeUpdate();
            logger.info("Category added: " + category.getName() + " (" + category.getType() + ")");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Category> findCategoriesByUserAndType(User currentUser, String type) {
        String sql = "SELECT * FROM categories WHERE user_id = ? AND is_deleted = false AND type = ?";
        List<Category> categories = new ArrayList<>();

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, currentUser.getId());
            stmt.setString(2, type.toLowerCase());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Category cat = new Category();
                cat.setId(rs.getInt("id"));
                cat.setUserId(rs.getInt("user_id"));
                cat.setName(rs.getString("name"));
                cat.setType(rs.getString("type"));
                cat.setDeleted(rs.getBoolean("is_deleted"));
                categories.add(cat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    @Override
    public Category findCategorieByUserAndTypeAndName(User currentUser, String type, String name) {
        String sql = "SELECT * FROM categories WHERE user_id = ? AND is_deleted = false AND type = ? AND name = ? limit 1";
        Category cat = new Category();
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, currentUser.getId());
            stmt.setString(2, type.toLowerCase());
            stmt.setString(3, name);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToCategory(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cat;
    }

    @Override
    public void update(Category c, int userId) {
        String sql = """
            UPDATE categories SET "name" = ?, "type" = ? WHERE user_id = ? AND id = ?;
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(3, userId);
            stmt.setString(1, c.getName());
            stmt.setString(2, c.getType().toLowerCase());
            stmt.setInt(4, c.getId());

            stmt.executeUpdate();
            logger.info("Category added: " + c.getName() + " (" + c.getType() + ")");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Category mapResultSetToCategory(ResultSet rs) throws SQLException {
        Category category = new Category();

        category.setType(rs.getString("type"));
        category.setName(rs.getString("name"));
        category.setId(rs.getInt("id"));
        category.setDeleted(rs.getBoolean("is_deleted"));
        category.setUserId(rs.getInt("user_id"));

        return category;
    }


}

