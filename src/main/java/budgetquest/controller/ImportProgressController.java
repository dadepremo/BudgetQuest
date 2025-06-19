package budgetquest.controller;

import javafx.concurrent.Task;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressIndicator;

public class ImportProgressController {

    @FXML
    private ProgressIndicator progressIndicator;
    @FXML private Label progressLabel;
    @FXML private Label countLabel;

    public void bindProgress(Task<Void> task, int total) {
        progressIndicator.progressProperty().bind(task.progressProperty());

        task.messageProperty().addListener((obs, old, msg) -> progressLabel.setText(msg));
        task.progressProperty().addListener((obs, old, progress) -> {
            int current = (int) (progress.doubleValue() * total);
            countLabel.setText(current + " / " + total);
        });
    }
}
