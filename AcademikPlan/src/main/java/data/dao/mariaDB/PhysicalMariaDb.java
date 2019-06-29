package data.dao.mariaDB;

import connection.pooling.ConnectionPool;
import data.ConnectionService;
import data.dao.PhysicalDao;
import data.model.Physical;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PhysicalMariaDb extends ConnectionService implements PhysicalDao {
    private Connection connection;

    PhysicalMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public List<Physical> getPhysicalsByTitle(int idTitle) {
        return getPhysicals("SELECT p.idPhysical, p.idTitle, p.idPhysicalType, p.bsr, pt.name FROM physical p \n" +
                "  INNER JOIN physical_types pt ON p.idPhysicalType = pt.idPhysicalType\n" +
                "  WHERE p.idTitle = "+ idTitle);
    }

    @Override
    public Physical getPhysicalById(int id) {
        return getPhysicals("SELECT p.idPhysical, p.idTitle, p.idPhysicalType, p.bsr, pt.name FROM physical p \n" +
                "  INNER JOIN physical_types pt ON p.idPhysicalType = pt.idPhysicalType\n" +
                "  WHERE p.idPhysical = "+ id).get(0);
    }

    @Override
    public boolean insertPhysical(List<Physical> physicalList) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query0="INSERT INTO physical SET idTitle = ?, idPhysicalType = ?, bsr = ?";
        String query1="INSERT INTO aud_weeks SET idPhysical = ?, week = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query0);
            for(Physical physical : physicalList) {
                statement.setInt(1, physical.getIdTitle());
                statement.setInt(2, physical.getIdPhysicalType());
                statement.setInt(3, physical.getBsr());
                statement.addBatch();
            }
            statement.executeBatch();

            physicalList = getPhysicalsByTitle(physicalList.get(0).getIdTitle());

            statement = connection.prepareStatement(query1);
            for(Physical physical : physicalList) {
                for(int i =0; i< 8; i++){
                    statement.setInt(1, physical.getIdPhysical());
                    statement.setDouble(2, 0);
                    statement.addBatch();
                }
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
    public boolean updatePhysical(List<Physical> physicalList) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query0="UPDATE physical SET idTitle = ?, idPhysicalType = ?, bsr = ? WHERE idPhysical = ?";
        String query1="UPDATE aud_weeks SET idPhysical = ?, week = ? WHERE idAud = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query0);
            for(Physical physical : physicalList) {
                statement.setInt(1, physical.getIdTitle());
                statement.setInt(2, physical.getIdPhysicalType());
                statement.setInt(3, physical.getBsr());
                statement.setInt(4, physical.getIdPhysical());
                statement.addBatch();
            }
            statement.executeBatch();

            statement = connection.prepareStatement(query1);
            for(Physical physical : physicalList) {

                PreparedStatement statement1 = connection.prepareStatement("SELECT idAud FROM aud_weeks WHERE idPhysical = " + physical.getIdPhysical());
                List<Integer> idAudList = new ArrayList<>();
                rs = statement1.executeQuery();
                while(rs.next()){
                    idAudList.add(rs.getInt(1));
                }

                for(int i =0; i< 8; i++){
                    statement.setInt(1, physical.getIdPhysical());
                    statement.setDouble(2, physical.getWeek().get(i));
                    statement.setInt(3, idAudList.get(i));
                    statement.addBatch();
                }
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
    public boolean deletePhysical(Physical physical) {
        return false;
    }

    private List<Physical> getPhysicals(String query) {
        List<Physical> physicalList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Physical physical = new Physical();
                physical.setIdPhysical(rs.getInt("idPhysical"));
                physical.setIdTitle(rs.getInt("idPhysical"));
                physical.setIdPhysicalType(rs.getInt("idPhysicalType"));
                physical.setName(rs.getString("name"));
                physical.setBsr(rs.getInt("bsr"));
                physicalList.add(physical);
            }
            for(Physical p : physicalList){
                statement = connection.prepareStatement("SELECT * FROM aud_weeks WHERE idPhysical = "+p.getIdPhysical());
                rs = statement.executeQuery();
                List<Double> weekList = new ArrayList<>();
                while(rs.next()){
                    weekList.add(rs.getDouble("week"));
                }
                p.setWeek(weekList);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return physicalList;
    }

    public static void main(String... argc){
        FactoryMariaDb fb = new FactoryMariaDb();
        try {
            PhysicalMariaDb physicalDao = fb.getPhysicalMariaDb(ConnectionPool.getConnection());

            List<Physical> list = physicalDao.getPhysicalsByTitle(2);
            physicalDao.insertPhysical(list);

            for(Physical p : list)
                System.out.println(p.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }



    }
}
