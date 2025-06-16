package budgetquest.model;

import java.time.LocalDateTime;

public class UserFriend {
    private int userId;
    private int friendId;
    private String status; // "pending", "accepted", "blocked"
    private LocalDateTime requestedAt;
    private LocalDateTime acceptedAt;

    public UserFriend() {}

    public UserFriend(int userId, int friendId, String status, LocalDateTime requestedAt, LocalDateTime acceptedAt) {
        this.userId = userId;
        this.friendId = friendId;
        this.status = status;
        this.requestedAt = requestedAt;
        this.acceptedAt = acceptedAt;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getFriendId() {
        return friendId;
    }
    public void setFriendId(int friendId) {
        this.friendId = friendId;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getRequestedAt() {
        return requestedAt;
    }
    public void setRequestedAt(LocalDateTime requestedAt) {
        this.requestedAt = requestedAt;
    }

    public LocalDateTime getAcceptedAt() {
        return acceptedAt;
    }
    public void setAcceptedAt(LocalDateTime acceptedAt) {
        this.acceptedAt = acceptedAt;
    }
}
