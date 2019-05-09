package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.DirectionDao;
import data.model.Direction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DirectionMariaDb extends ConnectionService implements DirectionDao {
    private Connection connection;
    private String sortParameter = "idDirection";

    @Override
    public Direction getDirectionById(int id) {
        String query = "SELECT * FROM directions WHERE idDirection = "+id;
        return getDirections(query).get(0);
    }

    DirectionMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public void setOrder(Direction.sortParameter s) {
        sortParameter = s.toString();
    }

    @Override
    public List<Direction> getAllDirections() {
        String query = "SELECT * FROM directions d";
        return getDirections(query);
    }

    @Override
    public boolean insertDirection(Direction direction) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO directions SET number = '"+direction.getNumber()+"',"
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
    public boolean updateDirection(Direction direction) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE directions SET number = '"+direction.getNumber()+"',"
                +" name = '"+direction.getName()+"' WHERE idDirection = "+direction.getIdDirection();
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
    public boolean deleteDirection(Direction direction) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM directions WHERE idDirection = "+direction.getIdDirection();
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

    private List<Direction> getDirections(String query) {
        List<Direction> directionList = new ArrayList<Direction>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Direction direction = new Direction();
                direction.setIdDirection(rs.getInt("idDirection"));
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
