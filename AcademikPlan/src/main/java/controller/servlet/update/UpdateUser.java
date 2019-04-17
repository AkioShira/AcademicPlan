package controller.servlet.update;

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

@WebServlet("/updateUser")
public class UpdateUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idUserUpdate"));
        String login = req.getParameter("loginUserUpdate");
        String password = req.getParameter("passwordUserUpdate");
        int idDepartment;
        int idRole;
        try{
            idDepartment = Integer.parseInt(req.getParameter("departmentUserUpdate"));
            idRole = Integer.parseInt(req.getParameter("roleUserUpdate"));
        }catch (NumberFormatException e){
            idDepartment = 0;
            idRole = 1;
        }
        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            UserMariaDb userDao = fb.getUserMariaDB(connection);
            if(!userDao.isUniqueLogin(login)&&!login.equals(userDao.getUserById(id).getLogin())){
                session.setAttribute("erMessage", "Такой логин уже существует!");
                resp.sendRedirect("/plans/admin/user-managment");
                return;
            }
            User user = userDao.getUserById(id);
            user.setLogin(login);
            user.setPassword(password);
            if(idRole != 1) {
                user.setIdDepartment(idDepartment);
                user.setIdRole(idRole);
            }
            userDao.updateUser(user);

            session.setAttribute("message", "Пользователь успешно редактирован");
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
