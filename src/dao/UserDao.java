package dao;

import model.User;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface UserDao {

    Optional<User> getUserById(int id);

    Optional<User> getUserByUsername(String username);

    List<User> getAllUsers();

    boolean createUser(User user);

    boolean updateUser(User user);

    boolean deleteUser(int id);

    void updateLastLoginForStreak(User user);

    void updateLastLogin(User user);

    LocalDate getLastStreakDate(User user);

    int getUserXp(User user);

    int getUserPoints(User user);

    void updateUserPoints(User user, int points);

    int getUserLevel(User user);

    void grantAchievement(User user, String code);

    void updateUserLevel(User user, int xp);

    void deleteUserData(User user);

    void updateLoginStreak(User user);

    void updateUserTheme(User user);
}
