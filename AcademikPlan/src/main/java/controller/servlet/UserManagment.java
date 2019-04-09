package controller.servlet;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.UserMariaDb;
import data.model.Department;
import data.model.User;
import sun.security.smartcardio.SunPCSC;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/plans/admin/user-managment")
public class UserManagment extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            //Users
            FactoryMariaDb factory = new FactoryMariaDb();
            UserMariaDb userDao = factory.getUserDao(connection);
            userDao.setOrder(User.sortParameter.idDepartment);
            List<User> userList = userDao.getAllUser();
            req.setAttribute("userList", userList);
            //Departments
            DepartmentMariaDb depDao = factory.getDepartmentMariaDB(connection);
            depDao.setOrder(Department.sortParameter.idDepartment);
            List<Department> depList = depDao.getAllDepartments();
            req.setAttribute("depList", depList);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
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
