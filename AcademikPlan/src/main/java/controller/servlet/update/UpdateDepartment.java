package controller.servlet.update;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.model.Department;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/updateDepartment")
public class UpdateDepartment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idDapUpdate"));
        String name = req.getParameter("nameUpdate");
        String shortName = req.getParameter("shortNameUpdate");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            DepartmentMariaDb depDao = fb.getDepartmentMariaDB(connection);
            if(!depDao.isUniqueNames(name, shortName) && (!name.equals(depDao.getDepartmentById(id).getName())
                    || !shortName.equals(depDao.getDepartmentById(id).getShortName()))){
                session.setAttribute("erMessage", "Такое имя кафедры или сокращение уже существует!");
                resp.sendRedirect("/plans/admin/department-managment");
                return;
            }
            Department department = depDao.getDepartmentById(id);
            department.setName(name);
            department.setShortName(shortName);
            depDao.updateDepartment(department);

            session.setAttribute("message", "Кафедра успешно редактирована");
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
        resp.sendRedirect("/plans/admin/department-managment");
    }
}
