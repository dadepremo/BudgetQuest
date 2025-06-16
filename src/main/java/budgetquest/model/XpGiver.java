package budgetquest.model;

public class XpGiver {
    private int id;
    private String name;
    private String description;
    private int value;
    private boolean isDeleted;

    public XpGiver() {}

    public XpGiver(int id, String name, String description, int value, boolean isDeleted) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.value = value;
        this.isDeleted = isDeleted;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }
}
