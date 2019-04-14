package controller.servlet;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.RoleMariaDb;
import data.dao.mariaDB.UserMariaDb;
import data.model.Department;
import data.model.Role;
import data.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/plans/admin/user-managment")
public class UserManagment extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            FactoryMariaDb factory = new FactoryMariaDb();
            UserMariaDb userDao = factory.getUserMariaDB(connection);
            DepartmentMariaDb depDao = factory.getDepartmentMariaDB(connection);
            RoleMariaDb roleDao = factory.getRoleMariaDB(connection);
            List<Department> depList = depDao.getAllDepartments();
            List<Role> roleList = roleDao.getAllRoles();
            List<User> userList = new ArrayList<User>();
            for(Department d : depList){
                if(d.isVisible())
                    userList.addAll(userDao.getUsersByDepartment(d.getIdDepartment(), true));
            }
            req.setAttribute("userList", userList);
            req.setAttribute("depList", depList);
            req.setAttribute("roleList", roleList);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if(connection != null)
                    connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        req.getRequestDispatcher("/user-managment.jsp").forward(req, resp);
    }
}
