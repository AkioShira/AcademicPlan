package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DirectionMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.GroupDirectionMariaDb;
import data.model.Direction;
import data.model.GroupDirection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/insertGroupDirection")
public class InsertGroupDirection extends HttpServlet {
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
            GroupDirectionMariaDb directionDao = fb.getGroupDirectionMariaDb(connection);
            GroupDirection direction = new GroupDirection();
            direction.setName(name);
            direction.setNumber(number);
            directionDao.insertDirection(direction);
            session.setAttribute("message", "Направление успешно добавлено");
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
        resp.sendRedirect("/plans/admin/group-direction-managment");

    }
}
