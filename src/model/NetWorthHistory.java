package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class NetWorthHistory {
    private int id;
    private int userId;
    private LocalDate date;
    private BigDecimal assetsValue;
    private BigDecimal liabilitiesValue;
    private BigDecimal netWorth;
    private LocalDateTime createdAt;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public BigDecimal getAssetsValue() { return assetsValue; }
    public void setAssetsValue(BigDecimal assetsValue) { this.assetsValue = assetsValue; }

    public BigDecimal getLiabilitiesValue() { return liabilitiesValue; }
    public void setLiabilitiesValue(BigDecimal liabilitiesValue) { this.liabilitiesValue = liabilitiesValue; }

    public BigDecimal getNetWorth() { return netWorth; }
    public void setNetWorth(BigDecimal netWorth) { this.netWorth = netWorth; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
