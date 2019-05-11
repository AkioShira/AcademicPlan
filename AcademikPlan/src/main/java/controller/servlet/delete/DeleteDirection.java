package controller.servlet.delete;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.DirectionMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.model.Direction;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/deleteDirection")
public class DeleteDirection extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idDirectionDelete"));
        Connection connection = null;
        HttpSession session = req.getSession();
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            DirectionMariaDb directionDao = fb.getDirectionMariaDb(connection);
            Direction direction = directionDao.getDirectionById(id);
            if(!directionDao.deleteDirection(direction))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Направление удалено");
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
