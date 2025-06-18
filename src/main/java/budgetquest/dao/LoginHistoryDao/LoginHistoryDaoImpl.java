package budgetquest.dao.LoginHistoryDao;

import budgetquest.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class LoginHistoryDaoImpl implements LoginHistoryDao {

    @Override
    public List<LocalDate> getLoginDatesForUser(int userId) {
        List<LocalDate> dates = new ArrayList<>();
        String sql = "SELECT login_date FROM login_history WHERE user_id = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                dates.add(rs.getDate("login_date").toLocalDate());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dates;
    }
}
