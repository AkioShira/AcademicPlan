package controller.servlet.update;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.ProfileMariaDb;
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

@WebServlet("/updateProfile")
public class UpdateProfile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idProfileUpdate"));
        String name = req.getParameter("nameUpdate");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            ProfileMariaDb profileDao = fb.getProfileMariaDb(connection);
            Profile profile = profileDao.getProfileById(id);
            profile.setName(name);
            if(!profileDao.updateProfile(profile))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Профиль успешно редактирован");
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
        resp.sendRedirect("/plans/admin/profile-managment");
    }
}
