package data.dao;

import data.model.Faculty;

import java.util.List;

public interface FacultyDao {
    List<Faculty> getAllFaculties();
    List<Faculty> getFacultyByVisible(boolean visible);
    Faculty getFacultyById(int id);
    boolean isUniqueName(String name);
    boolean isUniqueShortName(String shortName);
    boolean insertFaculty(Faculty faculty);
    boolean updateFaculty(Faculty faculty);
    boolean deleteFaculty(Faculty faculty);
    void setOrder(Faculty.sortParameter s);
}
