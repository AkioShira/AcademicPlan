package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.*;
import data.model.Direction;
import data.model.Name;
import data.model.StudyShedule;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/insertTitle")
public class InsertTitle extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String name = req.getParameter("nameInsert");
        int yearCreation = Integer.parseInt(req.getParameter("yearCreationInsert"));
        String qualification = req.getParameter("qualificationInsert");
        int idGroupDirection = Integer.parseInt(req.getParameter("groupDirectionInsert"));
        int idDirection = Integer.parseInt(req.getParameter("directionInsert"));
        int idProfile = Integer.parseInt(req.getParameter("profileInsert"));
        int idDepartment = Integer.parseInt(req.getParameter("departmentInsert"));
        int idPlan = Integer.parseInt(req.getParameter("planInsert"));
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
            Title title = new Title();
            title.setName(name);
            title.setYearCreation(yearCreation);
            title.setQualification(qualification);
            if(idPlan == 1)
                title.setStudyTime(4);
            else if(idPlan == 2)
                title.setStudyTime(2);
            else title.setStudyTime(1);

            if(idPlan == 1)
                title.setStudyLevel("Бакалавриат");
            else if(idPlan == 2)
                title.setStudyLevel("Магистратура");
            else title.setStudyLevel("Специалитет");
            title.setIdPlan(idPlan);
            title.setIdGroupDirection(idGroupDirection);
            title.setIdDirection(idDirection);
            title.setIdProfile(idProfile);
            title.setIdDepartment(idDepartment);
            title.setVisible(true);

            if(!titleDao.insertTitle(title)) {
                session.setAttribute("erMessage", "Не удалось провести операцию");
                throw new SQLException();
            }else session.setAttribute("message", "Титул успешно добавлен");



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
