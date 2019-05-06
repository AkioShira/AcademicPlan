package controller.servlet.restore;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.FacultyMariaDb;
import data.model.Faculty;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/restoreAllFaculties")
public class RestoreAllFaculties extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            FactoryMariaDb factory = new FactoryMariaDb();
            FacultyMariaDb facDao = factory.getFacultyMariaDB(connection);
            List<Faculty> facList = facDao.getFacultyByVisible(false);
            for(Faculty fac : facList){
                fac.setVisible(true);
                facDao.updateFaculty(fac);
            }
            HttpSession session = req.getSession();
            session.setAttribute("message", "Все факультеты успешно восстановлены");
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
        resp.sendRedirect("/plans/admin/faculty-managment");
    }
}
