package budgetquest.service;

import budgetquest.model.Category;
import budgetquest.model.Transaction;

import java.util.List;
import java.util.Map;

public class ImportResult {
    private List<Transaction> transactions;
    private Map<Category, String> categoryTypeMap;

    public List<Transaction> getTransactions() { return transactions; }
    public Map<Category, String> getCategoryTypeMap() { return categoryTypeMap; }
}
