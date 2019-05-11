package controller.servlet.delete;

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

@WebServlet("/deleteGroupDirection")
public class DeleteGroupDirection extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idDirectionDelete"));
        Connection connection = null;
        HttpSession session = req.getSession();
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            GroupDirectionMariaDb directionDao = fb.getGroupDirectionMariaDb(connection);
            GroupDirection direction = directionDao.getDirectionById(id);
            if(!directionDao.deleteDirection(direction))
                session.setAttribute("message", "Направление удалено");
            else session.setAttribute("erMessage", "Не удалось провести операцию");
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
