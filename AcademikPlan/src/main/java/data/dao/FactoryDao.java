package data.dao;

import data.dao.mariaDB.*;

import java.sql.Connection;

public interface FactoryDao {
    UserMariaDb getUserMariaDB(Connection connection);
    DepartmentMariaDb getDepartmentMariaDB(Connection connection);
    FacultyMariaDb getFacultyMariaDB(Connection connection);
    RoleMariaDb getRoleMariaDB(Connection connection);
    ProfileMariaDb getProfileMariaDb(Connection connection);
    DirectionMariaDb getDirectionMariaDb(Connection connection);
    GroupDirectionMariaDb getGroupDirectionMariaDb(Connection connection);
    TitleMariaDb getTitleMariaDb(Connection connection);
}
