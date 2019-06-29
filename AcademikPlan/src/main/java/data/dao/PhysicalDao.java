package data.dao;

import data.model.Physical;

import java.util.List;

public interface PhysicalDao {
Physical getPhysicalById(int id);
List<Physical> getPhysicalsByTitle(int idTitle);
boolean insertPhysical(List<Physical> physicalList);
boolean updatePhysical(List<Physical> physicalList);
boolean deletePhysical(Physical physical);
}
