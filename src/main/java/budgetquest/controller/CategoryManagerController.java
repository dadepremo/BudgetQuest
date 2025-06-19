package budgetquest.controller;

import budgetquest.dao.CategoryDao.CategoryDao;
import budgetquest.dao.CategoryDao.CategoryDaoImpl;
import budgetquest.model.Category;
import budgetquest.model.User;
import javafx.beans.property.ReadOnlyStringWrapper;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.SortedList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.TextFieldTableCell;

import java.util.List;

public class CategoryManagerController {

    @FXML private TableView<Category> categoryTable;
    @FXML private TableColumn<Category, Integer> idColumn;
    @FXML private TableColumn<Category, String> nameColumn;
    @FXML private TableColumn<Category, String> typeColumn;
    @FXML private TableView<Category> incomeCategoryTable;
    @FXML private TableView<Category> expenseCategoryTable;
    @FXML private TableColumn<Category, String> incomeNameColumn;
    @FXML private TableColumn<Category, String> expenseNameColumn;


    private final CategoryDao categoryDao = new CategoryDaoImpl();
    private User user;

    private ObservableList<Category> categories;

    public void setUser(User user) {
        this.user = user;
        loadCategories();
    }

    private void loadCategories() {
        List<Category> categoryList = categoryDao.findAllByUser(user);

        ObservableList<Category> incomeCategories = FXCollections.observableArrayList();
        ObservableList<Category> expenseCategories = FXCollections.observableArrayList();

        for (Category c : categoryList) {
            if ("income".equalsIgnoreCase(c.getType())) {
                incomeCategories.add(c);
            } else if ("expense".equalsIgnoreCase(c.getType())) {
                expenseCategories.add(c);
            }
        }

        incomeCategoryTable.setItems(incomeCategories);
        expenseCategoryTable.setItems(expenseCategories);

        incomeNameColumn.setCellValueFactory(data -> new ReadOnlyStringWrapper(data.getValue().getName()));
        incomeNameColumn.setCellFactory(TextFieldTableCell.forTableColumn());
        incomeNameColumn.setOnEditCommit(e -> e.getRowValue().setName(e.getNewValue()));

        expenseNameColumn.setCellValueFactory(data -> new ReadOnlyStringWrapper(data.getValue().getName()));
        expenseNameColumn.setCellFactory(TextFieldTableCell.forTableColumn());
        expenseNameColumn.setOnEditCommit(e -> e.getRowValue().setName(e.getNewValue()));

        incomeCategoryTable.setEditable(true);
        expenseCategoryTable.setEditable(true);
    }



    @FXML
    private void handleSaveChanges() {
        for (Category c : incomeCategoryTable.getItems()) {
            categoryDao.update(c, user.getId());
        }
        for (Category c : expenseCategoryTable.getItems()) {
            categoryDao.update(c, user.getId());
        }

        Alert alert = new Alert(Alert.AlertType.INFORMATION, "Changes saved successfully.");
        alert.showAndWait();
    }

}
