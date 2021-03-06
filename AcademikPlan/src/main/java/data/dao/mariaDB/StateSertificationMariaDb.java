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
        String query="INSERT INTO state_sertification SET idTitle = ?, idSertificationType = ?, semester = ?, ze=?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(StateSertification state : sertifications) {
                statement.setInt(1, state.getIdTitle());
                statement.setInt(2, state.getIdSertificationType());
                statement.setInt(3, state.getSemester());
                statement.setInt(4, 0);
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
    public boolean deleteSertification(StateSertification state) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM state_sertification WHERE idSertification = "+state.getIdSertification();
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
    public StateSertification getStateSertificationById(int id) {
        return getStateSertifications("SELECT * FROM state_sertification WHERE idSertification = "+id).get(0);
    }

    @Override
    public boolean updateSertifications(List<StateSertification> sertifications) {
        PreparedStatement statement = null;
        ResultSet rs = null;

        try{

            for(StateSertification state : sertifications) {
                String query="UPDATE state_sertification SET idTitle = "+state.getIdTitle()+", idSertificationType = "+state.getIdSertificationType()+
                        ", semester = "+state.getSemester()+",  ze="+state.getZe()+" WHERE idSertification="+state.getIdSertification();
                statement = connection.prepareStatement(query);
                statement.execute();
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }finally {

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
                state.setIdSertificationType(rs.getInt("idSertificationType"));
                state.setSemester(rs.getInt("semester"));
                state.setZe(rs.getDouble("ze"));
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
