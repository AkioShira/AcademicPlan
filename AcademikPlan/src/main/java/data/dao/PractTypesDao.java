package data.dao;

import data.model.PractType;

import java.util.List;

public interface PractTypesDao {
PractType getPractTypeById(int id);
List<PractType> getAllPractTypes();
boolean insertPractType(PractType pract);
boolean updatePractType(PractType pract);
boolean deletePractType(PractType pract);
}
