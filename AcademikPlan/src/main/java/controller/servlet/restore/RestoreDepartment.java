package controller.servlet.restore;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DepartmentMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.UserMariaDb;
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

@WebServlet("/restoreDepartment")
public class RestoreDepartment extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idDepartmentRestore"));
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            DepartmentMariaDb depDao = fb.getDepartmentMariaDB(connection);
            Department department = depDao.getDepartmentById(id);
            department.setVisible(true);
            depDao.updateDepartment(department);
            HttpSession session = req.getSession();
            session.setAttribute("message", "Кафедра успешно восстановлена");
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
