package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.StateSertificationDao;
import data.model.Pract;
import data.model.StateSertification;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StateSertificationMariaDb extends ConnectionService implements StateSertificationDao {
    private Connection connection;

    StateSertificationMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public List<StateSertification> getSertificationsByTitle(int idTitle) {
        return getStateSertifications("SELECT * FROM state_sertification WHERE idTitle = "+idTitle);
    }

    @Override
    public boolean insertSertifications(List<StateSertification> sertifications) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO state_sertification SET idTitle = ?, semester = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(StateSertification state : sertifications) {
                statement.setInt(1, state.getIdTitle());
                statement.setInt(2, state.getSemester());
                statement.addBatch();
            }
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
    public boolean updateSertifications(List<StateSertification> sertifications) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE state_sertification SET idTitle = ?, semester = ? WHERE idSertification=?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(StateSertification state : sertifications) {
                statement.setInt(1, state.getIdTitle());
                statement.setInt(2, state.getSemester());
                statement.setInt(3, state.getIdSertification());
                statement.addBatch();
            }
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

    private List<StateSertification> getStateSertifications(String query) {
        List<StateSertification> sertifications = new ArrayList<StateSertification>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                StateSertification state = new StateSertification();
                state.setIdSertification(rs.getInt("idSertification"));
                state.setIdTitle(rs.getInt("idTitle"));
                state.setSemester(rs.getInt("semester"));
                sertifications.add(state);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return sertifications;
    }
}
