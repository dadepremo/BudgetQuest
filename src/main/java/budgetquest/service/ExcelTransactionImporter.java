package budgetquest.service;

import budgetquest.dao.CategoryDao;
import budgetquest.dao.CategoryDaoImpl;
import budgetquest.model.Category;
import budgetquest.model.Transaction;
import budgetquest.model.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExcelTransactionImporter {

    private static final Logger logger = LogManager.getLogger(ExcelTransactionImporter.class);

    public static Map<Category, Transaction> importFromExcel(File file, User user) {
        Map<Category, Transaction> result = new HashMap<>();
        try (FileInputStream fis = new FileInputStream(file);
             Workbook workbook = new XSSFWorkbook(fis)) {

            Sheet sheet = workbook.getSheetAt(0);

            boolean dataStarted = false;

            CategoryDao categoryDao = new CategoryDaoImpl();
            List<Category> categories = categoryDao.findAllByUser(user);

            for (Row row : sheet) {
                if (!dataStarted) {
                    String firstCellValue = getCellStringValue(row, 0);
                    logger.info("Row " + row.getRowNum() + " - first cell: '" + firstCellValue + "'");

                    if ("Tipologia".equalsIgnoreCase(firstCellValue != null ? firstCellValue.trim() : "")) {
                        dataStarted = true;
                        logger.info("Data header found at row " + row.getRowNum());
                        continue;
                    } else {
                        continue;
                    }
                }
                logger.info("Processing data row " + row.getRowNum());

                for (Cell cell : row) {
                    logger.info("Row " + row.getRowNum() + " Cell " + cell.getColumnIndex() + ": '" + getCellStringValue(row, cell.getColumnIndex()) + "'");
                }
                // Now process data rows

                String firstCellValue = getCellStringValue(row, 0);
                Double rawAmount = getCellNumericValue(row, 7);

                if (rawAmount == null) {
                    String amountStr = getCellStringValue(row, 7);
                    if (amountStr != null && !amountStr.isEmpty()) {
                        try {
                            // Replace comma with dot for decimals, keep the minus sign intact
                            amountStr = amountStr.replace(",", ".");
                            rawAmount = Double.parseDouble(amountStr);
                        } catch (NumberFormatException e) {
                            logger.warn("Amount cell invalid format at row " + row.getRowNum() + ": " + amountStr);
                        }
                    }
                }
                if (rawAmount == null) {
                    logger.warn("Amount cell is empty or invalid at row " + row.getRowNum());
                    continue;
                }

                BigDecimal amount;
                Category category = new Category();
                Transaction transaction = new Transaction();
                String description = getCellStringValue(row, 6);
                transaction.setDescription(description);

                int deafultIncomeId = 0;
                int deafultExpenseId = 0;
                for (Category c : categories) {
                    if (c.getName().equals("Not Categorized") && c.getType().equals("income")) {
                        deafultIncomeId =  c.getId();
                    } else if (c.getName().equals("Not Categorized") && c.getType().equals("expense")){
                        deafultExpenseId = c.getId();
                    }

                }

                // TODO: test
                if ("uscite".equalsIgnoreCase(firstCellValue) || "expense".equalsIgnoreCase(firstCellValue)) {
                    for (Category c : categories) {
                        if (c.getName().equalsIgnoreCase(getCellStringValue(row, 1)) && c.getType().equals("expense")) {
                            category.setName(c.getName());
                            category.setId(c.getId());
                        } else {
                            category.setName("Not Categorized");
                            category.setId(deafultExpenseId);
                        }
                    }
                    category.setType("expense");
                    category.setDeleted(false);
                    amount = BigDecimal.valueOf(rawAmount);
                    if (amount.compareTo(BigDecimal.ZERO) < 0) {
                        amount = amount.negate();
                    }
                } else if ("entrate".equalsIgnoreCase(firstCellValue) || "income".equalsIgnoreCase(firstCellValue)) {
                    amount = BigDecimal.valueOf(rawAmount);
                    for (Category c : categories) {
                        if (c.getName().equalsIgnoreCase(getCellStringValue(row, 1)) && c.getType().equals("income")) {
                            category.setName(c.getName());
                            category.setId(c.getId());
                        } else {
                            category.setName("Not Categorized");
                            category.setId(deafultIncomeId);
                        }
                    }
                    category.setDeleted(false);
                    category.setType("income");
                } else {
                    for (Category c : categories) {
                        if (c.getName().equalsIgnoreCase(getCellStringValue(row, 1))) {
                            category.setName(c.getName());
                            category.setType(c.getType());
                            category.setId(c.getId());
                        }
                    }
                    amount = BigDecimal.valueOf(rawAmount);
                }


                // Extract date safely
                LocalDate date = null;
                Cell dateCell = row.getCell(4);
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

                if (dateCell != null) {
                    CellType cellType = dateCell.getCellType();

                    if (cellType == CellType.NUMERIC || cellType == CellType.FORMULA) {
                        if (DateUtil.isCellDateFormatted(dateCell)) {
                            date = dateCell.getLocalDateTimeCellValue().toLocalDate();
                        } else {
                            logger.info("Cell is numeric but not date formatted at row " + row.getRowNum());
                        }
                    } else if (cellType == CellType.STRING) {
                        try {
                            String dateStr = dateCell.getStringCellValue().trim();
                            date = LocalDate.parse(dateStr, formatter);  // use custom formatter here
                        } catch (DateTimeParseException e) {
                            logger.warn("Invalid date string format at row " + row.getRowNum() + ": " + e.getMessage());
                        }
                    } else {
                        logger.info("Date cell is of unsupported type at row " + row.getRowNum());
                    }
                }

                // Prepare transaction
                String name = getCellStringValue(row, 5);


                if (name != null && name.length() > 50) {
                    name = name.substring(0, 50);
                }
                transaction.setName(name);
                transaction.setCategoryId(category.getId());
                transaction.setAmount(amount);
                if (date == null) {
                    logger.warn("Skipping row " + row.getRowNum() + " due to invalid or missing date");
                    date = LocalDate.now();  // or some sensible default
                }
                transaction.setDate(date);

                category.setDeleted(false);
                category.setUserId(user.getId());


                result.put(category, transaction);
            }
        } catch (Exception e) {
            logger.error("Failed to import from Excel", e);
        }

        return result;
    }


    private static String getCellStringValue(Row row, int cellIndex) {
        Cell cell = row.getCell(cellIndex);
        if (cell == null) return "";  // or null, as you prefer
        if (cell.getCellType() == CellType.STRING) {
            return cell.getStringCellValue();
        } else if (cell.getCellType() == CellType.NUMERIC) {
            return String.valueOf(cell.getNumericCellValue());
        } else if (cell.getCellType() == CellType.BOOLEAN) {
            return String.valueOf(cell.getBooleanCellValue());
        } else if (cell.getCellType() == CellType.FORMULA) {
            return cell.getCellFormula();  // or evaluate the formula
        }
        return "";
    }

    private static Double getCellNumericValue(Row row, int cellIndex) {
        Cell cell = row.getCell(cellIndex);
        if (cell == null) return null;
        if (cell.getCellType() == CellType.NUMERIC) {
            return cell.getNumericCellValue();
        } else if (cell.getCellType() == CellType.STRING) {
            try {
                return Double.parseDouble(cell.getStringCellValue());
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }

}

