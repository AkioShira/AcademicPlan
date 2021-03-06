package controller.servlet.delete;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.SubSubjectMariaDb;
import data.dao.mariaDB.SubjectMariaDb;
import data.model.SubSubject;
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

@WebServlet("/deleteSubSubject")
public class DeleteSubSubject extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idSubSubjectDelete"));
        Connection connection = null;
        HttpSession session = req.getSession();
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            SubSubjectMariaDb subjectDao = fb.getSubSubjectMariaDb(connection);
            SubSubject subject = subjectDao.getSubSubjectById(id);
            if(!subjectDao.deleteSubSubject(subject))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Предмет удалён");
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
