package data.dao;

import data.model.Department;

import java.util.List;

public interface DepartmentsDao {
    List<Department> getAllDepartments();
    Department getDepartmentById(String id);
    boolean insertUser();
    boolean updateUser();
    boolean deleteUser();
    void setOrder(Department.sortParameter s);
}
