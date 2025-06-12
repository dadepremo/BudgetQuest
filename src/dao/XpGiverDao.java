package dao;

import model.XpGiver;

import java.util.List;
import java.util.Optional;

public interface XpGiverDao {

    Optional<XpGiver> getById(int id);

    int getValueByName(String name);

    List<XpGiver> getAll();

    boolean insert(XpGiver xpGiver);

    boolean update(XpGiver xpGiver);

    boolean delete(int id); // soft delete

}
