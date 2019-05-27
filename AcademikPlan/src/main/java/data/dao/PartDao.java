package data.dao;

import data.model.Cycle;
import data.model.Part;

import java.util.List;

public interface PartDao {
    Part getPartById(int id);
    List<Part> getPartesByCycle(int idCycle);
    boolean insertPart(Part part);
    boolean updatePart(Part part);
    boolean deletePart(Part part);
}
