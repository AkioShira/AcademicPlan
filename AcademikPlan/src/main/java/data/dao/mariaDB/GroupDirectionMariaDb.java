package data.dao.mariaDB;

import data.ConnectionService;

import data.dao.GroupDirectionDao;
import data.model.GroupDirection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GroupDirectionMariaDb extends ConnectionService implements GroupDirectionDao {
    private Connection connection;
    private String sortParameter = "idGroupDirection";

    @Override
    public GroupDirection getDirectionById(int id) {
        String query = "SELECT * FROM group_direction WHERE idGroupDirection = "+id;
        return getDirections(query).get(0);
    }

    GroupDirectionMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public void setOrder(GroupDirection.sortParameter s) {
        sortParameter = s.toString();
    }

    @Override
    public List<GroupDirection> getAllDirections() {
        String query = "SELECT * FROM group_direction d";
        return getDirections(query);
    }

    @Override
    public boolean insertDirection(GroupDirection direction) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO group_direction SET number = '"+direction.getNumber()+"',"
                +" name = '"+direction.getName()+"'";
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
    public boolean updateDirection(GroupDirection direction) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE group_direction SET number = '"+direction.getNumber()+"',"
                +" name = '"+direction.getName()+"' WHERE idGroupDirection = "+direction.getIdGroupDirection();
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
    public boolean deleteDirection(GroupDirection direction) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM group_direction WHERE idGroupDirection = "+direction.getIdGroupDirection();
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

    private List<GroupDirection> getDirections(String query) {
        List<GroupDirection> directionList = new ArrayList<GroupDirection>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                GroupDirection direction = new GroupDirection();
                direction.setIdGroupDirection(rs.getInt("idGroupDirection"));
                direction.setNumber(rs.getString("number"));
                direction.setName(rs.getString("name"));
                directionList.add(direction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return directionList;
    }
}
