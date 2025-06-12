package controller;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Modality;
import javafx.stage.Stage;
import model.User;

import java.io.IOException;

public class UserProfileController {

    @FXML private Label usernameLabel;
    @FXML private Label firstNameLabel;
    @FXML private Label lastNameLabel;
    @FXML private Label emailLabel;
    @FXML private Label levelLabel;
    @FXML private Label xpLabel;
    @FXML private Label pointsLabel;

    private User user;

    public void setUser(User user) {
        this.user = user;
        usernameLabel.setText(user.getUsername());
        firstNameLabel.setText(user.getFirstName() != null ? user.getFirstName() : "");
        lastNameLabel.setText(user.getLastName() != null ? user.getLastName() : "");
        emailLabel.setText(user.getEmail() != null ? user.getEmail() : "");
        levelLabel.setText(String.valueOf(user.getLevel()));
        xpLabel.setText(user.getXp() + " / " + (user.getLevel() + 1) * 500 + " XP");
        pointsLabel.setText(user.getPoints() + " DP");
    }

    @FXML
    private void handleOpenAchievements() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/achievements.fxml"));
            Parent root = loader.load();

            AchievementsController controller = loader.getController();
            controller.setUser(user);

            Stage stage = new Stage();
            stage.setTitle("Achievements");
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.setScene(new Scene(root));
            stage.showAndWait();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
