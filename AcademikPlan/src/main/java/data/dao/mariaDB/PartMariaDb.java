package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.PartDao;
import data.model.Part;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PartMariaDb extends ConnectionService implements PartDao {
    private Connection connection;


    PartMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public Part getPartById(int id) {
        return getPartes("SELECT * FROM partes WHERE idPart = "+id).get(0);
    }

    @Override
    public List<Part> getPartesByCycle(int idCycle) {
        return getPartes("SELECT * FROM partes WHERE idCycle = "+idCycle);
    }

    @Override
    public List<Part> getPartesByTitle(int idTitle) {
        return getPartes("SELECT * FROM partes p INNER JOIN cycles c ON p.idCycle = c.idCycle WHERE c.idTitle = "+idTitle);
    }

    @Override
    public boolean insertPart(Part part) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO partes SET idCycle = ?, shortName = ?, name = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            statement.setInt(1, part.getIdCycle());
            statement.setString(2, part.getShortName());
            statement.setString(3, part.getName());
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
    public boolean updatePart(Part part) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE partes SET idCycle = ?, shortName = ?, name = ? WHERE idPart=?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            statement.setInt(1, part.getIdCycle());
            statement.setString(2, part.getShortName());
            statement.setString(3, part.getName());
            statement.setInt(4, part.getIdPart());
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
    public boolean deletePart(Part part) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM partes WHERE idPart = "+part.getIdPart();
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

    private List<Part> getPartes(String query) {
        List<Part> partesList = new ArrayList<Part>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Part part = new Part();
                part.setIdPart(rs.getInt("idPart"));
                part.setIdCycle(rs.getInt("idCycle"));
                part.setShortName(rs.getString("shortName"));
                part.setName(rs.getString("name"));
                partesList.add(part);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return partesList;
    }
}
