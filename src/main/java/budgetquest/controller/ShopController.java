package budgetquest.controller;

import budgetquest.dao.ShopItemDao.ShopItemDao;
import budgetquest.dao.ShopItemDao.ShopItemDaoImpl;
import budgetquest.dao.UserDao.UserDao;
import budgetquest.dao.UserDao.UserDaoImpl;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import budgetquest.model.ShopItem;
import budgetquest.model.User;
import budgetquest.utils.MyUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.net.URL;
import java.util.*;
import java.util.stream.Collectors;

public class ShopController implements Initializable {

    private static final Logger logger = LogManager.getLogger(ShopController.class);

    @FXML private VBox categoryContainer;
    @FXML private ToggleButton toggleViewButton;
    @FXML private Label dpPointsLabel;


    private final ShopItemDao shopItemDAO = new ShopItemDaoImpl();
    private final UserDao userDao = new UserDaoImpl();

    private User currentUser;
    private boolean compactView = false;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        toggleViewButton.setOnAction(e -> toggleView());
    }

    public void setCurrentUser(User user) {
        this.currentUser = user;
        updatePointsDisplay();
        initializeShop();
    }

    private void initializeShop() {
        categoryContainer.getChildren().clear();

        List<ShopItem> items = loadShopItems();
        Map<String, List<ShopItem>> groupedItems = items.stream()
                .collect(Collectors.groupingBy(ShopItem::getCategory));

        for (Map.Entry<String, List<ShopItem>> entry : groupedItems.entrySet()) {
            String category = entry.getKey();
            List<ShopItem> categoryItems = entry.getValue();

            Label categoryLabel = new Label(category);
            categoryLabel.setStyle("-fx-font-size: 25px; -fx-font-weight: bold;");
            categoryLabel.setPadding(new Insets(30, 20, 0, 20));

            TilePane tilePane = new TilePane();
            tilePane.setHgap(20);
            tilePane.setVgap(20);
            tilePane.setPrefColumns(compactView ? 1 : 3);
            tilePane.setStyle("-fx-background-color: transparent;");
            tilePane.setPrefWidth(Double.MAX_VALUE);

            for (ShopItem item : categoryItems) {
                VBox card = createShopCard(item);
                if (compactView) {
                    card.setPrefWidth(470);
                }
                tilePane.getChildren().add(card);
            }

            VBox section = new VBox(10, categoryLabel, tilePane);
            categoryContainer.getChildren().add(section);
        }
    }

    private void updatePointsDisplay() {
        if (currentUser != null) {
            String formatted = MyUtils.formatDpPoints(currentUser.getPoints());
            dpPointsLabel.setText(formatted);
        }
    }


    private VBox createShopCard(ShopItem item) {
        VBox card = new VBox(10);
        card.setPadding(new Insets(10));
        card.setStyle(
                "-fx-background-color: white;" +
                        "-fx-border-color: #ddd;" +
                        "-fx-border-radius: 8;" +
                        "-fx-background-radius: 8;" +
                        "-fx-effect: dropshadow(gaussian, rgba(0,0,0,0.1), 4, 0.5, 0, 2);"
        );
        card.setAlignment(Pos.CENTER);
        card.setPrefWidth(150);

        Label name = new Label(item.getName());
        name.setStyle("-fx-font-weight: bold; -fx-font-size: 14px;");

        Label desc = new Label(item.getDescription());
        desc.setWrapText(true);
        desc.setStyle("-fx-font-size: 12px; -fx-text-fill: #666;");

        Label price = new Label(item.getPrice() + " DP points");
        price.setStyle("-fx-text-fill: #2a9d8f; -fx-font-size: 13px;");

        Button buyButton = new Button("Buy");
        buyButton.setPrefWidth(144.0);

        boolean ownsItem = shopItemDAO.userOwnsItem(currentUser.getId(), item.getId());

        if (ownsItem) {
            buyButton.setText("Already bought");
            buyButton.setDisable(true);
        } else if (currentUser.getPoints() < item.getPrice()) {
            buyButton.setDisable(true);
        } else {
            buyButton.setOnAction(e -> handlePurchase(item));
        }

        card.getChildren().addAll(name, desc, price, buyButton);
        return card;
    }



    private void toggleView() {
        compactView = !compactView;
        toggleViewButton.setText(compactView ? "Grid View" : "Compact View");
        initializeShop();  // Refresh layout
    }

    private List<ShopItem> loadShopItems() {
        return shopItemDAO.getAllItems();
    }


    private void handlePurchase(ShopItem item) {
        if (currentUser == null) return;

        int userPoints = currentUser.getPoints();
        int price = item.getPrice();

        if (userPoints < price) {
            logger.info("Not enough points for purchase");
            return;
        }

        // 1. Update user points in DB
        userDao.updateUserPoints(currentUser, -price);

        // 2. Record purchase in user_purchases
        boolean purchaseRecorded = shopItemDAO.recordPurchase(currentUser.getId(), item.getId());

        if (purchaseRecorded) {
            // 3. Update currentUser points locally
            currentUser.setPoints(userPoints - price);

            // 4. Refresh UI
            updatePointsDisplay();
            initializeShop();

            logger.info("Purchase successful: " + item.getName());
        } else {
            logger.info("Purchase failed to record.");
        }
    }

}
