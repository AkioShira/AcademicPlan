package controller.servlet.clear;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.UserMariaDb;
import data.model.Department;
import data.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/clearAllUsers")
public class ClearAllUsers extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        HttpSession session = req.getSession();
        try {
            connection = ConnectionPool.getConnection();
            FactoryMariaDb factory = new FactoryMariaDb();
            DepartmentMariaDb depDao = factory.getDepartmentMariaDB(connection);
            List<Department> depList = depDao.getDepartmentByVisibleFaculty(true, true);
            List<User> userListUnvisible = new ArrayList<>();
            UserMariaDb userDao = factory.getUserMariaDB(connection);
            //Собрать пользователей из не удалённых кафедр
            for(Department d : depList){
                userListUnvisible.addAll(userDao.getUsersByDepartment(d.getIdDepartment(), false));
            }
            for(User user : userListUnvisible) {
                userDao.deleteUser(user);
            }

            session.setAttribute("message", "Список удалённых пользователей очищен");
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
        resp.sendRedirect("/plans/admin/user-managment");
    }
}
