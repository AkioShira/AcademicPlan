package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.PractTypesMariaDb;
import data.dao.mariaDB.ProfileMariaDb;
import data.model.PractType;
import data.model.Profile;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/insertPractType")
public class InsertPractType extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String name = req.getParameter("nameInsert");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            PractTypesMariaDb practDao = fb.getPractTypesMariaDb(connection);
            PractType practType = new PractType();
            practType.setName(name);
            practType.setName(name);
            if(!practDao.insertPractType(practType))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Вид практики успешно добавлен");
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
        resp.sendRedirect("/plans/admin/practic-managment");

    }
}
