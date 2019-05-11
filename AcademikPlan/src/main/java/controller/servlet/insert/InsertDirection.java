package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DirectionMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.ProfileMariaDb;
import data.model.Direction;
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

@WebServlet("/insertDirection")
public class InsertDirection extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String name = req.getParameter("nameInsert");
        String number = req.getParameter("numberInsert");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            DirectionMariaDb directionDao = fb.getDirectionMariaDb(connection);
            Direction direction = new Direction();
            direction.setName(name);
            direction.setNumber(number);

            if(!directionDao.insertDirection(direction))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Направление успешно добавлено");
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
        resp.sendRedirect("/plans/admin/direction-managment");

    }
}
