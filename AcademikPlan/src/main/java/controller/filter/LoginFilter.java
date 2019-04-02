package controller.filter;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.UserMariaDB;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import static java.util.Objects.nonNull;

@WebFilter(urlPatterns = {"/"})
public class LoginFilter implements Filter {
    private Connection connection;

    public void init(FilterConfig filterConfig) throws ServletException {
        try {
            connection = ConnectionPool.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        final HttpServletRequest req = (HttpServletRequest) servletRequest;
        final HttpServletResponse res = (HttpServletResponse) servletResponse;
        HttpSession session = req.getSession();
        String login = req.getParameter("login");
        String password = req.getParameter("password");
        //пользователь уже авторизован
        if(nonNull(session) && nonNull(session.getAttribute("login")) && nonNull(session.getAttribute("password"))
                && nonNull(session.getAttribute("role"))) {
            servletRequest.getRequestDispatcher("SelectPanel.jsp").forward(servletRequest, servletResponse);
        }
        //авторизация пользователя
        else if(nonNull(login) && nonNull(password)) {
            UserMariaDB userDAO = new UserMariaDB(connection);
            if (userDAO.isExist(login, password)) {
                int role = userDAO.getRoleByLoginPassword(login, password);
                if(role !=0) {
                    session.setAttribute("login", login);
                    session.setAttribute("password", password);
                    session.setAttribute("role", role);
                    servletRequest.getRequestDispatcher("SelectPanel.jsp").forward(servletRequest, servletResponse);
                }

            }
        }
        servletRequest.getRequestDispatcher("Login.jsp").forward(servletRequest, servletResponse);

    }

    public void destroy() {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
