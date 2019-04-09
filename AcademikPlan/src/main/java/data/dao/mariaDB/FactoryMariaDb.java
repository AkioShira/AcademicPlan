package data.dao.mariaDB;

import data.dao.FactoryDao;

import java.sql.Connection;

public class FactoryMariaDb implements FactoryDao {
    @Override
    public UserMariaDb getUserDao(Connection connection) {
        return new UserMariaDb(connection);
    }

    @Override
    public DepartmentMariaDb getDepartmentMariaDB(Connection connection) {
        return new DepartmentMariaDb(connection);
    }
}
