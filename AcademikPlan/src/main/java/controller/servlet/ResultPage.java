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
import javax.swing.plaf.nimbus.State;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


@WebServlet("/result")
public class ResultPage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int idCycle;
        int idTitle = (int) session.getAttribute("idTitle");
        String message = "";
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();

            FactoryMariaDb fb = new FactoryMariaDb();
            TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
            Title title = titleDao.getTitleById(idTitle);

            XmlEditor xmlEditor = new XmlEditor(getServletContext().getRealPath("resources/servlet-text.xml"));
            List<NodePage> cycleContent = xmlEditor.getArrayXml("table-hmp");

            //Заполнение циклов
            CycleMariaDb cycleDao = fb.getCycleMariaDb(connection);
            List<Cycle> cycleList = cycleDao.getCyclesByTitle(idTitle);

            SubjectMariaDb subjectDao = fb.getSubjectMariaDb(connection);

            //Физкультура
            PhysicalMariaDb physicalDao = fb.getPhysicalMariaDb(connection);
            List<Physical> physicalList = physicalDao.getPhysicalsByTitle(idTitle);
            List<Double> sumAudPhysical = new ArrayList<>();
            for(Physical p : physicalList){
                double sum = 0;
                for(double d : p.getWeek())
                    sum+=d*18;
                sumAudPhysical.add(sum);
            }

            //Сумма аудиторных часов
            List<Double> sumAudList = subjectDao.getSumAudByTitle(idTitle);
            for(int i = 0; i<sumAudList.size(); i++)
                for(Physical p : physicalList)
                    sumAudList.set(i, sumAudList.get(i)+p.getWeek().get(i));

            //Сумма самостоятельных часов
            List<Double> sumSelfList = subjectDao.getSumSelfByTitle(idTitle);
            //Сумма всего
            List<Double> sumList = new ArrayList<>();
            boolean isMore=false;
            for(int i = 0; i<sumAudList.size(); i++){
                double j = sumAudList.get(i) + sumSelfList.get(i);
                sumList.add(j);
                if(j>54)
                    isMore = true;
            }
            if(isMore)
                message +="Превышен максимальный предел загрузки студента в неделю. ";

            //Количество экзаменов
            List<Double> examList = subjectDao.getCountExamsByTitle(idTitle);
            //Количество зачетов
            List<Double> creditList = subjectDao.getCountCreditsByTitle(idTitle);
            //Количество КП
            List<Double> kpList = subjectDao.getCountKPByTitle(idTitle);
            //Сумма кредитов
            List<Double> sumZeList = subjectDao.getSumCredByTitle(idTitle);
            for(int i = 0; i<sumZeList.size(); i++)
                sumZeList.set(i, sumZeList.get(i)+physicalList.get(0).getWeek().get(i));

            isMore = false;
            for(double d : sumZeList){
                if(d>30)
                    isMore = true;
            }
            if(isMore)
                message +="Превышен предел количества кредитов. ";

            //Сумма БСР
            List<Double> sumBSRList = subjectDao.getSumBSRByTitle(idTitle);

            PartMariaDb partDao = fb.getPartMariaDb(connection);
            List<Part> partList = partDao.getPartesByTitle(idTitle);
            //Сумма частей
            List<List<Double>> sumPartList = new ArrayList<>();
            for(Part part : partList)
                sumPartList.add(subjectDao.getSumByPart(part.getIdPart(), title.getStudyTime()));

            //Сумма без пфк
            List<Double> sumWithoutPFK = new ArrayList<>();
            for(int i =0; i<45; i++)
                sumWithoutPFK.add(0.0);

            for (List<Double> list : sumPartList) {
                for (int i = 0; i < list.size(); i++) {
                    sumWithoutPFK.set(i, sumWithoutPFK.get(i) + list.get(i));
                }
            }

            //Сумма з.е
            double sumZE = 0;
            for(double d : sumZeList)
                sumZE += d;

            //Заполнение практик
            PractMariaDb practDao = fb.getPractMariaDb(connection);
            List<Pract> practList = practDao.getPractsByTitle(idTitle);

            PractTypesMariaDb typesDao = fb.getPractTypesMariaDb(connection);
            List<PractType> practTypes = typesDao.getAllPractTypes();

            //
            HashMap<Integer, String> typeMap = new HashMap<Integer, String>();
            for(PractType t : practTypes)
                typeMap.put(t.getIdPractType(), t.getName());

            //Сумма практик
            List<Double> sumPract = new ArrayList<>();
            for(int i = 0; i<4+title.getStudyTime()*2; i++)
                sumPract.add(0.0);

            for(Pract p : practList){
                sumPract.set(0, sumPract.get(0)+p.getWeek()*54.0/36.0);
                sumPract.set(1, sumPract.get(1)+p.getWeek()*54);
                sumPract.set(2, sumPract.get(2)+p.getWeek()*54);
                sumPract.set(3, sumPract.get(3)+p.getWeek()*54);
                for(int i = 1; i <= title.getStudyTime()*2; i++){
                    if(p.getSemester()==i)
                        sumPract.set(i+3, sumPract.get(i)+p.getWeek()*54.0/36.0);
                }
            }

            //Заполнение гос аттестаций
            StateSertificationMariaDb stateDao = fb.getStateSertificationMariaDb(connection);
            List<StateSertification> stateList = stateDao.getSertificationsByTitle(idTitle);

            SertificationTypesMariaDb stateTypeDao = fb.getSertificationTypesMariaDb(connection);
            List<SertificationType> stateTypes = stateTypeDao.getAllSertificationTypes();
            //
            HashMap<Integer, String> stateMap = new HashMap<Integer, String>();
            for(SertificationType t : stateTypes)
                stateMap.put(t.getIdSertificationType(), t.getName());

            //Сумма гос. аттестаций
            List<Double> sumState = new ArrayList<>();
            for(int i = 0; i<4+title.getStudyTime()*2; i++)
                sumState.add(0.0);

            for(StateSertification s : stateList){
                sumState.set(0, sumState.get(0)+s.getZe());
                sumState.set(1, sumState.get(1)+s.getZe()*36);
                sumState.set(2, sumState.get(2)+s.getZe()*36);
                sumState.set(3, sumState.get(3)+s.getZe()*36);
                for(int i = 1; i <= title.getStudyTime()*2; i++){
                    if(s.getSemester()==i)
                        sumState.set(i+3, sumState.get(i)+s.getZe());
                }
            }

            //Имена
            NameMariaDb nameDao = fb.getNameMariaDb(connection);
            Name name = nameDao.getNameByTitle(idTitle);

            req.setAttribute("title", title);
            req.setAttribute("name", name);
            req.setAttribute("cycleList", cycleList);
            req.setAttribute("cycleContent", cycleContent);
            req.setAttribute("sumAudList", sumAudList);
            req.setAttribute("sumSelfList", sumSelfList);
            req.setAttribute("sumList", sumList);
            req.setAttribute("message", message);
            req.setAttribute("examList", examList);
            req.setAttribute("creditList", creditList);
            req.setAttribute("kpList", kpList);
            req.setAttribute("sumZeList", sumZeList);
            req.setAttribute("sumBSRList", sumBSRList);
            req.setAttribute("countCycle", cycleDao.getCountCycleByTitle(idTitle));
            req.setAttribute("sumWithoutPFK", sumWithoutPFK);
            req.setAttribute("physicalList", physicalList);
            req.setAttribute("sumZE", sumZE);
            //Сумма аудиторных физкультуры
            req.setAttribute("sumAudPhysical", sumAudPhysical);
            //Практики
            req.setAttribute("practList", practList);
            req.setAttribute("typeMap", typeMap);
            req.setAttribute("sumPract", sumPract);
            //Гос аттестации
            req.setAttribute("stateList", stateList);
            req.setAttribute("stateMap", typeMap);
            req.setAttribute("sumState", sumState);
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

        req.getRequestDispatcher("/result.jsp").forward(req, resp);
    }

}
