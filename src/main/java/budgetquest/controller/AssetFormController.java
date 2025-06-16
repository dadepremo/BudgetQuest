package budgetquest.controller;

import budgetquest.dao.*;
import javafx.animation.FadeTransition;
import javafx.animation.ParallelTransition;
import javafx.animation.RotateTransition;
import javafx.animation.TranslateTransition;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.util.Duration;
import budgetquest.model.Asset;
import budgetquest.model.User;
import budgetquest.utils.MyUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Random;

public class AssetFormController {

    private static final Logger logger = LogManager.getLogger(AssetFormController.class);

    @FXML private TextField nameField;
    @FXML private TextField typeField;
    @FXML private TextField valueField;
    @FXML private DatePicker acquiredDatePicker;
    @FXML private TextArea notesArea;
    @FXML private CheckBox isLiquidCheckBox;
    @FXML private Label statusLabel;
    @FXML private VBox rootBox;

    private final XpGiverDao xpGiverDao = new XpGiverDaoImpl();
    private final int normalAssetBonus = xpGiverDao.getValueByName("normalAssetBonus");

    private final ShopItemDao shopItemDao = new ShopItemDaoImpl();
    private final AssetDao assetDao = new AssetDaoImpl();
    private final UserDao userDao = new UserDaoImpl();

    private User loggedUser;

    public void setUser(User user) {
        this.loggedUser = user;
        if (user.getTheme().equals("light")) {
            switchToLightTheme();
        } else if (user.getTheme().equals("dark")){
            switchToDarkTheme();
        }
    }

    public void switchToDarkTheme() {
        rootBox.getStylesheets().clear();
        rootBox.getStylesheets().add(getClass().getResource("/style/asset_form_dark.css").toExternalForm());
    }

    public void switchToLightTheme() {
        rootBox.getStylesheets().clear();
        rootBox.getStylesheets().add(getClass().getResource("/style/asset_form_light.css").toExternalForm());
    }

    @FXML
    public void handleSaveAsset() {

        //TODO: fare check convalida dati perché ora come ora posso mettere anche delle stringhe nel value e va in errore il tutto
        String name = nameField.getText().trim();
        String type = typeField.getText().trim();
        String amountStr = valueField.getText().trim();

        if (loggedUser == null) {
            statusLabel.setText("No user logged in.");
            logger.warn("No user logged in");
            return;
        }

        if (name.isEmpty()) {
            statusLabel.setText("Please insert the name.");
            logger.warn("No asset name inserted");
            return;
        }

        if (type.isEmpty()) {
            statusLabel.setText("Please insert the type.");
            logger.warn("No asset type inserted");
            return;
        }

        if (amountStr.isEmpty()) {
            statusLabel.setText("Please enter the value");
            logger.warn("No asset value inserted");
            return;
        }

        double amount;
        try {
            amount = Double.parseDouble(amountStr);
            if (amount <= 0) {
                statusLabel.setTextFill(Color.RED);
                statusLabel.setText("Amount must be greater than zero.");
                return;
            }
        } catch (NumberFormatException e) {
            statusLabel.setTextFill(Color.RED);
            statusLabel.setText("Invalid amount format.");
            return;
        }

        try {
            Asset asset = new Asset();
            asset.setUserId(loggedUser.getId());
            asset.setName(nameField.getText());
            asset.setType(typeField.getText());
            asset.setValue(new BigDecimal(valueField.getText()));
            asset.setAcquiredDate(acquiredDatePicker.getValue());
            asset.setNotes(notesArea.getText());
            asset.setLiquid(isLiquidCheckBox.isSelected());

            boolean saved = assetDao.insertAsset(asset);
            if(saved) {
                logger.info("Asset saved successfully");
                statusLabel.setText("Asset saved successfully!");
                userDao.updateUserLevel(loggedUser, normalAssetBonus);
                if (asset.getValue().compareTo(BigDecimal.valueOf(100000)) >= 0 && asset.getValue().compareTo(BigDecimal.valueOf(500000)) < 0) {
                    userDao.updateUserPoints(loggedUser, 500);
                    MyUtils.showInfo("Points added!", "That was a pretty big acquisition!\n\nProud of you...\nWe added 200 DP to your balance!");
                } else if (asset.getValue().compareTo(BigDecimal.valueOf(500000)) >= 0 && asset.getValue().compareTo(BigDecimal.valueOf(1000000)) < 0) {
                    userDao.updateUserPoints(loggedUser, 1000);
                    MyUtils.showInfo("Points added!", "That was a big acquisition!\n\nProud of you...\nWe added 500 DP to your balance!");
                } else if (asset.getValue().compareTo(BigDecimal.valueOf(1000000)) >= 0 && asset.getValue().compareTo(BigDecimal.valueOf(10000000)) < 0) {
                    userDao.updateUserPoints(loggedUser, 1750);
                    MyUtils.showInfo("Points added!", "You're becoming a shark!\n\nProud of you...\nWe added 750 DP to your balance!");
                } else if (asset.getValue().compareTo(BigDecimal.valueOf(10000000)) >= 0) {
                    userDao.updateUserPoints(loggedUser, 5000);
                    MyUtils.showInfo("Points added!", "Your portfolio is becoming impressive!\n\nProud of you...\nWe added 1000 DP to your balance!");
                } else {
                    userDao.updateUserPoints(loggedUser, 50);
                    MyUtils.showInfo("Points added!", "Even the smaller assets matter!\n\nProud of you...\nWe added 10 DP to your balance!");
                }
                if (shopItemDao.getItemByNameForUser("Celebrate your new assets!", loggedUser.getId()) != null)
                    launchConfettiAnimation();
            } else {
                logger.info("Error saving asset");
                statusLabel.setText("Error saving asset.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            statusLabel.setText("Invalid input or system error.");
            logger.error("Invalid input or system error", (IOException) e);
        }
    }

    private final Random random = new Random();

    private void launchConfettiAnimation() {
        int count = 50;

        for (int i = 0; i < count; i++) {
            Rectangle confetti = new Rectangle(5, 10);
            confetti.setFill(Color.hsb(random.nextDouble() * 360, 1.0, 1.0));
            confetti.setArcWidth(2);
            confetti.setArcHeight(2);

            // Add to rootBox *before* calculating width
            rootBox.getChildren().add(confetti);

            // Wider horizontal spread: -400 to +400
            double dx = (random.nextDouble() - 0.5) * 800;

            // Higher vertical fall: 400 to 800
            double dy = 400 + random.nextDouble() * 400;

            TranslateTransition fall = new TranslateTransition(Duration.seconds(2 + random.nextDouble()), confetti);
            fall.setByX(dx);
            fall.setByY(dy);
            fall.setDelay(Duration.millis(random.nextInt(300)));

            RotateTransition rotate = new RotateTransition(Duration.seconds(2 + random.nextDouble()), confetti);
            rotate.setByAngle(360 + random.nextInt(360));

            FadeTransition fade = new FadeTransition(Duration.seconds(2.5), confetti);
            fade.setFromValue(1.0);
            fade.setToValue(0.0);
            fade.setDelay(Duration.millis(500));

            ParallelTransition anim = new ParallelTransition(confetti, fall, rotate, fade);
            anim.setOnFinished(e -> rootBox.getChildren().remove(confetti));
            anim.play();
        }
    }



}
