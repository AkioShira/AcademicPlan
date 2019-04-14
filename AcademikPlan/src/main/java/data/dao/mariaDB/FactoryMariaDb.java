package data.dao.mariaDB;

import data.dao.FactoryDao;

import java.sql.Connection;

public class FactoryMariaDb implements FactoryDao {
    @Override
    public UserMariaDb getUserMariaDB(Connection connection) {
        return new UserMariaDb(connection);
    }

    @Override
    public DepartmentMariaDb getDepartmentMariaDB(Connection connection) {
        return new DepartmentMariaDb(connection);
    }

    @Override
    public RoleMariaDb getRoleMariaDB(Connection connection) {
        return new RoleMariaDb(connection);
    }
}
