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
        return getDepartmentsByVisible(-1);
    }

    @Override
    public List<Department> getDepartmentByVisible(boolean visible) {
        return getDepartmentsByVisible(visible? 1 : 0);
    }

    @Override
    public Department getDepartmentById(int id) {
        String query = "SELECT * FROM departments WHERE idDepartment = " + id;
        return getDepartments(query).get(0);
    }

    @Override
    public boolean isUniqueNames(String name, String shortName) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.prepareStatement("SELECT * FROM departments d WHERE name = \""+name+"\" OR d.shortName = \""+shortName+"\"");
            rs = statement.executeQuery();
            int i = 0;
            while(rs.next())
                i++;
            return i<1;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public boolean insertDepartment(Department department) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO departments SET name = '"+department.getName()+"',"
                + " shortName = '"+department.getShortName()+"', visible = " + (department.isVisible() ? 1 : 0);
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
    public boolean updateDepartment(Department department) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE departments SET name = '"+department.getName()+"',"
                + " shortName = '"+department.getShortName()+"', visible = " + (department.isVisible() ? 1 : 0)
                + " WHERE idDepartment = " + department.getIdDepartment();
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
    public boolean deleteDepartment(Department department) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM departments WHERE idDepartment = "+department.getIdDepartment();
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

    private List<Department> getDepartmentsByVisible(int visible) {
        String query = "SELECT * FROM departments";
        if(visible != -1)
            query += " WHERE visible = "+visible;
        query += " ORDER BY "+sortParameter;
        return getDepartments(query);
    }

    private List<Department> getDepartments(String query) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        List<Department> depList = new ArrayList<Department>();
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Department department = new Department();
                department.setIdDepartment(rs.getInt("idDepartment"));
                department.setName(rs.getString("name"));
                department.setShortName(rs.getString("shortName"));
                department.setVisible(rs.getInt("visible") == 1);
                depList.add(department);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return depList;
    }

    public static void main(String[] args){
        try {
            DepartmentMariaDb u = new DepartmentMariaDb(ConnectionPool.getConnection());
            u.setOrder(Department.sortParameter.idDepartment);
            /*List<Department> deps = u.getAllDepartments();
            for(Department el : deps)
                System.out.println(el.toString());*/
            System.out.println(u.getDepartmentById(2).getShortName());

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
