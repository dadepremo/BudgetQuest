package model;

import java.time.LocalDate;

public class LoginEntry {
    private LocalDate loginDate;

    public LoginEntry(LocalDate loginDate) {
        this.loginDate = loginDate;
    }

    public LocalDate getLoginDate() {
        return loginDate;
    }
}

