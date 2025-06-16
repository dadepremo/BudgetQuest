package budgetquest.model;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Represents a financial transaction made by a user.
 * A transaction may optionally be associated with a category.
 */
public class Transaction {
    /** Unique identifier for the transaction. */
    private int id;

    /** Identifier of the user to whom this transaction belongs. */
    private int userId;

    /** Identifier of the category this transaction belongs to. May be {@code null}. */
    private Integer categoryId;

    /** Date of the transaction. */
    private LocalDate date;

    /** Monetary amount of the transaction. */
    private BigDecimal amount;

    /** Optional description for the transaction. */
    private String description;

    /** Optional name for the transaction (e.g. for display). */
    private String name;

    /** The name of the associated category, for display purposes. */
    private String categoryName;

    /**
     * Constructs a {@code Transaction} with all fields except {@code categoryName}.
     *
     * @param id           the unique ID of the transaction
     * @param userId       the ID of the user who owns the transaction
     * @param categoryId   the ID of the category, or {@code null}
     * @param date         the date of the transaction
     * @param amount       the monetary amount
     * @param description  the transaction's description
     * @param name         the name of the transaction
     */
    public Transaction(int id, int userId, Integer categoryId, LocalDate date, BigDecimal amount, String description, String name) {
        this.id = id;
        this.userId = userId;
        this.categoryId = categoryId;
        this.date = date;
        this.amount = amount;
        this.description = description;
        this.name = name;
    }

    /** Constructs an empty {@code Transaction}. */
    public Transaction() {}

    /**
     * Returns the category name.
     *
     * @return the name of the category
     */
    public String getCategoryName() {
        return categoryName;
    }

    /**
     * Sets the category name.
     *
     * @param categoryName the name of the category
     */
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    /**
     * Returns the transaction ID.
     *
     * @return the transaction ID
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the transaction ID.
     *
     * @param id the transaction ID
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Returns the user ID associated with this transaction.
     *
     * @return the user ID
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user ID for this transaction.
     *
     * @param userId the user ID
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Returns the category ID.
     *
     * @return the category ID, or {@code null} if not set
     */
    public Integer getCategoryId() {
        return categoryId;
    }

    /**
     * Sets the category ID.
     *
     * @param categoryId the category ID, or {@code null}
     */
    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    /**
     * Returns the transaction date.
     *
     * @return the date of the transaction
     */
    public LocalDate getDate() {
        return date;
    }

    /**
     * Sets the transaction date.
     *
     * @param date the date of the transaction
     */
    public void setDate(LocalDate date) {
        this.date = date;
    }

    /**
     * Returns the transaction amount.
     *
     * @return the amount
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * Sets the transaction amount.
     *
     * @param amount the amount
     */
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    /**
     * Returns the description of the transaction.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the description of the transaction.
     *
     * @param description the description
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Returns the name of the transaction.
     *
     * @return the transaction name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name of the transaction.
     *
     * @param name the name
     */
    public void setName(String name) {
        this.name = name;
    }
}
