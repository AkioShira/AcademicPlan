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
    public PractTypesMariaDb getPractTypesMariaDb(Connection connection) {
        return new PractTypesMariaDb(connection);
    }

    @Override
    public StateSertificationMariaDb getStateSertificationMariaDb(Connection connection) {
        return new StateSertificationMariaDb(connection);
    }

    @Override
    public PractMariaDb getPractMariaDb(Connection connection) {
        return new PractMariaDb(connection);
    }

    @Override
    public StudyShedulesMariaDb getStudySheduleMariaDb(Connection connection) {
        return new StudyShedulesMariaDb(connection);
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

    @Override
    public SertificationTypesMariaDb getSertificationTypesMariaDb(Connection connection) {
        return new SertificationTypesMariaDb(connection);
    }

    @Override
    public PartMariaDb getPartMariaDb(Connection connection) {
        return new PartMariaDb(connection);
    }

    @Override
    public CycleMariaDb getCycleMariaDb(Connection connection) {
        return new CycleMariaDb(connection);
    }

    @Override
    public SubSubjectMariaDb getSubSubjectMariaDb(Connection connection) {
        return new SubSubjectMariaDb(connection);
    }

    @Override
    public SubjectMariaDb getSubjectMariaDb(Connection connection) {
        return new SubjectMariaDb(connection);
    }
}
