package controller.servlet.insert;

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
import java.util.Collections;

@WebServlet("/insertCycle")
public class InsertCycle extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String shortName = req.getParameter("shortNameCycleInsert");
        String name = req.getParameter("nameCycleInsert");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            CycleMariaDb cycleDao = fb.getCycleMariaDb(connection);
            Cycle cycle = new Cycle();
            cycle.setIdTitle((int) session.getAttribute("idTitle"));
            cycle.setName(name);
            cycle.setShortName(shortName);
            if(!cycleDao.insertCycle(cycle))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Цикл успешно добавлен");
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
