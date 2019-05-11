package controller.servlet.update;

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

@WebServlet("/updateFaculty")
public class UpdateFaculty extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idFacUpdate"));
        String name = req.getParameter("nameUpdate");
        String shortName = req.getParameter("shortNameUpdate");
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            FacultyMariaDb facDao = fb.getFacultyMariaDB(connection);

            if(!facDao.isUniqueName(name) && !name.equals(facDao.getFacultyById(id).getName())){
                session.setAttribute("erMessage", "Такое имя факультета уже существует!");
                resp.sendRedirect("/plans/admin/faculty-managment");
                return;
            }
            if(!facDao.isUniqueShortName(shortName) && !shortName.equals(facDao.getFacultyById(id).getShortName())){
                session.setAttribute("erMessage", "Такое сокращение уже существует!");
                resp.sendRedirect("/plans/admin/faculty-managment");
                return;
            }

            Faculty faculty = facDao.getFacultyById(id);
            faculty.setName(name);
            faculty.setShortName(shortName);
            if(!facDao.updateFaculty(faculty))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Факультет успешно редактирован");
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
