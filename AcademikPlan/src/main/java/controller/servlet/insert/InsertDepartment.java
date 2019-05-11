package controller.servlet.insert;

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

@WebServlet("/insertDepartment")
public class InsertDepartment extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String name = req.getParameter("nameInsert");
        String shortName = req.getParameter("shortNameInsert");
        int idFaculty = Integer.parseInt(req.getParameter("facultyUserInsert"));
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            DepartmentMariaDb depDao = fb.getDepartmentMariaDB(connection);
            if(!depDao.isUniqueName(name) || !depDao.isUniqueShortName(shortName)){
                session.setAttribute("erMessage", "Такое имя кафедры или сокращение уже существует!");
                resp.sendRedirect("/plans/admin/department-managment");
                return;
            }
            Department department = new Department();
            department.setName(name);
            department.setShortName(shortName);
            department.setIdFaculty(idFaculty);
            department.setVisible(true);

            if(!depDao.insertDepartment(department))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Кафедра успешно добавлена");
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
