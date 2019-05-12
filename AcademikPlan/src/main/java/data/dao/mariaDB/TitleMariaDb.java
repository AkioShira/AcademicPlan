package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.TitleDao;
import data.model.Title;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TitleMariaDb extends ConnectionService implements TitleDao {
    private Connection connection;
    private String sortParameter = "idTitle";

    @Override
    public List<Title> getTitlesByVisible(boolean visible) {
        return getTitlesByVisible(visible? 1 : 0);
    }

    TitleMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public Title getTitleById(int id) {
        String query = "SELECT * FROM titles WHERE idTitle = "+id+" ORDER BY "+sortParameter;
        return getTitles(query).get(0);
    }

    @Override
    public List<Title> getTitlesByDepartment(int idDepartment, boolean visibleTitle) {
        String query = "SELECT * FROM titles WHERE idDepartment = "+idDepartment+" AND visible = "+ (visibleTitle ? 1:0) +" ORDER BY "+sortParameter;
        return getTitles(query);
    }

    @Override
    public List<Title> getAllTitles() {
        String query = "SELECT * FROM titles ORDER BY "+sortParameter;
        return getTitles(query);
    }

    @Override
    public boolean insertTitle(Title title) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO titles SET name = '" + title.getName() + "', yearReception = "+title.getYearReception()
                + ", yearCreation = "+ title.getYearCreation()+", qualification = '"+title.getQualification()
                +"', studyTime = "+title.getStudyTime() + ", studyLevel = '"+title.getStudyLevel()
                + "', formEducation = '" + title.getFormEducation()
                + "', idGroupDirection = "+ title.getIdGroupDirection() + ", idDirection = " + title.getIdDirection()
                + ", idProfile = " + title.getIdProfile() + ", idDepartment = " + title.getIdDepartment()
                + ", visible = " + title.isVisible();
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
    public boolean updateTitle(Title title) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE titles SET name = '" + title.getName() + "', yearReception = "+title.getYearReception()
                + ", yearCreation = "+ title.getYearCreation()+", qualification = '"+title.getQualification()
                +"', studyTime = "+title.getStudyTime() + ", studyLevel = '"+title.getStudyLevel()
                + "', formEducation = '" + title.getFormEducation()
                + "', idGroupDirection = "+ title.getIdGroupDirection() + ", idDirection = " + title.getIdDirection()
                + ", idProfile = " + title.getIdProfile() + ", idDepartment = " + title.getIdDepartment()
                + ", visible = " + title.isVisible() + " WHERE idTitle = "+ title.getIdTitle();
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
    public boolean deleteTitle(Title title) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM titles WHERE idTitle = "+title.getIdTitle();
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
    public void setOrder(Title.sortParameter s) {
        this.sortParameter = s.toString();
    }

    private List<Title> getTitlesByVisible(int visible) {
        String query = "SELECT * FROM titles";
        if(visible != -1)
            query += " WHERE visible = "+visible;
        query += " ORDER BY "+sortParameter;
        return getTitles(query);
    }

    private List<Title> getTitles(String query) {
        List<Title> titleList = new ArrayList<Title>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Title title = new Title();
                title.setIdTitle(rs.getInt("idTitle"));
                title.setName(rs.getString("name"));
                title.setYearReception(rs.getInt("yearReception"));
                title.setYearCreation(rs.getInt("yearCreation"));
                title.setQualification(rs.getString("qualification"));
                title.setStudyTime(rs.getInt("studyTime"));
                title.setStudyLevel(rs.getString("studyLevel"));
                title.setFormEducation(rs.getString("formEducation"));
                title.setIdGroupDirection(rs.getInt("idGroupDirection"));
                title.setIdDirection(rs.getInt("idDirection"));
                title.setIdProfile(rs.getInt("idProfile"));
                title.setIdDepartment(rs.getInt("idDepartment"));
                title.setVisible(rs.getInt("visible") == 1);
                titleList.add(title);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return titleList;
    }
}
