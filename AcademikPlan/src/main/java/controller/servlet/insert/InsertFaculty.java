package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.FacultyMariaDb;
import data.model.Faculty;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/insertFaculty")
public class InsertFaculty extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String name = req.getParameter("nameInsert");
        //Проверка на размер вводимых данных
        String shortName = req.getParameter("shortNameInsert");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            FacultyMariaDb facDao = fb.getFacultyMariaDB(connection);
            if(!facDao.isUniqueName(name) || !facDao.isUniqueShortName(shortName)){
                session.setAttribute("erMessage", "Такое имя факультета или сокращение уже существует!");
                resp.sendRedirect("/plans/admin/faculty-managment");
                return;
            }
            Faculty fac = new Faculty();
            fac.setName(name);
            fac.setShortName(shortName);
            fac.setVisible(true);

            if(!facDao.insertFaculty(fac))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Факультет удачно добавлен");
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
        resp.sendRedirect("/plans/admin/faculty-managment");

    }
}
