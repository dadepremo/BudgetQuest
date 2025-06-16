package budgetquest.model;

import java.sql.Timestamp;

public class Achievement {
    private int id;
    private String code;
    private String name;
    private String description;
    private int pointsReward;
    private int xpReward;
    private String icon;
    private Timestamp createdAt;

    public Achievement() {}

    public Achievement(int id, String code, String name, String description, int pointsReward, int xpReward, String icon, Timestamp createdAt) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.description = description;
        this.pointsReward = pointsReward;
        this.xpReward = xpReward;
        this.icon = icon;
        this.createdAt = createdAt;
    }

    public Achievement(int id) {
        this.id = id;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getPointsReward() { return pointsReward; }
    public void setPointsReward(int pointsReward) { this.pointsReward = pointsReward; }

    public int getXpReward() { return xpReward; }
    public void setXpReward(int xpReward) { this.xpReward = xpReward; }

    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}

