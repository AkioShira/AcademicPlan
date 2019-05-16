package controller.servlet.update;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.TitleMariaDb;
import data.dao.mariaDB.UserMariaDb;
import data.model.Title;
import data.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/updateTitle")
public class UpdateTitle extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idTitleUpdate"));
        String name = req.getParameter("nameUpdate");
        int yearCreation = Integer.parseInt(req.getParameter("yearCreationUpdate"));
        String qualification = req.getParameter("qualificationUpdate");
        int studyTime = Integer.parseInt(req.getParameter("studyTimeUpdate"));
        String studyLevel = req.getParameter("studyLevelUpdate");
        int groupDirection = 1;
        int direction = 1;
        int profile = 1;
        try {
            groupDirection = Integer.parseInt(req.getParameter("groupDirection"));
        }catch (NumberFormatException e){        }
        try {
            direction = Integer.parseInt(req.getParameter("direction"));
        }catch (NumberFormatException e){       }
        try {
            profile = Integer.parseInt(req.getParameter("profile"));
        }catch (NumberFormatException e){     }
        int department = Integer.parseInt(req.getParameter("departmentUpdate"));

        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
            Title title = titleDao.getTitleById(id);
            title.setName(name);
            title.setYearCreation(yearCreation);
            title.setIdDepartment(department);
            title.setQualification(qualification);
            title.setStudyTime(studyTime);
            title.setStudyLevel(studyLevel);
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
        resp.sendRedirect("/plans/title-managment");
    }
}
