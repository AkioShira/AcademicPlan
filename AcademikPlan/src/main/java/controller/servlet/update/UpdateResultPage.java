package controller.servlet.update;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.*;
import data.model.*;
import org.omg.Messaging.SYNC_WITH_TRANSPORT;

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

@WebServlet("/updateResultPage")
public class UpdateResultPage extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int idTitle = Integer.parseInt(req.getParameter("idTitle"));

        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            // Обновить физ подготовку
            PhysicalMariaDb physicalDao = fb.getPhysicalMariaDb(connection);
            List<Physical> physicalList = physicalDao.getPhysicalsByTitle(idTitle);
            String[] physical = req.getParameterValues("physical");
            for(int i = 0; i < 2; i++){
                int bsr = Integer.parseInt(physical[i]);
                physicalList.get(i).setIdTitle(idTitle);
                physicalList.get(i).setBsr(bsr);

                String[] weeks = req.getParameterValues("physical"+i);
                List<Double> weekList = new ArrayList<>();
                for(int j = 0; j < weeks.length; j ++)
                    weekList.add(Double.parseDouble(weeks[j]));
                physicalList.get(i).setWeek(weekList);
            }

            if(!physicalDao.updatePhysical(physicalList))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "План успешно редактирован");

            //Обновить гос аттестацию
            StateSertificationMariaDb stateDao = fb.getStateSertificationMariaDb(connection);
            List<StateSertification> stateList = stateDao.getSertificationsByTitle(idTitle);
            for(int i =0; i<stateList.size(); i ++){
                float ze = Float.parseFloat(req.getParameter("state"+i));
                stateList.get(i).setZe(ze);
            }
            if(!stateDao.updateSertifications(stateList))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "План успешно редактирован");

            //Обновить имена
            String prorectorName = req.getParameter("prorectorName");
            String studyName = req.getParameter("studyName");
            String decanName = req.getParameter("decanName");
            String departName = req.getParameter("departName");

            NameMariaDb nameDao = fb.getNameMariaDb(connection);
            Name name = nameDao.getNameByTitle(idTitle);
            name.setProrectorName(prorectorName);
            name.setStudyName(studyName);
            name.setDecanName(decanName);
            name.setDepartName(departName);

            if(!nameDao.updateName(name))
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
        resp.sendRedirect("/result");
    }
}
