package data.dao;

import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.UserMariaDb;

import java.sql.Connection;

public interface FactoryDao {
    UserMariaDb getUserDao(Connection connection);
    DepartmentMariaDb getDepartmentMariaDB(Connection connection);
}
