
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;
import utils.Logger;

public class Main extends Application {
    @Override
    public void start(Stage stage) throws Exception {
        Logger.info("Application started...");
        Logger.info("Loading login...");
        FXMLLoader loader = new FXMLLoader(getClass().getResource("views/login.fxml"));
        Scene scene = new Scene(loader.load());
        stage.setScene(scene);
        stage.setTitle("BudgetQuest");
        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
