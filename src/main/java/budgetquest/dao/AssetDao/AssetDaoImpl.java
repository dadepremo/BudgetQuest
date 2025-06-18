package budgetquest.dao.AssetDao;

import budgetquest.model.User;
import budgetquest.utils.DbConnection;
import budgetquest.model.Asset;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class AssetDaoImpl implements AssetDao {

    @Override
    public void updateAsset(Asset asset, User user) throws SQLException {
        String sql = """
        UPDATE public.assets
        SET user_id = ?,
            "name" = ?,
            "type" = ?,
            value = ?,
            acquired_date = ?,
            notes = ?,
            is_liquid = ?,
            last_updated = CURRENT_TIMESTAMP
        WHERE id = ? AND is_deleted = false
    """;

        try (Connection connection = DbConnection.connect();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            stmt.setString(2, asset.getName());
            stmt.setString(3, asset.getType());
            stmt.setBigDecimal(4, asset.getValue());
            stmt.setDate(5, asset.getAcquiredDate() != null ? java.sql.Date.valueOf(asset.getAcquiredDate()) : null);
            stmt.setString(6, asset.getNotes());
            stmt.setBoolean(7, asset.isLiquid());
            stmt.setInt(8, asset.getId());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Updating asset failed, no rows affected.");
            }
        }
    }


    @Override
    public List<Asset> searchAssets(int userId, String nameFilter, LocalDate fromDate, LocalDate toDate) {
        List<Asset> assets = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT *
        FROM assets
        WHERE user_id = ?
          AND is_deleted = false
          AND (name ILIKE ? OR type ILIKE ? OR notes ILIKE ?)
    """);

        if (fromDate != null) {
            sql.append(" AND acquired_date >= ? ");
        }
        if (toDate != null) {
            sql.append(" AND acquired_date <= ? ");
        }

        sql.append(" ORDER BY acquired_date DESC ");

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            stmt.setInt(paramIndex++, userId);
            stmt.setString(paramIndex++, "%" + nameFilter + "%");
            stmt.setString(paramIndex++, "%" + nameFilter + "%");
            stmt.setString(paramIndex++, "%" + nameFilter + "%");

            if (fromDate != null) {
                stmt.setDate(paramIndex++, Date.valueOf(fromDate));
            }
            if (toDate != null) {
                stmt.setDate(paramIndex++, Date.valueOf(toDate));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Date acquiredDateSql = rs.getDate("acquired_date");
                LocalDate acquiredDate = (acquiredDateSql != null) ? acquiredDateSql.toLocalDate() : null;

                Asset asset = new Asset(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("type"),
                        rs.getBigDecimal("value"),
                        acquiredDate,
                        rs.getString("notes"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("last_updated"),
                        rs.getBoolean("is_deleted"),
                        rs.getBoolean("is_liquid")
                );

                assets.add(asset);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return assets;
    }


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

    @Override
    public void softDelete(Asset asset) {
        String sql = """
        UPDATE public.assets
        SET is_deleted = true
        WHERE id = ? AND user_id = ?
    """;

        try (Connection connection = DbConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, asset.getId());
            stmt.setInt(2, asset.getUserId());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Deleting asset failed, no rows affected.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
