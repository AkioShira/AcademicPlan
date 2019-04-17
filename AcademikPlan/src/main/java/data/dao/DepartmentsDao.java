package data.dao;

import data.model.Department;

import java.util.List;

public interface DepartmentsDao {
    List<Department> getAllDepartments();
    List<Department> getDepartmentByVisible(boolean visible);
    Department getDepartmentById(int id);
    boolean isUniqueNames(String name, String shortName);
    boolean insertDepartment(Department department);
    boolean updateDepartment(Department department);
    boolean deleteDepartment(Department department);
    void setOrder(Department.sortParameter s);
}
