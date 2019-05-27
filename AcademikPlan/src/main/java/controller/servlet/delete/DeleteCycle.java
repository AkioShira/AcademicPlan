package controller.servlet.delete;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.CycleMariaDb;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.StateSertificationMariaDb;
import data.model.Cycle;
import data.model.StateSertification;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/deleteCycle")
public class DeleteCycle extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idCycleDelete"));
        Connection connection = null;
        HttpSession session = req.getSession();
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            CycleMariaDb cycleDao = fb.getCycleMariaDb(connection);
            Cycle cycle = cycleDao.getCycleById(id);
            if(!cycleDao.deleteCycle(cycle))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Цикл удалён");
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
        resp.sendRedirect("/title");
    }
}
