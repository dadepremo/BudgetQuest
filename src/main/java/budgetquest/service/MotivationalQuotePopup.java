package budgetquest.service;

import javafx.animation.FadeTransition;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.effect.DropShadow;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.TextAlignment;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import javafx.util.Duration;

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
            "Financial fitness is not a pipe dream or a state of mind; it’s a reality if you are willing to pursue it.",
            "Your future is created by what you do today, not tomorrow.",
            "Money saved is money earned twice.",
            "A goal without a plan is just a wish.",
            "Frugality includes all the other virtues.",
            "The more you learn, the more you earn.",
            "Start where you are. Use what you have. Do what you can.",
            "A good financial plan is a road map that shows us how today’s choices affect our future.",
            "Don’t let money run your life, let money help you run your life better.",
            "If you live for having it all, what you have is never enough.",
            "Financial freedom is available to those who learn and work for it.",
            "Time is more valuable than money. You can get more money, but not more time.",
            "Spend less than you earn and invest the rest.",
            "It’s not your salary that makes you rich, it’s your spending habits.",
            "Wealth consists not in having great possessions, but in having few wants.",
            "Save a little money each month and be amazed what it adds up to.",
            "Be stubborn about your goals but flexible about your methods.",
            "Debt is the slavery of the free.",
            "Money is a terrible master but an excellent servant.",
            "The habit of saving is itself an education.",
            "Do not save what is left after spending, but spend what is left after saving.",
            "Beware of little expenses; a small leak will sink a great ship.",
            "Success is the sum of small efforts, repeated day in and day out.",
            "Make every dollar count.",
            "Financial peace isn’t the acquisition of stuff. It’s learning to live on less than you make.",
            "Planning is bringing the future into the present so you can act on it now.",
            "You must gain control over your money or the lack of it will control you forever.",
            "Good things come to those who budget.",
            "Invest in your dreams. Grind now. Shine later.",
            "Money without brains is always dangerous.",
            "Don’t let the fear of losing be greater than the excitement of winning.",
            "Financial discipline is the bridge between goals and accomplishment.",
            "Budgeting isn’t about limiting yourself — it’s about making the things that excite you possible.",
            "Financial literacy is the best legacy you can leave your children.",
            "The art is not in making money, but in keeping it.",
            "If you would be wealthy, think of saving as well as getting.",
            "You don’t have to be rich to start investing, but you have to start to get rich.",
            "Money is like manure. You have to spread it around or it smells.",
            "Create a vision that makes you want to jump out of bed in the morning.",
            "Turn your financial dreams into your financial plans.",
            "Money is only a tool. It will take you wherever you wish, but it won’t replace you as the driver.",
            "The goal isn’t more money. The goal is living life on your terms.",
            "Saving money is the foundation of financial success.",
            "Don’t go broke trying to look rich.",
            "Building wealth is a marathon, not a sprint.",
            "Financial success is a journey, not a destination.",
            "The key to wealth is learning how to make money while you sleep.",
            "Smart spending leads to financial freedom.",
            "Start saving today for the life you want tomorrow.",
            "Money is the tool, not the goal.",
            "Cut expenses, not dreams.",
            "Financial health means less stress and more freedom.",
            "Wealth is a mindset, not just a number.",
            "Spend intentionally and save relentlessly.",
            "Make money work for you, not the other way around.",
            "Richness is not about what you have, but what you give.",
            "Every dollar has a job. Make sure it’s a good one.",
            "Money is best managed with patience and discipline.",
            "Save for a rainy day, but invest for a sunny one.",
            "The true wealth is having something money can’t buy.",
            "Avoid debt like the plague.",
            "A little progress each day adds up to big results.",
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
            "Make every dollar count toward your goals.",
            "Earn more, spend less, invest wisely.",
            "Financial wisdom is better than financial luck.",
            "Live below your means and above your expectations.",
            "Pay yourself first.",
            "Abundance flows to those who manage it with care.",
            "Money is the reward for solving problems.",
            "A penny saved is a fortune earned slowly.",
            "Secure your today to enjoy your tomorrow.",
            "Dream big, spend small, save smart.",
            "Great wealth begins with great habits.",
            "Never underestimate the power of compound interest.",
            "Know where your money goes before it goes.",
            "True success includes financial stability.",
            "You don’t rise to the level of your income, you fall to the level of your budgeting.",
            "Live rich by thinking rich — not spending rich.",
            "Save now, celebrate later.",
            "Money is freedom in disguise.",
            "Let your money reflect your values.",
            "Budgeting gives you power, not restrictions.",
            "Chase purpose, not paychecks.",
            "Automate your savings, not your spending.",
            "Every small save today builds a fortress tomorrow.",
            "Sacrifice now for freedom later.",
            "Rich is having money. Wealth is having time.",
            "Make your money behave.",
            "Don’t confuse need with want.",
            "Be grateful for what you have, while you work for what you want.",
            "Time is your most valuable investment asset.",
            "Be consistent with your money habits.",
            "Your money should be growing even when you're not working.",
            "Track every dollar like it’s the last one.",
            "The most powerful force in the universe is compound interest.",
            "Don’t dig a financial hole you can’t climb out of.",
            "Control your money or it will control you.",
            "Start small. Stay consistent. Build forever.",
            "Don’t save what is left after spending. Spend what’s left after saving.",
            "You can’t pour from an empty bank account.",
            "Preparation beats panic in finances.",
            "Say no now to say yes later.",
            "Your future self will thank you.",
            "If you want different results, you have to do things differently.",
            "Let go of instant gratification for long-term peace.",
            "Master your money before it masters you.",
            "The discipline to save is the key to wealth.",
            "If you can budget, you can be wealthy.",
            "Live on purpose, not by default.",
            "Dollars make sense when used wisely.",
            "Money is a magnifier — it shows who you really are.",
            "Clarity is power — know your financial goals.",
            "Your habits determine your financial destiny.",
            "Your account reflects your values.",
            "Money gives you options. Saving gives you control.",
            "Buy less. Choose well. Make it last.",
            "Being broke is temporary. Being poor is a mindset.",
            "Money is a game — learn the rules.",
            "Success starts with a savings account.",
            "A budget is freedom in disguise.",
            "Focus on building assets, not acquiring liabilities.",
            "Your greatest investment is in yourself.",
            "Wealth begins with discipline.",
            "Overspending is the enemy of success.",
            "What gets measured gets managed.",
            "Don’t wish for wealth — work for it.",
            "Every decision is a vote for your future.",
            "Grow what you’ve got.",
            "There’s no such thing as too little to save.",
            "Spend with intention, not impulse.",
            "Create your own financial luck.",
            "Money isn’t everything, but stability helps everything.",
            "A budget is love for your future self.",
            "You are the CEO of your finances.",
            "Dreams need funding.",
            "Start where you are. Finish better.",
            "Earn more, owe less, give often.",
            "Time + consistency = wealth.",
            "Only buy what brings value — not what brings clutter.",
            "Watch your money the way you watch your screen time.",
            "A steady drip fills the bucket.",
            "Manage your money before someone else does.",
            "Never stop learning about money.",
            "Give every dollar a mission.",
            "Be wealthy in knowledge first.",
            "A little progress beats perfection.",
            "Money that’s idle decays. Money that’s invested grows."
    );

    public static void showPopup(Stage owner) {
        Stage popupStage = new Stage(StageStyle.TRANSPARENT);
        popupStage.initModality(Modality.APPLICATION_MODAL);
        popupStage.initOwner(owner);

        Label quoteLabel = new Label(getRandomQuote());
        quoteLabel.setWrapText(true);
        quoteLabel.setTextAlignment(TextAlignment.CENTER);
        quoteLabel.setAlignment(Pos.CENTER);
        quoteLabel.setMaxWidth(400);
        quoteLabel.setFont(Font.font("Arial", 18));
        quoteLabel.setStyle("-fx-text-fill: #264653; -fx-font-weight: bold;");

        VBox layout = getVBoxLayout(popupStage, quoteLabel);
        layout.setAlignment(Pos.CENTER);
        layout.setPadding(new Insets(30));
        layout.setStyle("""
            -fx-background-color: white;
            -fx-background-radius: 15;
        """);
        layout.setEffect(new DropShadow(20, Color.web("#aaa")));

        Scene scene = new Scene(layout);
        scene.setFill(Color.TRANSPARENT);

        popupStage.setScene(scene);

        // Fade-in transition
        FadeTransition fadeIn = new FadeTransition(Duration.millis(300), layout);
        layout.setOpacity(0);
        fadeIn.setToValue(1);
        fadeIn.play();

        popupStage.showAndWait();
    }

    private static VBox getVBoxLayout(Stage popupStage, Label quoteLabel) {
        Button closeButton = new Button("Got it!");
        closeButton.setStyle("""
            -fx-background-radius: 20;
            -fx-background-color: linear-gradient(to bottom right, #f4a261, #e76f51);
            -fx-text-fill: white;
            -fx-font-weight: bold;
            -fx-padding: 8 20;
            -fx-cursor: hand;
        """);
        closeButton.setOnMouseEntered(e -> closeButton.setStyle(closeButton.getStyle() + "-fx-opacity: 0.85;"));
        closeButton.setOnMouseExited(e -> closeButton.setStyle(closeButton.getStyle().replace("-fx-opacity: 0.85;", "")));
        closeButton.setOnAction(e -> popupStage.close());

        VBox layout = new VBox(25, quoteLabel, closeButton);
        return layout;
    }

    private static String getRandomQuote() {
        if (QUOTES.isEmpty()) {
            return "Stay motivated and save wisely!";
        }
        Random rand = new Random();
        return QUOTES.get(rand.nextInt(QUOTES.size()));
    }

}
