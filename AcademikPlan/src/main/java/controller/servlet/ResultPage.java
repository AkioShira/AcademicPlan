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

            //Сумма аудиторных часов
            List<Double> sumAudList = subjectDao.getSumAudByTitle(idTitle);
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
                message +="Превышен максимальный предел загрузки студента в неделю.";

            //Количество экзаменов
            List<Double> examList = subjectDao.getCountExamsByTitle(idTitle);
            //Количество зачетов
            List<Double> creditList = subjectDao.getCountCreditsByTitle(idTitle);
            //Количество КП
            List<Double> kpList = subjectDao.getCountKPByTitle(idTitle);
            //Сумма кредитов
            List<Double> sumZeList = subjectDao.getSumCredByTitle(idTitle);

            //Сумма БСР
            List<Double> sumBSRList = subjectDao.getSumBSRByTitle(idTitle);

            PartMariaDb partDao = fb.getPartMariaDb(connection);
            List<Part> partList = partDao.getPartesByTitle(idTitle);
            //Сумма частей
            List<List<Double>> sumPartList = new ArrayList<>();
            for(Part part : partList)
                sumPartList.add(subjectDao.getSumByPart(part.getIdPart(), title.getStudyTime()));

            //Сумма всего
            List<Double> sumAllList = new ArrayList<>();
            for(int i =0; i<45; i++)
                sumAllList.add(0.0);

            for (List<Double> list : sumPartList) {
                for (int i = 0; i < list.size(); i++) {
                    sumAllList.set(i, sumAllList.get(i) + list.get(i));
                }
            }

            //Сумма з.е
            double sumZE = 0;
            for(double d : sumZeList)
                sumZE += d;

            req.setAttribute("title", title);
            req.setAttribute("cycleList", cycleList);
            req.setAttribute("cycleContent", cycleContent);
            req.setAttribute("sumAudList", sumAudList);
            req.setAttribute("sumSelfList", sumSelfList);
            req.setAttribute("sumList", sumList);
            req.setAttribute("message", message);
            req.setAttribute("examList", examList);
            req.setAttribute("creditList", creditList);
            req.setAttribute("kpList", kpList);
            req.setAttribute("sumZE", sumZE);
            req.setAttribute("sumZeList", sumZeList);
            req.setAttribute("sumBSRList", sumBSRList);
            req.setAttribute("countCycle", cycleDao.getCountCycleByTitle(idTitle));
            req.setAttribute("sumAllList", sumAllList);

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
