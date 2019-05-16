package controller.servlet;


import connection.pooling.ConnectionPool;
import controller.xml.editor.XmlEditor;
import data.dao.mariaDB.*;
import data.model.*;

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
import java.util.HashMap;
import java.util.List;


@WebServlet("/title")
public class TitlePage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int id;
        try {
            id = Integer.parseInt(req.getParameter("idTitle"));
            session.setAttribute("idTitle", id);
        }catch (Exception e){
            id = (int) session.getAttribute("idTitle");
        }

        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
            Title title = titleDao.getTitleById(id);
            DirectionMariaDb directionDao = fb.getDirectionMariaDb(connection);
            List<Direction> directionList = directionDao.getAllDirections();
            GroupDirectionMariaDb groupDirectionDao = fb.getGroupDirectionMariaDb(connection);
            List<GroupDirection> groupDirectionList = groupDirectionDao.getAllDirections();
            ProfileMariaDb profileDao = fb.getProfileMariaDb(connection);
            List<Profile> profileList = profileDao.getAllProfiles();

            HashMap<Integer, String> directionMap = new HashMap<Integer, String>();
            for(Direction d : directionList)
                directionMap.put(d.getIdDirection(), d.getNumber()+ " " + d.getName());

            HashMap<Integer, String> groupDirectionMap = new HashMap<Integer, String>();
            for(GroupDirection g : groupDirectionList)
                groupDirectionMap.put(g.getIdGroupDirection(), g.getNumber()+ " " + g.getName());

            HashMap<Integer, String> profileMap = new HashMap<Integer, String>();
            for(Profile p : profileList)
                profileMap.put(p.getIdProfile(), p.getName());


            XmlEditor xmlEditor = new XmlEditor(getServletContext().getRealPath("resources/servlet-text.xml"));
            List<NodePage> titleContent = xmlEditor.getArrayXml("content");
            List<NodePage> titleShedules = xmlEditor.getArrayXml("month");
            List<NodePage> titleBudget = xmlEditor.getArrayXml("budget");
            List<NodePage> titleState = xmlEditor.getArrayXml("headState");
            List<NodePage> titlePractics = xmlEditor.getArrayXml("headPractics");

            groupDirectionList.remove(0);
            directionList.remove(0);
            profileList.remove(0);

            if(title.getFormEducation().equals("null"))
                title.setFormEducation("");

            req.setAttribute("groupDirectionList", groupDirectionList);
            req.setAttribute("directionList", directionList);
            req.setAttribute("profileList", profileList);

            req.setAttribute("titleContent", titleContent);
            req.setAttribute("titleShedules", titleShedules);
            req.setAttribute("titleBudget", titleBudget);
            req.setAttribute("titlePractics", titlePractics);
            req.setAttribute("titleState", titleState);
            req.setAttribute("idTitle", id);
            req.setAttribute("title", title);

            //Создать график учебного процесса если он не создан
            StudyShedulesMariaDb sheduleDao = fb.getStudySheduleMariaDb(connection);
            setShedule(sheduleDao, id, title);

            //Статические поля для графика учебного процесса
            int[] row0 = {29,5,12,19,26,3,10,17,24,31,7,14,21,28,5,12,19,26,2,9,16,23,30,
                    6,13,20,27,6,13,20,27,3,10,17,24,1,8,15,22,29,5,12,19,26,3,10,17,24,31,7,14,21};
            int[] row1 = {4,11,18,25,2,9,16,23,30,6,13,20,27,4,11,18,25,1,8,15,22,29,5,12,19,26,5,12,
                    19,26,2,9,16,23,30,7,14,21,28,4,11,18,25,2,9,16,23,30,6,13,20,27};
            String[] courses = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"};

            List<List<StudyShedule>> sheduleList = new ArrayList<>();
            for(int i=1; i<=title.getStudyTime(); i++)
                sheduleList.add(sheduleDao.getSheduleByTitleCourse(id, i));

            //Заполнение бюджетов времени
            List<Budget> budgets = sheduleDao.getBudgetByTitle(id, title.getStudyTime());

            //Заполнение практик
            PractMariaDb practDao = fb.getPractMariaDb(connection);
            List<Pract> practList = practDao.getPractsByTitle(id);

            PractTypesMariaDb typesDao = fb.getPractTypesMariaDb(connection);
            List<PractType> practTypes = typesDao.getAllPractTypes();

            //
            HashMap<Integer, String> typeMap = new HashMap<Integer, String>();
            for(PractType t : practTypes)
                typeMap.put(t.getIdPractType(), t.getName());

            if(practList.size()<1){
                Pract pract = new Pract();
                pract.setIdTitle(id);
                pract.setIdPractType(1);
                pract.setSemester(0);
                pract.setWeek(0);
                practList.add(pract);
                practDao.insertPracts(practList);
            }

            //Заполнение гос аттестаций
            StateSertificationMariaDb stateDao = fb.getStateSertificationMariaDb(connection);
            List<StateSertification> listState = stateDao.getSertificationsByTitle(id);
            if(listState.size()<1){
                for(int i=0; i<2; i++){
                    StateSertification state = new StateSertification();
                    state.setIdTitle(id);
                    state.setSemester(0);
                    listState.add(state);
                }
                stateDao.insertSertifications(listState);
            }
            practTypes.remove(0);
            req.setAttribute("row0", row0);
            req.setAttribute("row1", row1);
            req.setAttribute("courses", courses);
            req.setAttribute("sheduleList", sheduleList);
            req.setAttribute("budgets", budgets);
            req.setAttribute("practList", practList);
            req.setAttribute("practTypes", practTypes);
            req.setAttribute("typeMap", typeMap);
            req.setAttribute("stateList", listState);
        }catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if(connection != null)
                    connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        req.getRequestDispatcher("/title.jsp").forward(req, resp);
    }

    private void setShedule(StudyShedulesMariaDb sheduleDao, int id, Title title){

        int maxCourse = sheduleDao.getMaxCourseByTitle(id);
        if(maxCourse<title.getStudyTime()){
            List<StudyShedule> sheduleList = new ArrayList<>();
            for(int j = maxCourse+1; j<=title.getStudyTime(); j++) {
                for (int i = 1; i <=52; i++) {
                    StudyShedule shedule = new StudyShedule();
                    shedule.setIdTitle(id);
                    shedule.setCourse(j);
                    shedule.setWeek(i);
                    shedule.setLabel("");
                    sheduleList.add(shedule);
                }
            }
            sheduleDao.insertShedules(sheduleList);
        }


    }
}
