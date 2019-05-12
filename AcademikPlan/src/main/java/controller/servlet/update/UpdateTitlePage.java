package controller.servlet.update;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.TitleMariaDb;
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

@WebServlet("/updateTitlePage")
public class UpdateTitlePage extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idTitle"));
        int yearReception = Integer.parseInt(req.getParameter("yearReception"));
        int yearCreation = Integer.parseInt(req.getParameter("yearCreation"));
        String qualification = req.getParameter("qualification");
        int studyTime = Integer.parseInt(req.getParameter("studyTime"));
        String studyLevel = req.getParameter("studyLevel");
        String formEducation = req.getParameter("formEducation");
        int groupDirection = Integer.parseInt(req.getParameter("groupDirection"));
        int direction = Integer.parseInt(req.getParameter("direction"));
        int profile = Integer.parseInt(req.getParameter("profile"));

        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
            Title title = titleDao.getTitleById(id);
            title.setYearCreation(yearCreation);
            title.setFormEducation(formEducation);
            title.setYearReception(yearReception);
            title.setQualification(qualification);
            title.setStudyTime(studyTime);
            title.setStudyLevel(studyLevel);
            System.out.println(groupDirection);
            title.setIdGroupDirection(groupDirection);
            title.setIdDirection(direction);
            title.setIdProfile(profile);
            if(!titleDao.updateTitle(title))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "План успешно редактирован");
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
