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


@WebServlet("/cycle")
public class CyclePage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int idCycle;
        int idTitle = (int) session.getAttribute("idTitle");
        try {
            idCycle = Integer.parseInt(req.getParameter("idCycle"));
            session.setAttribute("idCycle", idCycle);
        }catch (Exception e){
            idCycle = (int) session.getAttribute("idCycle");
        }

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
            Cycle cycle = cycleDao.getCycleById(idCycle);
            List<Cycle> cycleList = cycleDao.getCyclesByTitle(idTitle);

            //Заполнение частей
            PartMariaDb partDao = fb.getPartMariaDb(connection);
            List<Part> partList = partDao.getPartesByCycle(idCycle);

            HashMap<Integer, String> partMap = new HashMap<Integer, String>();
            for(Part p : partList)
                partMap.put(p.getIdPart(), p.getShortName());

            //Заполнение дисциплин
            SubjectMariaDb subjectDao = fb.getSubjectMariaDb(connection);
            List<Subject> subjectList = new ArrayList<Subject>();
            for(Part part : partList)
                subjectList.addAll(subjectDao.getSubjectsByPart(part.getIdPart()));

            //Заполнение дисциплин по выбору
            SubSubjectMariaDb subSubjectDao = fb.getSubSubjectMariaDb(connection);
            for(Subject s : subjectList)
                s.setSubSubjectList(subSubjectDao.getSubSubjectsBySubject(s.getIdSubject()));

            //Заполнение суммы частей
            List<List<Double>> sumList = new ArrayList<>();
            for(Part part : partList)
                sumList.add(subjectDao.getSumByPart(part.getIdPart(), title.getStudyTime()));

            //Заполнение суммы по циклу
            List<Double> sumAllList = new ArrayList<>();
            for(int i =0; i<45; i++)
                sumAllList.add(0.0);

            for (List<Double> list : sumList) {
                for (int i = 0; i < list.size(); i++) {
                    sumAllList.set(i, sumAllList.get(i) + list.get(i));
                }
            }



            req.setAttribute("title", title);
            req.setAttribute("cycleContent", cycleContent);
            req.setAttribute("cycle", cycle);
            req.setAttribute("cycleList", cycleList);
            req.setAttribute("partList", partList);
            req.setAttribute("subjectList", subjectList);
            req.setAttribute("sumList", sumList);
            req.setAttribute("sumAllList", sumAllList);
            req.setAttribute("partMap", partMap);
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

        req.getRequestDispatcher("/cycle.jsp").forward(req, resp);
    }

}
