package data.dao.mariaDB;

import data.dao.UserDAO;
import data.model.User;

import java.sql.*;
import static java.util.Objects.nonNull;

public class UserMariaDB implements UserDAO {
    private Connection connection;

    public UserMariaDB(Connection connection){
        this.connection = connection;
    }

    public User getUser() {
        return null;
    }

    public int getRoleByLoginPassword(String login, String password) {
        Statement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT role FROM users WHERE login = \""+login+"\" AND password = \""+password+"\"");
            rs.next();
            int result = rs.getInt(1);
            if(nonNull(result))
                return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return 0;
    }

    public boolean isExist(String login, String password) {
        Statement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT EXISTS(SELECT login, password FROM users WHERE login = \""+login+"\" AND password = \""+password+"\")");
            rs.next();
            int result = rs.getInt(1);
            if(result==1)
                return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return false;
    }

    private void closeResurse(Statement statement, ResultSet rs) {
        try {
            if(statement !=null)
                statement.close();
            if(rs !=null)
                rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean insertUser() {
        return false;
    }

    public boolean updateUser() {
        return false;
    }

    public boolean deleteUser() {
        return false;
    }
}
