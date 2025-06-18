package budgetquest.controller;

import budgetquest.dao.CategoryDao;
import budgetquest.dao.CategoryDaoImpl;
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

    private final CategoryDao categoryDao = new CategoryDaoImpl();
    private User user;

    private ObservableList<Category> categories;

    public void setUser(User user) {
        this.user = user;
        loadCategories();
    }


    private void loadCategories() {
        List<Category> categoryList = categoryDao.findAllByUser(user);
        categories = FXCollections.observableArrayList(categoryList);

        // Sort categories by type
        SortedList<Category> sortedCategories = new SortedList<>(categories,
                (c1, c2) -> c1.getType().compareToIgnoreCase(c2.getType()));

        categoryTable.setItems(sortedCategories);

        // Set up columns as before, with ReadOnlyStringWrapper if needed
        nameColumn.setCellValueFactory(data -> new ReadOnlyStringWrapper(data.getValue().getName()));
        nameColumn.setCellFactory(TextFieldTableCell.forTableColumn());
        nameColumn.setOnEditCommit(e -> e.getRowValue().setName(e.getNewValue()));

        typeColumn.setCellValueFactory(data -> new ReadOnlyStringWrapper(data.getValue().getType()));
        typeColumn.setCellFactory(TextFieldTableCell.forTableColumn());
        typeColumn.setOnEditCommit(e -> e.getRowValue().setType(e.getNewValue()));

        categoryTable.setEditable(true);
    }


    @FXML
    private void handleSaveChanges() {
        for (Category c : categories) {
            categoryDao.update(c, user.getId());
        }
        Alert alert = new Alert(Alert.AlertType.INFORMATION, "Changes saved successfully.");
        alert.showAndWait();
    }
}
