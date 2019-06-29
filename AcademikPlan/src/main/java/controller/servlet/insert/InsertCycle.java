package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.*;
import data.model.Cycle;
import data.model.StateSertification;
import data.model.Title;

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
        int id = (int) session.getAttribute("idTitle");
        String name = req.getParameter("nameCycleInsert");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            CycleMariaDb cycleDao = fb.getCycleMariaDb(connection);
            Cycle cycle = new Cycle();
            cycle.setIdTitle((int) session.getAttribute("idTitle"));
            cycle.setName(name);

            String shortName;
            TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
            Title title = titleDao.getTitleById(id);
            if(title.getIdPlan()==1)
                shortName = "Б";
            else if(title.getIdPlan()==2)
                shortName = "М";
            else shortName = "C";
            cycle.setShortName(shortName+(cycleDao.getCountCycleByTitle(id)+1));
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
