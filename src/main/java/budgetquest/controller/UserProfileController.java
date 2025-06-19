package budgetquest.controller;

import javafx.animation.PauseTransition;
import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.util.Duration;
import budgetquest.model.User;
import budgetquest.utils.DbConnection;
import budgetquest.utils.MyUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import java.net.URL;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class UserProfileController {

    private static final Logger logger = LogManager.getLogger(UserProfileController.class);
    @FXML private BorderPane mainRoot;

    @FXML private Label usernameLabel;
    @FXML private Label firstNameLabel;
    @FXML private Label lastNameLabel;
    @FXML private Label emailLabel;
    @FXML private Label levelLabel;
    @FXML private Label xpLabel;
    @FXML private Label pointsLabel;

    @FXML private TextField friendSearchField;
    @FXML private ListView<User> friendSearchResults;
    @FXML private ListView<User> friendList;
    @FXML private ListView<User> incomingRequestsList;

    @FXML private Label friendSearchLabel;
    @FXML private Label friendListLabel;
    @FXML private Label friendRequestsLabel;
    @FXML private Label friendsTitleLabel;
    @FXML private HBox friendSearchBox;
    @FXML private Button friendSearchButton;
    @FXML private VBox friendRequestButtonsBox;
    @FXML private Button achievementsButton;



    private User user;

    public void setUser(User user, boolean isOwnProfile) {
        this.user = user;

        usernameLabel.setText(user.getUsername());
        firstNameLabel.setText(user.getFirstName() != null ? user.getFirstName() : "");
        lastNameLabel.setText(user.getLastName() != null ? user.getLastName() : "");
        emailLabel.setText(user.getEmail() != null ? user.getEmail() : "");
        levelLabel.setText(String.valueOf(user.getLevel()));
        xpLabel.setText(MyUtils.formatInt(user.getXp()) + " / " + MyUtils.formatInt((user.getLevel() + 1) * 500) + " XP");
        pointsLabel.setText(MyUtils.formatDpPoints(user.getPoints()));

        if (isOwnProfile) {
            loadUserFriends();
            loadIncomingFriendRequests();
        } else {
            hideFriendControls();
        }

        if (user.getTheme().equalsIgnoreCase("dark")) {
            mainRoot.getStylesheets().clear();
            mainRoot.getStylesheets().add(Objects.requireNonNull(getClass().getResource("/style/profile_dark.css")).toExternalForm());
        } else {
            mainRoot.getStylesheets().clear();
            mainRoot.getStylesheets().add(Objects.requireNonNull(getClass().getResource("/style/profile_light.css")).toExternalForm());
        }
    }




    @FXML
    private void initialize() {
        PauseTransition pause = new PauseTransition(Duration.millis(300));
        friendSearchField.textProperty().addListener((obs, oldText, newText) -> {
            pause.stop();
            pause.setOnFinished(event -> performSearch(newText.trim()));
            pause.playFromStart();
        });

        friendSearchResults.setCellFactory(lv -> new ListCell<>() {
            @Override
            protected void updateItem(User user, boolean empty) {
                super.updateItem(user, empty);
                if (empty || user == null) {
                    setText(null);
                } else {
                    setText(user.getUsername() + " (" + user.getEmail() + ")");
                    setTooltip(MyUtils.createInstantTooltip("Double click to send friend request to " + user.getFirstName() + " " + user.getLastName()));
                }
            }
        });

        friendList.setCellFactory(lv -> new ListCell<>() {
            @Override
            protected void updateItem(User user, boolean empty) {
                super.updateItem(user, empty);
                if (empty || user == null) {
                    setText(null);
                } else {
                    setText(user.getUsername());
                    setTooltip(MyUtils.createInstantTooltip("Double click to open " + user.getUsername().toUpperCase() + " profile"));
                }
            }
        });

        // Add double-click listener to send friend requests
        friendSearchResults.setOnMouseClicked(event -> {
            if (event.getClickCount() == 2) {
                User selected = friendSearchResults.getSelectionModel().getSelectedItem();
                if (selected != null) {
                    handleAddFriend(selected);
                }
            }
        });

        friendList.setOnMouseClicked(event -> {
            if (event.getClickCount() == 2) {
                User selectedFriend = friendList.getSelectionModel().getSelectedItem();
                if (selectedFriend != null) {
                    openFriendProfile(selectedFriend);
                }
            }
        });

    }

    private void openFriendProfile(User friend) {
        Platform.runLater(() -> {
            try {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/user_profile.fxml"));
                Parent root = loader.load();

                UserProfileController controller = loader.getController();
                controller.setUser(friend, false);

                Stage stage = new Stage();
                stage.setTitle(friend.getUsername() + "'s Profile");
                stage.initModality(Modality.APPLICATION_MODAL);
                stage.setScene(new Scene(root));
                stage.show();

            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }

    private void hideFriendControls() {
        friendSearchField.setVisible(false);
        friendSearchField.setManaged(false);

        friendSearchResults.setVisible(false);
        friendSearchResults.setManaged(false);

        friendSearchLabel.setVisible(false);
        friendSearchLabel.setManaged(false);

        friendList.setVisible(false);
        friendList.setManaged(false);

        friendListLabel.setVisible(false);
        friendListLabel.setManaged(false);

        incomingRequestsList.setVisible(false);
        incomingRequestsList.setManaged(false);

        friendRequestsLabel.setVisible(false);
        friendRequestsLabel.setManaged(false);

        friendsTitleLabel.setVisible(false);
        friendsTitleLabel.setManaged(false);

        friendSearchBox.setVisible(false);
        friendSearchBox.setManaged(false);

        friendRequestButtonsBox.setVisible(false);
        friendRequestButtonsBox.setManaged(false);

        achievementsButton.setVisible(false);
        achievementsButton.setManaged(false);
    }


    private void loadIncomingFriendRequests() {
        new Thread(() -> {
            List<User> requests = fetchIncomingRequests(user.getId());
            Platform.runLater(() -> incomingRequestsList.getItems().setAll(requests));
        }).start();
    }

    private List<User> fetchIncomingRequests(int userId) {
        List<User> requests = new ArrayList<>();
        String sql = """
        SELECT u.id, u.username, u.first_name, u.last_name, u.email, u.level, u.xp, u.points
        FROM user_friends uf
        JOIN users u ON u.id = uf.user_id
        WHERE uf.friend_id = ? AND uf.status = 'pending'
    """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setFirstName(rs.getString("first_name"));
                u.setLastName(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setLevel(rs.getInt("level"));
                u.setXp(rs.getInt("xp"));
                u.setPoints(rs.getInt("points"));
                requests.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return requests;
    }

    @FXML
    private void handleAcceptFriend() {
        User selected = incomingRequestsList.getSelectionModel().getSelectedItem();
        if (selected == null) return;

        new Thread(() -> {
            boolean success = acceptFriendRequest(selected.getId(), user.getId());
            if (success) {
                logger.info("Accepted friend request from " + selected.getUsername());
                loadUserFriends();
                loadIncomingFriendRequests();
            }
        }).start();
    }

    @FXML
    private void handleRejectFriend() {
        User selected = incomingRequestsList.getSelectionModel().getSelectedItem();
        if (selected == null) return;

        new Thread(() -> {
            boolean success = rejectFriendRequest(selected.getId(), user.getId());
            if (success) {
                logger.info("Rejected friend request from " + selected.getUsername());
                loadIncomingFriendRequests();
            }
        }).start();
    }

    private boolean acceptFriendRequest(int fromId, int toId) {
        String sql = "UPDATE user_friends SET status = 'accepted', accepted_at = NOW() WHERE user_id = ? AND friend_id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, fromId);
            stmt.setInt(2, toId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean rejectFriendRequest(int fromId, int toId) {
        String sql = "DELETE FROM user_friends WHERE user_id = ? AND friend_id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, fromId);
            stmt.setInt(2, toId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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

    @FXML
    public void handleSearchFriends() {
        String query = friendSearchField.getText().trim();
        performSearch(query);
    }

    private void performSearch(String query) {
        if (query.isEmpty()) {
            Platform.runLater(() -> friendSearchResults.getItems().clear());
            return;
        }

        new Thread(() -> {
            List<User> results = searchUsersInDatabase(query);
            Platform.runLater(() -> friendSearchResults.getItems().setAll(results));
        }).start();
    }

    private List<User> searchUsersInDatabase(String query) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, first_name, last_name, email, level, xp, points FROM users WHERE username LIKE ? OR email LIKE ? LIMIT 20";

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String pattern = "%" + query + "%";
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                if (rs.getInt("id") == user.getId()) continue; // Skip yourself

                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setFirstName(rs.getString("first_name"));
                u.setLastName(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setLevel(rs.getInt("level"));
                u.setXp(rs.getInt("xp"));
                u.setPoints(rs.getInt("points"));
                users.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    private void loadUserFriends() {
        new Thread(() -> {
            List<User> friends = fetchFriendsForUser(user);
            Platform.runLater(() -> friendList.getItems().setAll(friends));
        }).start();
    }

    private List<User> fetchFriendsForUser(User user) {
        List<User> friends = new ArrayList<>();
        String sql = """
    SELECT u.id, u.username, u.first_name, u.last_name, u.email, u.level, u.xp, u.points
    FROM users u
    JOIN user_friends uf ON u.id = uf.friend_id
    WHERE uf.user_id = ? AND uf.status = 'accepted'
    UNION
    SELECT u.id, u.username, u.first_name, u.last_name, u.email, u.level, u.xp, u.points
    FROM users u
    JOIN user_friends uf ON u.id = uf.user_id
    WHERE uf.friend_id = ? AND uf.status = 'accepted'
    """;

        try (Connection conn = DbConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            stmt.setInt(2, user.getId());
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User friend = new User();
                friend.setId(rs.getInt("id"));
                friend.setUsername(rs.getString("username"));
                friend.setFirstName(rs.getString("first_name"));
                friend.setLastName(rs.getString("last_name"));
                friend.setEmail(rs.getString("email"));
                friend.setLevel(rs.getInt("level"));
                friend.setXp(rs.getInt("xp"));
                friend.setPoints(rs.getInt("points"));
                friends.add(friend);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friends;
    }


    // === New methods for friend requests ===

    private void handleAddFriend(User friendToAdd) {
        if (friendToAdd.getId() == user.getId()) {
            MyUtils.showWarning("Friends request", "Cannot add yourself as friend.");
            return;
        }

        new Thread(() -> {
            boolean success = sendFriendRequest(user.getId(), friendToAdd.getId());
            Platform.runLater(() -> {
                if (success) {
                    logger.debug("Friend request sent to " + friendToAdd.getUsername());
                    MyUtils.showInfo("Friends request", "Friend request sent to " + friendToAdd.getUsername());
                    friendSearchResults.getItems().remove(friendToAdd);
                } else {
                    MyUtils.showWarning("Friends request", "Failed to send friend request (already exists or error).");
                }
            });
        }).start();
    }

    private boolean sendFriendRequest(int userId, int friendId) {
        String checkSql = "SELECT 1 FROM user_friends WHERE user_id = ? AND friend_id = ?";
        String insertSql = "INSERT INTO user_friends (user_id, friend_id, status) VALUES (?, ?, 'pending')";

        try (Connection conn = DbConnection.connect()) {
            // Check for existing request/friendship
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, userId);
                checkStmt.setInt(2, friendId);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    return false; // Already requested or friends
                }
            }

            // Insert friend request
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, friendId);
                insertStmt.executeUpdate();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void handleOpenGoals() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/goal_manager.fxml"));
            Parent root = loader.load();

            GoalManagerController controller = loader.getController();
            controller.setUser(user);

            Stage stage = new Stage();
            stage.setTitle("Goals");
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.setScene(new Scene(root));
            stage.showAndWait();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
