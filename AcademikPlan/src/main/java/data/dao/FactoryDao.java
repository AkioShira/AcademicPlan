package data.dao;

import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FacultyMariaDb;
import data.dao.mariaDB.RoleMariaDb;
import data.dao.mariaDB.UserMariaDb;

import java.sql.Connection;

public interface FactoryDao {
    UserMariaDb getUserMariaDB(Connection connection);
    DepartmentMariaDb getDepartmentMariaDB(Connection connection);
    FacultyMariaDb getFacultyMariaDB(Connection connection);
    RoleMariaDb getRoleMariaDB(Connection connection);
}
