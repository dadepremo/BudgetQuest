package service;

import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.effect.DropShadow;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

import java.util.List;
import java.util.Random;

public class MotivationalQuotePopup {

    private static final List<String> QUOTES = List.of(
            "Every penny saved is a penny earned.",
            "Small steps every day lead to big results.",
            "Your financial freedom is worth the effort.",
            "Budget today, enjoy tomorrow.",
            "Invest in yourself — it pays the best interest.",
            "Keep your eyes on the prize: financial independence.",
            "Save money, live better.",
            "A budget is telling your money where to go instead of wondering where it went.",
            "The best time to save was yesterday; the next best is today.",
            "Money grows when you plant seeds of saving.",
            "Discipline is choosing between what you want now and what you want most.",
            "Wealth is the ability to fully experience life.",
            "Make your money work as hard as you do.",
            "Don’t watch the clock; do what it does — keep going.",
            "Financial fitness is not a pipe dream or a state of mind; it’s a reality if you are willing to pursue it and embrace it.",
            "Your future is created by what you do today, not tomorrow.",
            "Money saved is money earned twice.",
            "A goal without a plan is just a wish.",
            "Frugality includes all the other virtues.",
            "The more you learn, the more you earn.",
            "Start where you are. Use what you have. Do what you can.",
            "A good financial plan is a road map that shows us exactly how the choices we make today will affect our future.",
            "Don’t let money run your life, let money help you run your life better.",
            "If you live for having it all, what you have is never enough.",
            "Financial freedom is available to those who learn about it and work for it.",
            "Time is more valuable than money. You can get more money, but you cannot get more time.",
            "Spend less than you earn and invest the rest.",
            "It’s not your salary that makes you rich, it’s your spending habits.",
            "Wealth consists not in having great possessions, but in having few wants.",
            "Save a little money each month and at the end of the year you’ll be surprised at how little you have.",
            "Be stubborn about your goals but flexible about your methods.",
            "Debt is the slavery of the free.",
            "Money is a terrible master but an excellent servant.",
            "The habit of saving is itself an education.",
            "Do not save what is left after spending, but spend what is left after saving.",
            "Beware of little expenses; a small leak will sink a great ship.",
            "Success is the sum of small efforts, repeated day in and day out.",
            "Make every dollar count.",
            "Financial peace isn’t the acquisition of stuff. It’s learning to live on less than you make.",
            "Planning is bringing the future into the present so that you can do something about it now.",
            "You must gain control over your money or the lack of it will forever control you.",
            "Good things come to those who budget.",
            "Invest in your dreams. Grind now. Shine later.",
            "Money without brains is always dangerous.",
            "Don’t let the fear of losing be greater than the excitement of winning.",
            "Financial discipline is the bridge between goals and accomplishment.",
            "The cost of a thing is the amount of what I will call life which is required to be exchanged for it.",
            "Budgeting isn’t about limiting yourself — it’s about making the things that excite you possible.",
            "Financial literacy is the best legacy you can leave your children.",
            "The art is not in making money, but in keeping it.",
            "If you would be wealthy, think of saving as well as getting.",
            "You don’t have to be rich to start investing, but you have to start to get rich.",
            "Money is like manure. You have to spread it around or it smells.",
            "Create a vision that makes you want to jump out of bed in the morning.",
            "Turn your financial dreams into your financial plans.",
            "Wealth is the ability to fully experience life.",
            "Money is only a tool. It will take you wherever you wish, but it will not replace you as the driver.",
            "The goal isn’t more money. The goal is living life on your terms.",
            "Saving money is the foundation of financial success.",
            "Don’t go broke trying to look rich.",
            "Building wealth is a marathon, not a sprint.",
            "Financial success is a journey, not a destination.",
            "Money saved is money earned.",
            "The key to wealth is learning how to make money while you sleep.",
            "Don’t save what is left after spending, spend what is left after saving.",
            "Smart spending leads to financial freedom.",
            "Start saving today for the life you want tomorrow.",
            "The more you save, the more you have.",
            "Money is the tool, not the goal.",
            "Cut expenses, not dreams.",
            "Financial health means less stress and more freedom.",
            "Wealth is a mindset, not just a number.",
            "Spend intentionally and save relentlessly.",
            "Make money work for you, not the other way around.",
            "Richness is not about what you have, but what you give.",
            "Don’t put off saving for tomorrow what you can start today.",
            "Every dollar has a job. Make sure it’s a good one.",
            "Money is best managed with patience and discipline.",
            "Save for a rainy day, but invest for a sunny one.",
            "The true wealth is having something money can’t buy.",
            "Avoid debt like the plague.",
            "A little progress each day adds up to big results.",
            "Happiness is not in the mere possession of money; it lies in the joy of achievement.",
            "Wealth is the ability to live your dreams.",
            "Make your money moves with purpose.",
            "Your budget is your best friend.",
            "Discipline today, freedom tomorrow.",
            "Plan your money or your money will plan you.",
            "Don’t just work for money — make money work for you.",
            "Keep it simple and stay consistent.",
            "Create wealth, create freedom.",
            "Your financial future depends on the choices you make today.",
            "Money talks, wealth whispers.",
            "Build habits that build wealth.",
            "Be fearless in the pursuit of what sets your soul on fire.",
            "Financial freedom is the best revenge.",
            "Success usually comes to those who are too busy to be looking for it.",
            "The richest people are those who invest in themselves.",
            "Work hard, save smart, live well.",
            "Make every dollar count toward your goals."
    );


    public static void showPopup(Stage owner) {
        Stage popupStage = new Stage(StageStyle.TRANSPARENT);
        popupStage.initModality(Modality.APPLICATION_MODAL);
        popupStage.initOwner(owner);

        Label quoteLabel = new Label(getRandomQuote());
        quoteLabel.setWrapText(true);
        quoteLabel.setStyle("-fx-font-size: 18px; -fx-text-fill: #2a9d8f; -fx-font-weight: bold;");
        quoteLabel.setAlignment(Pos.CENTER);

        Button closeButton = new Button("Got it!");
        closeButton.setStyle("-fx-background-color: linear-gradient(to bottom, #FFD700, #FF8C00); -fx-text-fill: white; -fx-font-weight: bold; -fx-cursor: hand;");
        closeButton.setOnAction(e -> popupStage.close());

        VBox layout = new VBox(20, quoteLabel, closeButton);
        layout.setAlignment(Pos.CENTER);
        layout.setStyle("-fx-background-color: white; -fx-padding: 20;");
        layout.setEffect(new DropShadow(10, Color.GRAY));

        Scene scene = new Scene(layout);
        scene.setFill(Color.TRANSPARENT);

        popupStage.setScene(scene);
        popupStage.showAndWait();
    }

    private static String getRandomQuote() {
        Random rand = new Random();
        return QUOTES.get(rand.nextInt(QUOTES.size()));
    }
}
