package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.NameDao;
import data.model.Name;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NameMariaDb extends ConnectionService implements NameDao {
    private Connection connection;

    @Override
    public Name getNameByTitle(int id) {
        String query = "SELECT * FROM names WHERE idTitle = "+id;
        return getNames(query).get(0);
    }

    NameMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public List<Name> getAllNames() {
        String query = "SELECT * FROM names p";
        return getNames(query);
    }

    @Override
    public boolean insertName(Name name) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO names SET idTitle = "+name.getIdTitle()+", rectorName = '"+name.getRectorName()
                +"', studyName='"+name.getStudyName()+"', prorectorName='"+name.getProrectorName()
                +"', decanName='"+name.getDecanName()+"', departName='"+name.getDepartName()+"'";
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
    public boolean updateName(Name name) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE names SET idTitle = "+name.getIdTitle()+", rectorName = '"+name.getRectorName()
                +"', studyName='"+name.getStudyName()+"', prorectorName='"+name.getProrectorName()
                +"', decanName='"+name.getDecanName()+"', departName='"+name.getDepartName()+"' WHERE idName = "+name.getIdName();
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
    public boolean deleteName(Name name) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM names WHERE idName = "+name.getIdName();
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

    private List<Name> getNames(String query) {
        List<Name> nameList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Name name = new Name();
                name.setIdName(rs.getInt("idName"));
                name.setIdTitle(rs.getInt("idTitle"));
                name.setRectorName(rs.getString("rectorName"));
                name.setStudyName(rs.getString("studyName"));
                name.setProrectorName(rs.getString("prorectorName"));
                name.setDecanName(rs.getString("decanName"));
                name.setDepartName(rs.getString("departName"));
                nameList.add(name);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return nameList;
    }
}
