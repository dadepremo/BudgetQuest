package dao;

import model.Achievement;

import java.util.List;

public interface AchievementDao {

    Achievement findById(int id);

    Achievement findByCode(String code);

    List<Achievement> findAll();

    void save(Achievement achievement);

    void deleteById(int id);

}
