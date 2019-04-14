package data.dao;

import data.model.Department;

import java.util.List;

public interface DepartmentsDao {
    List<Department> getAllDepartments();
    List<Department> getDepartmentByVisible(boolean visible);
    Department getDepartmentById(int id);
    boolean insertUser();
    boolean updateUser();
    boolean deleteUser();
    void setOrder(Department.sortParameter s);
}
