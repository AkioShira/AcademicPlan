package data.dao.mariaDB;

import data.dao.FactoryDao;

import java.sql.Connection;

public class FactoryMariaDb implements FactoryDao {
    @Override
    public GroupDirectionMariaDb getGroupDirectionMariaDb(Connection connection) {
        return new GroupDirectionMariaDb(connection);
    }

    @Override
    public TitleMariaDb getTitleMariaDb(Connection connection) {
        return new TitleMariaDb(connection);
    }

    @Override
    public ProfileMariaDb getProfileMariaDb(Connection connection) {
        return new ProfileMariaDb(connection);
    }

    @Override
    public DirectionMariaDb getDirectionMariaDb(Connection connection) {
        return new DirectionMariaDb(connection);
    }

    @Override
    public FacultyMariaDb getFacultyMariaDB(Connection connection) {
        return new FacultyMariaDb(connection);
    }

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
