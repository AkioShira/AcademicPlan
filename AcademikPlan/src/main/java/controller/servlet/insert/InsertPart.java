package controller.servlet.insert;

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

@WebServlet("/insertPart")
public class InsertPart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String shortName = req.getParameter("shortNamePartInsert");
        String name = req.getParameter("namePartInsert");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            PartMariaDb partDao = fb.getPartMariaDb(connection);
            Part part = new Part();
            part.setIdCycle((int) session.getAttribute("idCycle"));
            part.setShortName(shortName);
            part.setName(name);
            if(!partDao.insertPart(part))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Часть успешно добавлена");
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
