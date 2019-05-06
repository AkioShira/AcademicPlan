package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.FacultyDao;
import data.model.Faculty;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FacultyMariaDb extends ConnectionService implements FacultyDao {
    private Connection connection;
    private String sortParameter = "idFaculty";

    FacultyMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public List<Faculty> getAllFaculties() {
        return getFacultiesByVisible(-1);
    }

    @Override
    public List<Faculty> getFacultyByVisible(boolean visible) {
        return getFacultiesByVisible(visible? 1 : 0);
    }

    @Override
    public Faculty getFacultyById(int id) {
        String query = "SELECT * FROM faculties WHERE idFaculty = " + id;
        return getFaculties(query).get(0);
    }

    @Override
    public boolean isUniqueName(String name) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.prepareStatement("SELECT * FROM faculties WHERE name = '"+name+"'");
            rs = statement.executeQuery();
            int i = 0;
            while(rs.next())
                i++;
            return i<1;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public boolean isUniqueShortName(String shortName) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.prepareStatement("SELECT * FROM faculties WHERE shortName = '"+shortName+"'");
            rs = statement.executeQuery();
            int i = 0;
            while(rs.next())
                i++;
            return i<1;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public boolean insertFaculty(Faculty faculty) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO faculties SET name = '"+faculty.getName()+"',"
                + " shortName = '"+faculty.getShortName()+"', visible = " + (faculty.isVisible() ? 1 : 0);
        try{
            statement = connection.prepareStatement(query);
            statement.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public boolean updateFaculty(Faculty faculty) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE faculties SET name = '"+faculty.getName()+"',"
                + " shortName = '"+faculty.getShortName()+"', visible = " + (faculty.isVisible() ? 1 : 0)
                + " WHERE idFaculty = " + faculty.getIdFaculty();
        try{
            statement = connection.prepareStatement(query);
            statement.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public boolean deleteFaculty(Faculty faculty) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM faculties WHERE idFaculty = "+faculty.getIdFaculty();
        try{
            statement = connection.prepareStatement(query);
            statement.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public void setOrder(Faculty.sortParameter s) {
        this.sortParameter = s.toString();
    }

    private List<Faculty> getFacultiesByVisible(int visible) {
        String query = "SELECT * FROM faculties";
        if(visible != -1)
            query += " WHERE visible = "+visible;
        query += " ORDER BY "+sortParameter;
        return getFaculties(query);
    }

    private List<Faculty> getFaculties(String query) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        List<Faculty> facList = new ArrayList<Faculty>();
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Faculty faculty = new Faculty();
                faculty.setIdFaculty(rs.getInt("idFaculty"));
                faculty.setName(rs.getString("name"));
                faculty.setShortName(rs.getString("shortName"));
                faculty.setVisible(rs.getInt("visible") == 1);
                facList.add(faculty);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return facList;
    }
}
