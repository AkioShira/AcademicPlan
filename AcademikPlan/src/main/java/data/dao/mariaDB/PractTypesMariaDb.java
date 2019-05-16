package data.dao.mariaDB;

import connection.pooling.ConnectionPool;
import data.ConnectionService;
import data.dao.PractTypesDao;
import data.model.PractType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PractTypesMariaDb  extends ConnectionService implements PractTypesDao {
    private Connection connection;

    PractTypesMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public List<PractType> getAllPractTypes() {
        return getPractTypes("SELECT * FROM pract_types");
    }

    @Override
    public PractType getPractTypeById(int id) {
        return getPractTypes("SELECT * FROM pract_types WHERE idPractType = "+id).get(0);
    }

    @Override
    public boolean insertPractType(PractType pract) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO pract_types SET name = '"+pract.getName()+"'";
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
    public boolean updatePractType(PractType pract) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE pract_types SET name = '"+pract.getName()+"' WHERE idPractType = "+pract.getIdPractType();
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
    public boolean deletePractType(PractType pract) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM pract_types WHERE idPractType = "+pract.getIdPractType();
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

    private List<PractType> getPractTypes(String query) {
        List<PractType> typesList = new ArrayList<PractType>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                PractType practType = new PractType();
                practType.setIdPractType(rs.getInt("idPractType"));
                practType.setName(rs.getString("name"));
                typesList.add(practType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return typesList;
    }

    public static void main(String ...argc){
        try {
            PractTypesMariaDb practDao = new PractTypesMariaDb(ConnectionPool.getConnection());
            List<PractType> list = practDao.getPractTypes("SELECT * FROM pract_types");
            for(PractType p : list)
                System.out.println(p.getName());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
