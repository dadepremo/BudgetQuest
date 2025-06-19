package budgetquest.service;

import budgetquest.dao.UserDao.UserDao;
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

//        username varchar(50) NOT NULL,
//        first_name varchar(50) NOT NULL,
//        last_name varchar(50) NOT NULL,
//        email varchar(100) NOT NULL,
//        password_hash text NOT NULL,
//        created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
//                is_deleted bool DEFAULT false NULL,
//                xp int4 DEFAULT 0 NULL,
//                "level" int4 DEFAULT 1 NULL,
//                points int4 DEFAULT 0 NOT NULL,
//        last_login timestamp NULL,
//                preferred_currency varchar(10) DEFAULT 'EUR'::character varying NULL,
//        currency_symbol varchar(5) DEFAULT '€'::character varying NULL,
//        last_streak_date date NULL,
//                current_streak int4 DEFAULT 0 NULL,
//                theme varchar(20) DEFAULT 'light'::character varying NULL,

        return userDao.createUser(newUser);
    }
}
