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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/restoreAllDepartments")
public class RestoreAllDepartments extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            FactoryMariaDb factory = new FactoryMariaDb();
            DepartmentMariaDb depDao = factory.getDepartmentMariaDB(connection);
            List<Department> depList = depDao.getDepartmentByVisible(false);
            for(Department dep : depList){
                dep.setVisible(true);
                depDao.updateDepartment(dep);
            }
            HttpSession session = req.getSession();
            session.setAttribute("message", "Все кафедры успешно восстановлены");
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
