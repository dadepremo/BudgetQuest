package dao;


import model.ShopItem;
import utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShopItemDaoImpl implements ShopItemDao {

    @Override
    public List<ShopItem> getAllItems() {
        List<ShopItem> items = new ArrayList<>();
        String query = "SELECT * FROM shop_items WHERE available = TRUE ORDER BY id";
        try (Connection connection = DbConnection.connect();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                items.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    @Override
    public ShopItem getItemById(int id) {
        String query = "SELECT * FROM shop_items WHERE id = ?";
        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insertItem(ShopItem item) {
        String query = "INSERT INTO shop_items (name, description, price, category, available) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, item.getName());
            stmt.setString(2, item.getDescription());
            stmt.setInt(3, item.getPrice());
            stmt.setString(4, item.getCategory());
            stmt.setBoolean(5, item.isAvailable());
            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateItem(ShopItem item) {
        String query = "UPDATE shop_items SET name = ?, description = ?, price = ?, category = ?, available = ? WHERE id = ?";
        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, item.getName());
            stmt.setString(2, item.getDescription());
            stmt.setInt(3, item.getPrice());
            stmt.setString(4, item.getCategory());
            stmt.setBoolean(5, item.isAvailable());
            stmt.setInt(6, item.getId());
            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteItem(int id) {
        String query = "DELETE FROM shop_items WHERE id=?";
        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private ShopItem mapRow(ResultSet rs) throws SQLException {
        return new ShopItem(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getInt("price"),
                rs.getString("category"),
                rs.getBoolean("available")
        );
    }
}
