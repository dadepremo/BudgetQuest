package dao;

import model.Asset;
import model.User;

import java.util.List;

public interface AssetDao {

    boolean insertAsset(Asset asset);

    double sumAllAssetValues(User user);

    List<Asset> findAllByUser(User user);
}
