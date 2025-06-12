package utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtils {

    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    /**
     * Method to do the password check. <br>
     * It compares the plain password with the hashed password.
     *
     * @param hashedPassword for the hashed password
     * @param plainPassword for the plain password
     *
     * @return boolean value, true if they're the same false if they're not
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
