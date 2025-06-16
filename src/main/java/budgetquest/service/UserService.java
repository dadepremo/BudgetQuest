package budgetquest.service;

import budgetquest.dao.UserDao;
import budgetquest.model.User;

import java.time.LocalDateTime;

public class UserService {
    private final UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public boolean registerUser(String username, String firstName, String lastName, String email, String rawPassword) {
        if (userDao.getUserByUsername(username).isPresent()) {
            System.out.println("Username already exists.");
            return false;
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setFirstName(firstName);
        newUser.setLastName(lastName);
        newUser.setEmail(email);
        newUser.setPasswordHash(rawPassword);
        newUser.setCreatedAt(LocalDateTime.now());
        newUser.setXp(0);
        newUser.setLevel(1);
        newUser.setPoints(0);
        newUser.setDeleted(false);

        return userDao.createUser(newUser);
    }
}
