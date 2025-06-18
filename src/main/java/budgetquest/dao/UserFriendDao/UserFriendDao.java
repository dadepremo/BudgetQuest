package budgetquest.dao.UserFriendDao;

import budgetquest.model.UserFriend;

import java.util.List;
import java.util.Optional;

public interface UserFriendDao {
    void sendFriendRequest(int userId, int friendId);

    void acceptFriendRequest(int userId, int friendId);

    void blockFriend(int userId, int friendId);

    void removeFriend(int userId, int friendId);

    List<UserFriend> getFriends(int userId);

    List<UserFriend> getPendingRequests(int userId);

    boolean areFriends(int userId, int friendId);

    Optional<UserFriend> getFriendship(int userId, int friendId);
}
