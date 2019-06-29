package controller.servlet.update;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.PractTypesMariaDb;
import data.model.PractType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Name: Шишко А.А.
 * Date: 01.06.2019
 */
@WebServlet("/updatePractType")
public class UpdatePractType extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idPracticUpdate"));
        String name = req.getParameter("nameUpdate");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            PractTypesMariaDb practDao = fb.getPractTypesMariaDb(connection);
            PractType practType = practDao.getPractTypeById(id);
            practType.setName(name);
            if(!practDao.updatePractType(practType))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Вид практики успешно редактирован");
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
        resp.sendRedirect("/plans/admin/practic-managment");
    }
}
