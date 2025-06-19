package budgetquest.dao.XpGiverDao;

import budgetquest.model.XpGiver;
import budgetquest.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class XpGiverDaoImpl implements XpGiverDao {

    @Override
    public Optional<XpGiver> getById(int id) {
        String query = "SELECT * FROM xp_givers WHERE id = ? AND is_deleted = false";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                XpGiver xp = mapRow(rs);
                return Optional.of(xp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public int getValueByName(String name) {
        String query = "SELECT value FROM xp_givers WHERE name = ? AND is_deleted = false";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("value");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<XpGiver> getAll() {
        List<XpGiver> list = new ArrayList<>();
        String query = "SELECT * FROM xp_givers WHERE is_deleted = false ORDER BY id";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public boolean insert(XpGiver xpGiver) {
        String query = "INSERT INTO xp_givers(name, description, value) VALUES (?, ?, ?)";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, xpGiver.getName());
            stmt.setString(2, xpGiver.getDescription());
            stmt.setInt(3, xpGiver.getValue());

            return stmt.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean update(XpGiver xpGiver) {
        String query = "UPDATE xp_givers SET name = ?, description = ?, value = ?, is_deleted = ? WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, xpGiver.getName());
            stmt.setString(2, xpGiver.getDescription());
            stmt.setInt(3, xpGiver.getValue());
            stmt.setBoolean(4, xpGiver.isDeleted());
            stmt.setInt(5, xpGiver.getId());

            return stmt.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean delete(int id) {
        String query = "UPDATE xp_givers SET is_deleted = true WHERE id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private XpGiver mapRow(ResultSet rs) throws SQLException {
        return new XpGiver(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getInt("value"),
                rs.getBoolean("is_deleted")
        );
    }
}
