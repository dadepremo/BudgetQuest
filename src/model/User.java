package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class User {
    private int id;
    private String username;
    private String firstName;
    private String lastName;
    private String email;
    private String passwordHash;
    private LocalDateTime createdAt;
    private boolean isDeleted;
    private int xp;
    private int level;
    private int points;
    private LocalDateTime lastLogin;
    private String currency;
    private String currencySymbol;
    private LocalDate lastStreakDate;
    private int currentStreak;
    private String theme;

    public User() {}

    public User(int id, String username, String firstName, String lastName, String email, String passwordHash,
                LocalDateTime createdAt, boolean isDeleted, int xp, int level, int points, LocalDateTime lastLogin, String currency, String currencySymbol, LocalDate lastStreakDate, int currentStreak, String theme) {
        this.id = id;
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.createdAt = createdAt;
        this.isDeleted = isDeleted;
        this.xp = xp;
        this.level = level;
        this.points = points;
        this.lastLogin = lastLogin;
        this.currency = currency;
        this.currencySymbol = currencySymbol;
        this.lastStreakDate = lastStreakDate;
        this.currentStreak = currentStreak;
        this.theme = theme;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public LocalDate getLastStreakDate() {
        return lastStreakDate;
    }

    public void setLastStreakDate(LocalDate lastStreakDate) {
        this.lastStreakDate = lastStreakDate;
    }

    public int getCurrentStreak() {
        return currentStreak;
    }

    public void setCurrentStreak(int currentStreak) {
        this.currentStreak = currentStreak;
    }

    public String getCurrencySymbol() {
        return currencySymbol;
    }

    public void setCurrencySymbol(String currencySymbol) {
        this.currencySymbol = currencySymbol;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public void setXp(int xp) {
        this.xp = xp;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public int getXp() {
        return xp;
    }

    public int getLevel() {
        return level;
    }

    public int getPoints() {
        return points;
    }

    public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    @Override
    public String toString() {
        return getUsername() + (getEmail() != null ? " (" + getEmail() + ")" : "");
    }

}
