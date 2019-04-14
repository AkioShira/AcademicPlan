package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.RoleDao;
import data.model.Role;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class  RoleMariaDb extends ConnectionService implements RoleDao {
    private Connection connection;
    private String sortParameter = "idRole";

    RoleMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public void setOrder(Role.sortParameter s) {
        this.sortParameter = s.toString();
    }

    @Override
    public Role getRoleById(int id) {
        String query = "SELECT * FROM roles WHERE idRole = " + id;
        return getRoles(query).get(0);
    }

    @Override
    public List<Role> getAllRoles() {
        String query = "SELECT * FROM roles ORDER BY "+ sortParameter;
        return getRoles(query);
    }


    private List<Role> getRoles(String query) {
        List<Role> roleList = new ArrayList<Role>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Role role = new Role();
                role.setIdRole(rs.getInt("idRole"));
                role.setName(rs.getString("name"));
                roleList.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return roleList;
    }
}
