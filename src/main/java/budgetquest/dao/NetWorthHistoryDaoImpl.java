package budgetquest.dao;

import budgetquest.model.NetWorthHistory;
import budgetquest.model.User;
import budgetquest.utils.DbConnection;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class NetWorthHistoryDaoImpl implements NetWorthHistoryDao {

    private static final Logger logger = LogManager.getLogger(NetWorthHistoryDaoImpl.class);

    @Override
    public void insert(int userId, LocalDate date, BigDecimal assets, BigDecimal liabilities) {
        String sql = """
            INSERT INTO net_worth_history (user_id, date, assets_value, liabilities_value, net_worth) VALUES (?, ?, ?, ?, ?)
        """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setDate(2, Date.valueOf(date));
            stmt.setBigDecimal(3, assets);
            stmt.setBigDecimal(4, liabilities);
            stmt.setBigDecimal(5, assets.subtract(liabilities));

            stmt.executeUpdate();
            logger.info("Net worth history record added");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Optional<LocalDate> findLastForUser(User user) {
        String sql = """
        SELECT * FROM net_worth_history WHERE user_id = ? ORDER BY date DESC LIMIT 1
    """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return Optional.of(rs.getDate("date").toLocalDate());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return Optional.empty();
    }


    @Override
    public List<NetWorthHistory> findAllByUser(User user) {
        List<NetWorthHistory> list = new ArrayList<>();
        String sql = "SELECT * FROM net_worth_history WHERE user_id = ? ORDER BY date";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                NetWorthHistory history = new NetWorthHistory();
                history.setId(rs.getInt("id"));
                history.setUserId(rs.getInt("user_id"));
                history.setDate(rs.getDate("date").toLocalDate());
                history.setAssetsValue(rs.getBigDecimal("assets_value"));
                history.setLiabilitiesValue(rs.getBigDecimal("liabilities_value"));
                history.setNetWorth(rs.getBigDecimal("net_worth"));
                history.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());

                list.add(history);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
