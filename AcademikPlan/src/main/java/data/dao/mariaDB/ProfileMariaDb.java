package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.ProfileDao;
import data.model.Profile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProfileMariaDb extends ConnectionService implements ProfileDao {
    private Connection connection;
    private String sortParameter = "idProfile";

    @Override
    public Profile getProfileById(int id) {
        String query = "SELECT * FROM profiles WHERE idProfile = "+id;
        return getProfiles(query).get(0);
    }

    ProfileMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public void setOrder(Profile.sortParameter s) {
        sortParameter = s.toString();
    }

    @Override
    public List<Profile> getAllProfiles() {
        String query = "SELECT * FROM profiles p";
        return getProfiles(query);
    }

    @Override
    public boolean insertProfile(Profile profile) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO profiles SET name = '"+profile.getName()+"'";
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
    public boolean updateProfile(Profile profile) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE profiles SET name = '"+profile.getName()+"' WHERE idProfile = "+profile.getIdProfile();
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
    public boolean deleteProfile(Profile profile) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM profiles WHERE idProfile = "+profile.getIdProfile();
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

    private List<Profile> getProfiles(String query) {
        List<Profile> profileList = new ArrayList<Profile>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Profile profile = new Profile();
                profile.setIdProfile(rs.getInt("idProfile"));
                profile.setName(rs.getString("name"));
                profileList.add(profile);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return profileList;
    }
}
