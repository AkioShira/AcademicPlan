package data.dao;

import data.model.Part;

import java.util.List;

public interface PartDao {
    Part getPartById(int id);
    List<Part> getPartesByCycle(int idCycle);
    List<Part> getPartesByTitle(int idTitle);
    boolean insertPart(Part part);
    boolean updatePart(Part part);
    boolean deletePart(Part part);
}
