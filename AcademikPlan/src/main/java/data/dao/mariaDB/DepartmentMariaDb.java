package data.dao.mariaDB;

import connection.pooling.ConnectionPool;
import data.ConnectionService;
import data.dao.DepartmentsDao;
import data.model.Department;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepartmentMariaDb extends ConnectionService implements DepartmentsDao  {
    private Connection connection;
    private String sortParameter = "idDepartment";

    DepartmentMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public void setOrder(Department.sortParameter s) {
        sortParameter = s.toString();
    }

    @Override
    public List<Department> getAllDepartments() {
        PreparedStatement statement = null;
        ResultSet rs = null;
        List<Department> depList = new ArrayList<Department>();
        try{
            statement = connection.prepareStatement("SELECT * FROM departments ORDER BY "+sortParameter);
            rs = statement.executeQuery();
            while(rs.next()){
                Department department = new Department();
                department.setIdDepartment(rs.getInt("idDepartment"));
                department.setName(rs.getString("name"));
                department.setShortName(rs.getString("shortName"));
                department.setVisible(rs.getInt("visible")==1);
                depList.add(department);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return depList;
    }

    @Override
    public Department getDepartmentById(String id) {
        return null;
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
            DepartmentMariaDb u = new DepartmentMariaDb(ConnectionPool.getConnection());
            u.setOrder(Department.sortParameter.idDepartment);
            List<Department> deps = u.getAllDepartments();
            for(Department el : deps)
                System.out.println(el.toString());

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
