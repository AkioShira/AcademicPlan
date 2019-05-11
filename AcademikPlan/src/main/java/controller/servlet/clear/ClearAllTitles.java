package controller.servlet.clear;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.TitleMariaDb;
import data.model.Department;
import data.model.Title;

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

@WebServlet("/clearAllTitles")
public class ClearAllTitles extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        HttpSession session = req.getSession();
        try {
            connection = ConnectionPool.getConnection();
            FactoryMariaDb factory = new FactoryMariaDb();
            DepartmentMariaDb departmentDao = factory.getDepartmentMariaDB(connection);
            TitleMariaDb titleDao = factory.getTitleMariaDb(connection);
            List<Department> departmentList = departmentDao.getDepartmentByVisibleFaculty(true, true);
            List<Title> titleList = new ArrayList<>();

            for(Department d : departmentList){
                titleList.addAll(titleDao.getTitlesByDepartment(d.getIdDepartment(), false));
            }
            for(Title title :titleList){
                titleDao.deleteTitle(title);
            }

            session.setAttribute("message", "Все планы полностью удалены");
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
        resp.sendRedirect("/plans/title-managment");
    }
}
