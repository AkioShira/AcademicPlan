package controller.servlet.update;

import connection.pooling.ConnectionPool;
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
import java.util.List;

@WebServlet("/updateCyclePage")
public class UpdateCyclePage extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idCycle"));
        String shortNameCycle = req.getParameter("shortNameCycleInsert");
        String nameCycle = req.getParameter("nameCycleInsert");

        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            CycleMariaDb cycleDao = fb.getCycleMariaDb(connection);
            Cycle cycle = cycleDao.getCycleById(id);
            cycle.setShortName(shortNameCycle);
            cycle.setName(nameCycle);

            //Обновить части
            PartMariaDb partDao = fb.getPartMariaDb(connection);
            List<Part> partList = partDao.getPartesByCycle(id);
            for(int i=1; i<=partList.size(); i++){
                String[] name = req.getParameterValues("part"+i);
                Part part = partList.get(i-1);
                part.setShortName(name[0]);
                part.setName(name[1]);
                partDao.updatePart(part);
            }

            //Обновить предметы
            SubjectMariaDb subjectDao = fb.getSubjectMariaDb(connection);

            int i = 1;
            int exam = 0;
            int credits =0;
            for(Part part : partList) {
                List<Subject> subjectList = subjectDao.getSubjectsByPart(part.getIdPart());
                for(Subject subject : subjectList){
                    String[] name = req.getParameterValues("subject-"+part.getIdPart()+"-"+i);
                    subject.setNumber(Double.parseDouble(name[0]));
                    subject.setName(name[1]);
                    subject.setDepart(name[2]);
                    exam = Integer.parseInt(name[3]);
                    credits = Integer.parseInt(name[4]);
                    if(exam!=0){
                        subject.setExams(exam);
                        subject.setCredits(0);
                    }else if(credits!=0){
                        subject.setExams(0);
                        subject.setCredits(credits);
                    }
                    subject.setBsr(Integer.parseInt(name[5]));
                    if(name.length>6) {
                        subject.setLec(Double.parseDouble(name[6]));
                        subject.setLab(Double.parseDouble(name[7]));
                        subject.setPract(Double.parseDouble(name[8]));
                        subject.setSelf(Double.parseDouble(name[9]));
                    }
                    i++;
                }
                subjectDao.updateSubjects(subjectList);
            }

            if(!cycleDao.updateCycle(cycle))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "План успешно редактирован");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("erMessage", "Не удалось провести операцию");
        }
        finally{
            try {
                if(connection != null)
                    connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect("/cycle");
    }
}
