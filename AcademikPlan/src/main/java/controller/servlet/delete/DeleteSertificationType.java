package controller.servlet.delete;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.PractTypesMariaDb;
import data.dao.mariaDB.SertificationTypesMariaDb;
import data.model.PractType;
import data.model.SertificationType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/deleteSertificationType")
public class DeleteSertificationType extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idSertificationDelete"));
        Connection connection = null;
        HttpSession session = req.getSession();
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            SertificationTypesMariaDb practDao = fb.getSertificationTypesMariaDb(connection);
            SertificationType sertType = practDao.getSertificationTypeById(id);
            if(!practDao.deleteSertificationType(sertType))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Вид аттестации удалён");
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
        resp.sendRedirect("/plans/admin/sertification-managment");
    }
}
