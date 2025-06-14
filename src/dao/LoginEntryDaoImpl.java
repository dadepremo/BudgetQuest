package dao;

import utils.DbConnection;
import utils.Logger;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class LoginEntryDaoImpl implements LoginEntryDao {

    @Override
    public List<LocalDate> getLoginDatesForUser(int userId) {
        List<LocalDate> loginDates = new ArrayList<>();

        String sql = "SELECT login_date FROM login_history WHERE user_id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                loginDates.add(rs.getDate("login_date").toLocalDate());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return loginDates;
    }

    @Override
    public void addLoginEntry(int userId, LocalDate loginDate) {
        String sql = "INSERT INTO login_history(user_id, login_date) VALUES (?, ?)";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setDate(2, Date.valueOf(loginDate));
            stmt.executeUpdate();
            Logger.info("Added new login entry history");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
