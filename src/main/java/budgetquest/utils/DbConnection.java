package budgetquest.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {

    private static String jdbcUrl = "jdbc:postgresql://localhost:5432/budgetquest"; // default to DEV
    private static final String USER = "postgres";
    private static final String PASS = "root";

    public static void setEnvironment(String env) {
        switch (env.toLowerCase()) {
            case "prod" -> jdbcUrl = "jdbc:postgresql://localhost:5432/budgetquest_PROD";
            case "dev" -> jdbcUrl = "jdbc:postgresql://localhost:5432/budgetquest";
            default -> throw new IllegalArgumentException("Unknown environment: " + env);
        }
    }

    public static Connection connect() throws SQLException {
        return DriverManager.getConnection(jdbcUrl, USER, PASS);
    }
}
