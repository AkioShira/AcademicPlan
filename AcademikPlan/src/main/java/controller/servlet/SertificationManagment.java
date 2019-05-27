package controller.servlet;

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
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/plans/admin/sertification-managment")
public class SertificationManagment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            FactoryMariaDb factory = new FactoryMariaDb();
            SertificationTypesMariaDb stateDao = factory.getSertificationTypesMariaDb(connection);
            List<SertificationType> stateList = stateDao.getAllSertificationTypes();
            stateList.remove(0);
            req.setAttribute("stateList", stateList);
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
        req.getRequestDispatcher("/sertification-managment.jsp").forward(req, resp);
    }
}

