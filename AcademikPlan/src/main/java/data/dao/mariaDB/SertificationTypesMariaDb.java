package data.dao.mariaDB;

import connection.pooling.ConnectionPool;
import data.ConnectionService;
import data.dao.SertificationTypesDao;
import data.model.SertificationType;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SertificationTypesMariaDb extends ConnectionService implements SertificationTypesDao {
    private Connection connection;

    SertificationTypesMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public List<SertificationType> getAllSertificationTypes() {
        return getSertificationTypes("SELECT * FROM sertification_types");
    }

    @Override
    public SertificationType getSertificationTypeById(int id) {
        return getSertificationTypes("SELECT * FROM sertification_types WHERE idSertificationType = "+id).get(0);
    }

    @Override
    public boolean insertSertificationType(SertificationType type) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO sertification_types SET name = '"+type.getName()+"'";
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
    public boolean updateSertificationType(SertificationType pract) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE sertification_types SET name = '"+pract.getName()+"' WHERE idSertificationType = "+pract.getIdSertificationType();
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
    public boolean deleteSertificationType(SertificationType pract) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM sertification_types WHERE idSertificationType = "+pract.getIdSertificationType();
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

    private List<SertificationType> getSertificationTypes(String query) {
        List<SertificationType> typesList = new ArrayList<SertificationType>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                SertificationType practType = new SertificationType();
                practType.setIdSertificationType(rs.getInt("idSertificationType"));
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
}
