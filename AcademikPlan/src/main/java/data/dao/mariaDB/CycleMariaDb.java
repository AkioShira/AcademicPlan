package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.CycleDao;
import data.model.Cycle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CycleMariaDb extends ConnectionService implements CycleDao {
    private Connection connection;


    CycleMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public Cycle getCycleById(int id) {
        return getCycles("SELECT * FROM cycles WHERE idCycle = "+id).get(0);
    }

    @Override
    public List<Cycle> getCyclesByTitle(int idTitle) {
        return getCycles("SELECT * FROM cycles WHERE idTitle = "+idTitle);
    }

    @Override
    public boolean insertCycle(Cycle cycle) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO cycles SET idTitle = ?, shortName = ?, name = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            statement.setInt(1, cycle.getIdTitle());
            statement.setString(2, cycle.getShortName());
            statement.setString(3, cycle.getName());
            statement.addBatch();
            statement.executeBatch();
            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public boolean updateCycle(Cycle cycle) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE cycles SET idTitle = ?, shortName = ?, name = ? WHERE idCycle=?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            statement.setInt(1, cycle.getIdTitle());
            statement.setString(2, cycle.getShortName());
            statement.setString(3, cycle.getName());
            statement.setInt(4, cycle.getIdCycle());
            statement.addBatch();
            statement.executeBatch();
            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public boolean deleteCycle(Cycle cycle) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM cycles WHERE idCycle = "+cycle.getIdCycle();
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

    private List<Cycle> getCycles(String query) {
        List<Cycle> cyclesList = new ArrayList<Cycle>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Cycle cycle = new Cycle();
                cycle.setIdCycle(rs.getInt("idCycle"));
                cycle.setIdTitle(rs.getInt("idTitle"));
                cycle.setShortName(rs.getString("shortName"));
                cycle.setName(rs.getString("name"));
                cyclesList.add(cycle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return cyclesList;
    }

    @Override
    public int getCountCycleByTitle(int idTitle) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement("SELECT COUNT(c.name) FROM cycles c WHERE c.idTitle = "+idTitle);
            rs = statement.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return -1;
    }
}
