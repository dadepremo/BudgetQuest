package budgetquest.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;

public class Asset {
    private int id;
    private int userId;
    private String name;
    private String type;
    private BigDecimal value;
    private LocalDate acquiredDate;
    private String notes;
    private Timestamp createdAt;
    private Timestamp lastUpdated;
    private boolean isDeleted;
    private boolean liquid;

    public Asset() {
    }

    public Asset(int id, int userId, String name, String type, BigDecimal value, LocalDate acquiredDate, String notes, Timestamp createdAt, Timestamp lastUpdated, boolean isDeleted, boolean liquid) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.type = type;
        this.value = value;
        this.acquiredDate = acquiredDate;
        this.notes = notes;
        this.createdAt = createdAt;
        this.lastUpdated = lastUpdated;
        this.isDeleted = isDeleted;
        this.liquid = liquid;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public void setIs_deleted(boolean is_deleted) {
        this.isDeleted = is_deleted;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public boolean isDeleted() {
        return isDeleted;
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

    public void setValue(BigDecimal value) {
        this.value = value;
    }

    public void setAcquiredDate(LocalDate acquiredDate) {
        this.acquiredDate = acquiredDate;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public void setLiquid(boolean liquid) {
        this.liquid = liquid;
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

    public BigDecimal getValue() {
        return value;
    }

    public LocalDate getAcquiredDate() {
        return acquiredDate;
    }

    public String getNotes() {
        return notes;
    }

    public boolean isLiquid() {
        return liquid;
    }
}
