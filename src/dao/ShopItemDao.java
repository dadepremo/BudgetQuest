package dao;


import model.ShopItem;

import java.util.List;

public interface ShopItemDao {
    List<ShopItem> getAllItems();
    ShopItem getItemById(int id);
    boolean insertItem(ShopItem item);
    boolean updateItem(ShopItem item);
    boolean deleteItem(int id);
}
