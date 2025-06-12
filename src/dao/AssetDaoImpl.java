package dao;

import model.User;
import utils.DbConnection;
import model.Asset;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AssetDaoImpl implements AssetDao {

    @Override
    public boolean insertAsset(Asset asset) {
        String sql = """
            INSERT INTO assets (user_id, name, type, value, acquired_date, notes, is_liquid)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, asset.getUserId());
            stmt.setString(2, asset.getName());
            stmt.setString(3, asset.getType());
            stmt.setBigDecimal(4, asset.getValue());
            stmt.setDate(5, asset.getAcquiredDate() != null ? java.sql.Date.valueOf(asset.getAcquiredDate()) : null);
            stmt.setString(6, asset.getNotes());
            stmt.setBoolean(7, asset.isLiquid());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public double sumAllAssetValues(User user) {
        String sql = """
        SELECT SUM(value) as summed_assets FROM assets WHERE user_id = ? AND is_deleted = false
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("summed_assets");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }

    @Override
    public List<Asset> findAllByUser(User user) {
        List<Asset> assets = new ArrayList<>();

        String sql = "SELECT * FROM assets WHERE user_id = ? AND is_deleted = false";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Asset asset = new Asset();
                asset.setId(rs.getInt("id"));
                asset.setUserId(rs.getInt("user_id"));
                asset.setName(rs.getString("name"));
                asset.setType(rs.getString("type"));
                asset.setValue(rs.getBigDecimal("value"));
                asset.setAcquiredDate(rs.getDate("acquired_date") != null ? rs.getDate("acquired_date").toLocalDate() : null);
                asset.setNotes(rs.getString("notes"));
                asset.setLiquid(rs.getBoolean("is_liquid"));
                asset.setCreatedAt(rs.getTimestamp("created_at"));
                asset.setLastUpdated(rs.getTimestamp("last_updated"));
                asset.setIs_deleted(rs.getBoolean("is_deleted"));
                assets.add(asset);
            }
            return assets;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return assets;
    }

}
