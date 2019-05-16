package data.dao;

import data.model.Pract;

import java.util.List;

public interface PractDao {
    List<Pract> getPractsByTitle(int idTitle);
    boolean insertPracts(List<Pract> practs);
    boolean updatePracts(List<Pract> practs);
}
