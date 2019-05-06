package controller.servlet;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.FacultyMariaDb;
import data.model.Department;
import data.model.Faculty;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

@WebServlet("/plans/admin/department-managment")
public class DepartmentManagment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            FactoryMariaDb factory = new FactoryMariaDb();
            DepartmentMariaDb depDao = factory.getDepartmentMariaDB(connection);
            FacultyMariaDb facDao = factory.getFacultyMariaDB(connection);
            List<Department> depListVisible = depDao.getDepartmentByVisibleFaculty(true, true);
            List<Department> depListUnvisible = depDao.getDepartmentByVisibleFaculty(true, false);
            List<Faculty> facList = facDao.getFacultyByVisible(true);
            HashMap<Integer, String> facMap = new HashMap<>();
            facList.remove(0);
            for(Faculty f : facList)
                facMap.put(f.getIdFaculty(), f.getShortName());
            req.setAttribute("depListVisible", depListVisible);
            req.setAttribute("depListUnvisible", depListUnvisible);
            req.setAttribute("facMap", facMap);
            req.setAttribute("facList", facList);
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
        req.getRequestDispatcher("/department-managment.jsp").forward(req, resp);
    }
}
