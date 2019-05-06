package controller.servlet;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.FacultyMariaDb;
import data.model.Department;
import data.model.Faculty;
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
import java.util.List;

@WebServlet("/plans")
public class Plans extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            FactoryMariaDb factory = new FactoryMariaDb();
            FacultyMariaDb facDao = factory.getFacultyMariaDB(connection);
            DepartmentMariaDb depDao = factory.getDepartmentMariaDB(connection);
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("sessionUser");
            Department dep = depDao.getDepartmentById(user.getIdDepartment());
            Faculty fac = facDao.getFacultyById(dep.getIdFaculty());
            List<Faculty> facList = facDao.getFacultyByVisible(true);
            List<Department> depList = depDao.getDepartmentByVisible(true);
            depList.remove(0);
            facList.remove(0);
            req.setAttribute("facList", facList);
            req.setAttribute("depList", depList);
            req.setAttribute("departmentUser", dep);
            req.setAttribute("facultyUser", fac);
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
        req.getRequestDispatcher("/plans.jsp").forward(req, resp);
    }
}
