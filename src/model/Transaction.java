package model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Transaction {
    private int id;
    private int userId;
    private Integer categoryId; // nullable
    private LocalDate date;
    private BigDecimal amount;
    private String description;
    private String name;
    private String categoryName;

    public Transaction(int id, int userId, Integer categoryId, LocalDate date, BigDecimal amount, String description, String name) {
        this.id = id;
        this.userId = userId;
        this.categoryId = categoryId;
        this.date = date;
        this.amount = amount;
        this.description = description;
        this.name = name;
    }

    public Transaction() {
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
