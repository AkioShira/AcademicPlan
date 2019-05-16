package data.dao.mariaDB;

import connection.pooling.ConnectionPool;
import data.ConnectionService;
import data.dao.PractDao;
import data.model.Pract;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PractMariaDb extends ConnectionService implements PractDao {
    private Connection connection;

    PractMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public List<Pract> getPractsByTitle(int idTitle) {
        return getPractTypes("SELECT * FROM practs WHERE idTitle = "+idTitle);
    }

    @Override
    public boolean insertPracts(List<Pract> practs) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO practs SET idTitle = ?, idPractType = ?, semester = ?, week = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(Pract pract : practs) {
                statement.setInt(1, pract.getIdTitle());
                statement.setInt(2, pract.getIdPractType());
                statement.setInt(3, pract.getSemester());
                statement.setInt(4, pract.getWeek());
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
    public boolean updatePracts(List<Pract> practs) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE practs SET idTitle = ?, idPractType = ?, semester = ?, week = ? WHERE idPract=?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(Pract pract : practs) {
                statement.setInt(1, pract.getIdTitle());
                statement.setInt(2, pract.getIdPractType());
                statement.setInt(3, pract.getSemester());
                statement.setInt(4, pract.getWeek());
                statement.setInt(5, pract.getIdPract());
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

    private List<Pract> getPractTypes(String query) {
        List<Pract> practsList = new ArrayList<Pract>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Pract pract = new Pract();
                pract.setIdPract(rs.getInt("idPract"));
                pract.setIdPractType(rs.getInt("idPractType"));
                pract.setIdTitle(rs.getInt("idTitle"));
                pract.setSemester(rs.getInt("semester"));
                pract.setWeek(rs.getInt("week"));
                practsList.add(pract);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return practsList;
    }

    public static void main(String ...argc){
        try {
            PractMariaDb practDao = new PractMariaDb(ConnectionPool.getConnection());
            List<Pract> list = practDao.getPractsByTitle(1);
            for(Pract p : list)
                System.out.println(p.getSemester());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
