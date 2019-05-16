package controller.servlet.update;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.*;
import data.model.Pract;
import data.model.StateSertification;
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

        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
            Title title = titleDao.getTitleById(id);
            int maxStudyTime = title.getStudyTime();
            title.setYearCreation(yearCreation);
            title.setFormEducation(formEducation);
            title.setYearReception(yearReception);
            title.setQualification(qualification);
            title.setStudyTime(studyTime);
            title.setStudyLevel(studyLevel);
            title.setIdGroupDirection(groupDirection);
            title.setIdDirection(direction);
            title.setIdProfile(profile);

            StudyShedulesMariaDb sheduleDao = fb.getStudySheduleMariaDb(connection);

            //Обновить график учебного процесса
            for(int i = 1; i<=maxStudyTime; i++){
                List<StudyShedule> sheduleList = sheduleDao.getSheduleByTitleCourse(id, i);
                String[] shedule = req.getParameterValues("shedule"+i);
                for(int j=0; j<sheduleList.size(); j++) {
                    sheduleList.get(j).setLabel(shedule[j].trim());
                }
                sheduleDao.updateShedules(sheduleList);
            }
            //Обновить таблицу практики
            PractMariaDb practDao = fb.getPractMariaDb(connection);

            List<Pract> practs = practDao.getPractsByTitle(id);
            for(int i = 1; i<=practs.size(); i++){
                int idPract = 1;
                try {
                    idPract = Integer.parseInt(req.getParameter("practType"+i));
                }catch (NumberFormatException e){     }

                practs.get(i-1).setIdPractType(idPract);
                String[] pract = req.getParameterValues("pract"+i);
                practs.get(i-1).setSemester(Integer.parseInt(pract[0]));
                practs.get(i-1).setWeek(Integer.parseInt(pract[1]));
            }
            practDao.updatePracts(practs);

            //Обновить таблицу гос аттестаций
            StateSertificationMariaDb stateDao = fb.getStateSertificationMariaDb(connection);
            List<StateSertification> statelist = stateDao.getSertificationsByTitle(id);
            String[] state = req.getParameterValues("state");

            statelist.get(0).setSemester(Integer.parseInt(state[0]));
            statelist.get(1).setSemester(Integer.parseInt(state[1]));
            stateDao.updateSertifications(statelist);

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
