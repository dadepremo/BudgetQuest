package controller;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import model.User;

public class UserProfileController {

    @FXML private Label usernameLabel;
    @FXML private Label firstNameLabel;
    @FXML private Label lastNameLabel;
    @FXML private Label emailLabel;
    @FXML private Label levelLabel;
    @FXML private Label xpLabel;
    @FXML private Label pointsLabel;

    public void setUser(User user) {
        usernameLabel.setText(user.getUsername());
        firstNameLabel.setText(user.getFirstName() != null ? user.getFirstName() : "");
        lastNameLabel.setText(user.getLastName() != null ? user.getLastName() : "");
        emailLabel.setText(user.getEmail() != null ? user.getEmail() : "");
        levelLabel.setText(String.valueOf(user.getLevel()));
        xpLabel.setText(user.getXp() + " / " + (user.getLevel() + 1) * 500 + " XP");
        pointsLabel.setText(user.getPoints() + " DP");
    }
}
