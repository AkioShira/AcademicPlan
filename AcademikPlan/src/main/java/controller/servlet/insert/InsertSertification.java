package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.PractMariaDb;
import data.dao.mariaDB.StateSertificationMariaDb;
import data.model.Pract;
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
import java.util.Arrays;
import java.util.Collections;

@WebServlet("/insertSertification")
public class InsertSertification extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("sertificationInsert"));
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            StateSertificationMariaDb stateDao = fb.getStateSertificationMariaDb(connection);
            StateSertification state = new StateSertification();
            state.setIdTitle((int) session.getAttribute("idTitle"));
            state.setIdSertificationType(id);
            state.setSemester(0);
            if(!stateDao.insertSertifications(Collections.singletonList(state)))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Аттестация успешно добавлена");
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
