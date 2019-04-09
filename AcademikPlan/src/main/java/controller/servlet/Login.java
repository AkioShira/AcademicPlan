package controller.servlet;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.FactoryMariaDb;
import data.dao.mariaDB.UserMariaDb;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import static java.util.Objects.nonNull;

@WebServlet("/")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        //Переадресовать на сайт авторизованного пользователя
        if(nonNull(session) && nonNull(session.getAttribute("login")) && nonNull(session.getAttribute("password"))
                && nonNull(session.getAttribute("role"))) {
            resp.sendRedirect("/plans");
            return;
        }
        //Вывод ошибки
        if(nonNull(req.getAttribute("errAuth"))){
            req.setAttribute("error", req.getAttribute("errAuth"));
        }
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection=null;
        //Авторизация
        try {
            connection = ConnectionPool.getConnection();
            HttpSession session = req.getSession();
            String login = req.getParameter("login");
            String password = req.getParameter("password");
            if(nonNull(login) && nonNull(password)) {
                FactoryMariaDb factory = new FactoryMariaDb();
                UserMariaDb userDAO = factory.getUserDao(connection);
                //Если логин и пароль верны занести в сессию и переадресовать на сайт
                if (userDAO.isExist(login, password)) {
                    int role = userDAO.getRoleByLoginPassword(login, password);
                    if(role !=0) {
                        session.setAttribute("login", login);
                        session.setAttribute("password", password);
                        session.setAttribute("role", role);
                        resp.sendRedirect("/plans");
                        return;
                    }
                }else{
                    req.setAttribute("errAuth", "Неверный логин-пароль");
                }
            }
            doGet(req, resp);
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

    }
}
