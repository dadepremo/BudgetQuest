package dao;


import model.ShopItem;

import java.util.List;

public interface ShopItemDao {
    List<ShopItem> getAllItems();

    ShopItem getItemById(int id);

    ShopItem getItemByNameForUser(String name, int id);

    boolean userOwnsItem(int userId, int itemId);

    boolean recordPurchase(int userId, int itemId);

    boolean insertItem(ShopItem item);

    boolean updateItem(ShopItem item);

    boolean deleteItem(int id);

}
