package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.SubSubjectMariaDb;
import data.model.SubSubject;

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

@WebServlet("/insertSubSubject")
public class InsertSubSubject extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int idSubject = Integer.parseInt(req.getParameter("subjectSelect"));
        String name = req.getParameter("nameSubject");

        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            SubSubjectMariaDb subjectDao = fb.getSubSubjectMariaDb(connection);
            SubSubject subject = new SubSubject();
            subject.setIdSubject(idSubject);
            subject.setName(name);

            if(!subjectDao.insertSubSubjects(Collections.singletonList(subject)))
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
