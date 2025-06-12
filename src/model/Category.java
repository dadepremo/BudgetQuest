package model;

public class Category {
    private int id;
    private int userId;
    private String name;
    private String type; // "income" or "expense"
    private boolean isDeleted;

    public Category(int id, int userId, String name, String type, boolean isDeleted) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.type = type;
        this.isDeleted = isDeleted;
    }

    public Category() {
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }

    public boolean isDeleted() {
        return isDeleted;
    }
}

