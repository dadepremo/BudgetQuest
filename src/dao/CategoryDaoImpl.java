package dao;

// CategoryDaoImpl.java
import model.Category;
import model.Liability;
import model.User;
import utils.DbConnection;
import utils.Logger;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao {

    @Override
    public List<Category> findAllByUser(User user) {
        String sql = "SELECT * FROM categories WHERE user_id = ? AND is_deleted = false";
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
            Logger.info("Category added: " + category.getName() + " (" + category.getType() + ")");

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

