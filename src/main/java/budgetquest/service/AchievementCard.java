package budgetquest.service;

import javafx.geometry.Insets;
import javafx.scene.control.Label;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import budgetquest.model.Achievement;
import budgetquest.model.User;
import budgetquest.utils.DbConnection;

import java.sql.*;
import java.util.Arrays;
import java.util.List;

public class AchievementCard extends VBox {

    public AchievementCard(Achievement achievement, boolean unlocked, String unlockedAt) {
        setPadding(new Insets(15));
        setSpacing(8);
        setPrefWidth(300);
        setStyle("-fx-background-color: white; -fx-background-radius: 10; -fx-effect: dropshadow(three-pass-box, rgba(0,0,0,0.1), 5, 0, 0, 2);");

        // Title
        Label title = new Label(unlocked ? "🏆 " + achievement.getName() : "🔒 ???");
        title.setFont(Font.font("Arial", 18));
        title.setStyle("-fx-font-weight: bold;");

        // Description
        if (unlocked) {
            List<String> descParts;
            descParts = Arrays.asList(achievement.getDescription().split("&"));
            StringBuilder stringBuilder = new StringBuilder();
            for (String s : descParts)
                stringBuilder.append(s).append("\n");
            achievement.setDescription(stringBuilder.toString());
        }
        Label desc = new Label(unlocked ? achievement.getDescription() : "???");
        desc.setWrapText(true);

        // Rewards
        Label rewards = new Label(unlocked
                ? "⭐ XP: +" + achievement.getXpReward() + "   🎯 Points: +" + achievement.getPointsReward()
                : "⭐ XP: ???   🎯 Points: ???");

        // Date
        String dateText = "";
        if (unlockedAt != null && !unlockedAt.isEmpty()) {
            int ind = unlockedAt.lastIndexOf(".");
            if (ind > 0) {
                String result = unlockedAt.substring(0, ind);
                dateText = result.replace("T", " ");
            } else {
                dateText = unlockedAt.replace("T", " ");
            }
        }

        Label date = new Label(unlocked ? "🗓️ Unlocked at: " + dateText : "");


        getChildren().addAll(title, desc, rewards, date);

        if (unlocked) {
            setBorder(new Border(new BorderStroke(Color.LIGHTGREEN, BorderStrokeStyle.SOLID, new CornerRadii(10), new BorderWidths(2))));
        } else {
            setOpacity(0.5);
        }
    }

    public String getUnlockedAt(User user, String code) {
        String sql = "SELECT u.unlocked_at FROM user_achievements u " +
                "JOIN achievements a ON u.achievement_id = a.id " +
                "WHERE u.user_id = ? AND a.code = ?";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            stmt.setString(2, code);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Timestamp ts = rs.getTimestamp("unlocked_at");
                return ts != null ? ts.toLocalDateTime().toString() : "Unknown";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "";
    }

}

