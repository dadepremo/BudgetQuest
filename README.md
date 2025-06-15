# BudgetQuest

A gamified personal finance tracking application built with **JavaFX** and **PostgreSQL**.

## Overview

BudgetQuest helps you manage your finances in a fun and engaging way. Track your expenses, set budgets, and achieve your financial goals — all while leveling up through gamified challenges.

## Features

- Add and categorize transactions easily
- Visualize your spending habits
- Gamification elements to keep you motivated
- Secure data storage with PostgreSQL backend

## Installation & Setup

Maven is not present, jars needed:
- jbcrypt-0.4.jar
- postgresql-42.7.6.jar
- javafx-sdk-24.0.1\lib

Java Fx version:
- javafx-sdk-24.0.1

Java version: 24

1. Clone the repository:

   ```bash
   git clone https://github.com/dadepremo/budgetquest.git
   cd budgetquest
2. Set up PostgreSQL database:
- Create a new database, e.g., budgetquest_db
- Run the provided SQL scripts in the /scripts folder to create tables and seed data
- The db creation script most up to date is the "full_export15062025.sql", other scripts are older or for testing

3. Configure database connection:
- Open the DbConnection class under /utils
- Update the database URL, username, and password accordingly

Usage
Launch the app
- Register or log in to your account (the users available in the script are at your disposal, the psw is the username)
- Start adding transactions and managing your budget
- Track your progress and enjoy the gamified experience!

Contributing
Feel free to fork the project and submit pull requests. Please make sure to update tests as appropriate.

License
This project is licensed under the MIT License - see the LICENSE file for details.

---

Contact me for any question and feel free to submit pull requests.
