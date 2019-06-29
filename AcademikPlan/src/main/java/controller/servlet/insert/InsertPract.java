package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.PractMariaDb;
import data.dao.mariaDB.ProfileMariaDb;
import data.model.Pract;
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
import java.util.Arrays;

@WebServlet("/insertPract")
public class InsertPract extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("practInsert"));
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            PractMariaDb practDao = fb.getPractMariaDb(connection);
            Pract pract = new Pract();
            pract.setIdTitle((int) session.getAttribute("idTitle"));
            pract.setIdPractType(id);
            pract.setSemester(0);
            pract.setWeek(0);
            if(!practDao.insertPracts(Arrays.asList(pract)))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Практика успешно добавлена");
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
