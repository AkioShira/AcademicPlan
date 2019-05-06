package data.dao;

import data.model.Department;

import java.util.List;

public interface DepartmentsDao {
    List<Department> getAllDepartments();
    List<Department> getDepartmentByVisible(boolean visible);
    List<Department> getDepartmentByVisibleFaculty(boolean facultyVisible, boolean departmentVisible);
    Department getDepartmentById(int id);
    boolean isUniqueName(String name);
    boolean isUniqueShortName(String shortName);
    boolean insertDepartment(Department department);
    boolean updateDepartment(Department department);
    boolean deleteDepartment(Department department);
    void setOrder(Department.sortParameter s);
}
