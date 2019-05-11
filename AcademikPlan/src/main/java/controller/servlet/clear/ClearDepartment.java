package controller.servlet.clear;

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

@WebServlet("/clearDepartment")
public class ClearDepartment extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idDepartmentClear"));
        Connection connection = null;
        HttpSession session = req.getSession();
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            DepartmentMariaDb depDao = fb.getDepartmentMariaDB(connection);
            Department department = depDao.getDepartmentById(id);
            if(!depDao.deleteDepartment(department))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Кафедра полностью удалена");
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
