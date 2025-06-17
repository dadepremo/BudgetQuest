package budgetquest.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Liability {
    private int id;
    private int userId;
    private String name;
    private String type;
    private BigDecimal amount;
    private BigDecimal amountRemaining;
    private BigDecimal interestRate;
    private LocalDate startDate;
    private LocalDate dueDate;
    private String notes;
    private boolean isActive;
    private LocalDateTime createdAt;
    private LocalDateTime lastUpdated;
    private boolean isDeleted;

    private String paymentFrequency;
    private LocalDate nextPaymentDue;
    private BigDecimal minimumPayment;
    private String liabilityStatus;
    private String category;
    private BigDecimal totalPaid;
    private LocalDate lastPaymentDate;
    private String creditorName;
    private String creditorContact;
    private boolean reminderEnabled;
    private Integer reminderDaysBefore;
    private BigDecimal monthlyPayment;


    public Liability() {}

    public Liability(int userId, String name, String type, BigDecimal amount, BigDecimal amountRemaining, BigDecimal interestRate, LocalDate startDate, LocalDate dueDate, String notes, boolean isActive, LocalDateTime createdAt, LocalDateTime lastUpdated, boolean isDeleted, String paymentFrequency, LocalDate nextPaymentDue, BigDecimal minimumPayment, String liabilityStatus, String category, BigDecimal totalPaid, LocalDate lastPaymentDate, String creditorName, String creditorContact, boolean reminderEnabled, Integer reminderDaysBefore, BigDecimal monthlyPayment) {
        this.userId = userId;
        this.name = name;
        this.type = type;
        this.amount = amount;
        this.amountRemaining = amountRemaining;
        this.interestRate = interestRate;
        this.startDate = startDate;
        this.dueDate = dueDate;
        this.notes = notes;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.lastUpdated = lastUpdated;
        this.isDeleted = isDeleted;
        this.paymentFrequency = paymentFrequency;
        this.nextPaymentDue = nextPaymentDue;
        this.minimumPayment = minimumPayment;
        this.liabilityStatus = liabilityStatus;
        this.category = category;
        this.totalPaid = totalPaid;
        this.lastPaymentDate = lastPaymentDate;
        this.creditorName = creditorName;
        this.creditorContact = creditorContact;
        this.reminderEnabled = reminderEnabled;
        this.reminderDaysBefore = reminderDaysBefore;
        this.monthlyPayment = monthlyPayment;
    }

    public BigDecimal getMonthlyPayment() {
        return monthlyPayment;
    }

    public void setMonthlyPayment(BigDecimal monthlyPayment) {
        this.monthlyPayment = monthlyPayment;
    }

    public String getPaymentFrequency() {
        return paymentFrequency;
    }

    public void setPaymentFrequency(String paymentFrequency) {
        this.paymentFrequency = paymentFrequency;
    }

    public LocalDate getNextPaymentDue() {
        return nextPaymentDue;
    }

    public void setNextPaymentDue(LocalDate nextPaymentDue) {
        this.nextPaymentDue = nextPaymentDue;
    }

    public BigDecimal getMinimumPayment() {
        return minimumPayment;
    }

    public void setMinimumPayment(BigDecimal minimumPayment) {
        this.minimumPayment = minimumPayment;
    }

    public String getLiabilityStatus() {
        return liabilityStatus;
    }

    public void setLiabilityStatus(String liabilityStatus) {
        this.liabilityStatus = liabilityStatus;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getTotalPaid() {
        return totalPaid;
    }

    public void setTotalPaid(BigDecimal totalPaid) {
        this.totalPaid = totalPaid;
    }

    public LocalDate getLastPaymentDate() {
        return lastPaymentDate;
    }

    public void setLastPaymentDate(LocalDate lastPaymentDate) {
        this.lastPaymentDate = lastPaymentDate;
    }

    public String getCreditorName() {
        return creditorName;
    }

    public void setCreditorName(String creditorName) {
        this.creditorName = creditorName;
    }

    public String getCreditorContact() {
        return creditorContact;
    }

    public void setCreditorContact(String creditorContact) {
        this.creditorContact = creditorContact;
    }

    public boolean isReminderEnabled() {
        return reminderEnabled;
    }

    public void setReminderEnabled(boolean reminderEnabled) {
        this.reminderEnabled = reminderEnabled;
    }

    public Integer getReminderDaysBefore() {
        return reminderDaysBefore;
    }

    public void setReminderDaysBefore(Integer reminderDaysBefore) {
        this.reminderDaysBefore = reminderDaysBefore;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getAmountRemaining() {
        return amountRemaining;
    }

    public void setAmountRemaining(BigDecimal amountRemaining) {
        this.amountRemaining = amountRemaining;
    }

    public BigDecimal getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(BigDecimal interestRate) {
        this.interestRate = interestRate;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(LocalDateTime lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Override
    public String toString() {
        return "Liability{" +
                "id=" + id +
                ", userId=" + userId +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", amount=" + amount +
                ", amountRemaining=" + amountRemaining +
                ", interestRate=" + interestRate +
                ", startDate=" + startDate +
                ", dueDate=" + dueDate +
                ", notes='" + notes + '\'' +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                ", lastUpdated=" + lastUpdated +
                ", isDeleted=" + isDeleted +
                '}';
    }
}
