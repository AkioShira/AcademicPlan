package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.PartMariaDb;
import data.dao.mariaDB.SubjectMariaDb;
import data.model.Part;
import data.model.Subject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;

@WebServlet("/insertSubject")
public class InsertSubject extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int idPart = Integer.parseInt(req.getParameter("partSubject"));
        String depart = req.getParameter("departSubject");
        String name = req.getParameter("nameSubject");

        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            SubjectMariaDb subjectDao = fb.getSubjectMariaDb(connection);
            Subject subject = new Subject();
            subject.setIdPart(idPart);
            int max = (int) subjectDao.getMaxNumberByPart(idPart);
            if(max<99)
                subject.setNumber(subjectDao.getMaxNumberByPart(idPart)+1);
            else
                subject.setNumber(99);
            subject.setName(name);
            subject.setDepart(depart);
            subject.setExams(1);
            if(!subjectDao.insertSubjects(Collections.singletonList(subject)))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Дисциплина успешно добавлена");
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
        resp.sendRedirect("/cycle");

    }
}
