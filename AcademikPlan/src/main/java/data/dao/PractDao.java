package data.dao;

import data.model.Pract;
import java.util.List;

public interface PractDao {
    Pract getPractById(int id);
    List<Pract> getPractsByTitle(int idTitle);
    boolean insertPracts(List<Pract> practs);
    boolean updatePracts(List<Pract> practs);
    boolean deletePract(Pract pract);
    void setOrder(Pract.sortParameter s);
}
