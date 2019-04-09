package data.dao.mariaDB;

import connection.pooling.ConnectionPool;
import data.ConnectionService;
import data.dao.UserDao;
import data.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static java.util.Objects.nonNull;

public class UserMariaDb extends ConnectionService implements UserDao {
    private Connection connection;
    private String sortParameter = "idUser";

    UserMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public void setOrder(User.sortParameter s) {
        sortParameter = s.toString();
    }

    @Override
    public User getUserById(String pk) {
        return null;
    }

    @Override
    public List<User> getAllUser() {
        PreparedStatement statement = null;
        ResultSet rs = null;
        List<User> userList = new ArrayList<User>();
        try{
            statement = connection.prepareStatement("SELECT * FROM users ORDER BY "+sortParameter);
            rs = statement.executeQuery();
            while(rs.next()){
                User user = new User();
                user.setIdUser(rs.getInt("idUser"));
                user.setLogin(rs.getString("login"));
                user.setPassword(rs.getString("password"));
                user.setIdDepartment(rs.getInt("idDepartment"));
                user.setRole(rs.getInt("role"));
                user.setVisible(rs.getInt("visible") == 1);
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return userList;
    }

    @Override
    public int getRoleByLoginPassword(String login, String password) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.prepareStatement("SELECT role FROM users WHERE login = \""+login+"\" AND password = \""+password+"\"");
            rs = statement.executeQuery();
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

    @Override
    public boolean isExist(String login, String password) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.prepareStatement("SELECT EXISTS(SELECT login, password FROM users WHERE login = \""+login+"\" AND password = \""+password+"\")");
            rs = statement.executeQuery();
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

    @Override
    public boolean insertUser() {
        return false;
    }

    @Override
    public boolean updateUser() {
        return false;
    }

    @Override
    public boolean deleteUser() {
        return false;
    }

    public static void main(String[] args){
        try {
            UserMariaDb u = new UserMariaDb(ConnectionPool.getConnection());
            List<User> users = u.getAllUser();
            for(User el : users)
                System.out.println(el.toString());

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
