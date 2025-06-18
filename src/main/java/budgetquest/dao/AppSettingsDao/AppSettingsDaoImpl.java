package budgetquest.dao.AppSettingsDao;

import budgetquest.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AppSettingsDaoImpl implements AppSettingsDao {

    @Override
    public String getSetting(String key) {
        String sql = "SELECT value FROM app_settings WHERE key = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, key);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("value");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "";
    }
}
