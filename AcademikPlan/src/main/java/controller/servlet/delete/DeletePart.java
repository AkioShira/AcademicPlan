package controller.servlet.delete;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.CycleMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.PartMariaDb;
import data.model.Cycle;
import data.model.Part;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/deletePart")
public class DeletePart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idPartDelete"));
        Connection connection = null;
        HttpSession session = req.getSession();
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            PartMariaDb partDao = fb.getPartMariaDb(connection);
            Part part = partDao.getPartById(id);
            if(!partDao.deletePart(part))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Часть удалена");
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
        resp.sendRedirect("/cycle");
    }
}
