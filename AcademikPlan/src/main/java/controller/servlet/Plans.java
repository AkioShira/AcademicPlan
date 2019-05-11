package controller.servlet;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.FacultyMariaDb;
import data.dao.mariaDB.TitleMariaDb;
import data.model.Department;
import data.model.Faculty;
import data.model.Title;
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
            TitleMariaDb titleDao = factory.getTitleMariaDb(connection);
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("sessionUser");
            Department dep = depDao.getDepartmentById(user.getIdDepartment());
            Faculty fac = facDao.getFacultyById(dep.getIdFaculty());
            if(user.getIdDepartment()==1) {
                List<Faculty> facList = facDao.getFacultyByVisible(true);
                List<Department> depList = depDao.getDepartmentByVisibleFaculty(true, true);

                List<Title> titleList = new ArrayList<>();
                for (Department d : depList) {
                    titleList.addAll(titleDao.getTitlesByDepartment(d.getIdDepartment(), true));
                }
                depList.remove(0);
                facList.remove(0);
                req.setAttribute("facList", facList);
                req.setAttribute("depList", depList);
                req.setAttribute("titleList", titleList);
            }else {
                List<Title> userTitleList = new ArrayList<>();
                userTitleList.addAll(titleDao.getTitlesByDepartment(dep.getIdDepartment(), true));
                req.setAttribute("userTitleList", userTitleList);
            }
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
