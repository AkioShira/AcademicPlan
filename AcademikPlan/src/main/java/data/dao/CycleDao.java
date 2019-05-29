package data.dao;

import data.model.Cycle;

import java.util.List;

public interface CycleDao {
    Cycle getCycleById(int id);
    List<Cycle> getCyclesByTitle(int idTitle);
    boolean insertCycle(Cycle cycle);
    boolean updateCycle(Cycle cycle);
    boolean deleteCycle(Cycle cycle);
    int getCountCycleByTitle(int idTitle);
}
