package controller.servlet.insert;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.UserMariaDb;
import data.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/insertUser")
public class InsertUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String login = req.getParameter("loginUserInsert");
        String password = req.getParameter("passwordUserInsert");
        int idDepartment = Integer.parseInt(req.getParameter("departmentUserInsert"));
        int idRole = Integer.parseInt(req.getParameter("roleUserInsert"));
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            UserMariaDb userDao = fb.getUserMariaDB(connection);
            if(!userDao.isUniqueLogin(login)){
                session.setAttribute("erMessage", "Такой логин уже существует!");
                resp.sendRedirect("/plans/admin/user-managment");
                return;
            }
            User user = new User();
            user.setLogin(login);
            user.setPassword(password);
            user.setIdDepartment(idDepartment);
            user.setIdRole(idRole);
            user.setVisible(true);

            if(!userDao.insertUser(user))
                session.setAttribute("erMessage", "Не удалось провести операцию");
            else session.setAttribute("message", "Пользователь успешно добавлен");
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
        resp.sendRedirect("/plans/admin/user-managment");
    }
}
