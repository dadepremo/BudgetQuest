package budgetquest.dao;

import budgetquest.model.Asset;
import budgetquest.model.User;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public interface AssetDao {

    void updateAsset(Asset asset, User user) throws SQLException;

    List<Asset> searchAssets(int userId, String nameFilter, LocalDate fromDate, LocalDate toDate);

    boolean insertAsset(Asset asset);

    double sumAllAssetValues(User user);

    List<Asset> findAllByUser(User user);
}
