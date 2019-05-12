package controller.servlet;

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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@WebServlet("/plans/title-managment")
public class TitleManagment extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
            GroupDirectionMariaDb groupDirectionDao = fb.getGroupDirectionMariaDb(connection);
            List<GroupDirection> groupDirectionList = groupDirectionDao.getAllDirections();
            DirectionMariaDb directionDao = fb.getDirectionMariaDb(connection);
            List<Direction> directionList = directionDao.getAllDirections();
            ProfileMariaDb profileDao = fb.getProfileMariaDb(connection);
            List<Profile> profileList = profileDao.getAllProfiles();
            DepartmentMariaDb departmentDao = fb.getDepartmentMariaDB(connection);

            List<Title> titleListVisible = new ArrayList<>();
            List<Title> titleListUnvisible = new ArrayList<>();

            List<Department> departmentList = new ArrayList<>();
            User user = (User) session.getAttribute("sessionUser");
            if(user.getIdRole()==2){
                departmentList.add(departmentDao.getDepartmentById(user.getIdDepartment()));
            }else
                departmentList = departmentDao.getDepartmentByVisibleFaculty(true, true);

            for(Department d : departmentList){
                titleListVisible.addAll(titleDao.getTitlesByDepartment(d.getIdDepartment(), true));
                titleListUnvisible.addAll(titleDao.getTitlesByDepartment(d.getIdDepartment(), false));
            }

            HashMap<Integer, String> departmentMap = new HashMap<Integer, String>();
            for(Department d : departmentList)
                departmentMap.put(d.getIdDepartment(), d.getShortName());

            groupDirectionList.remove(0);
            directionList.remove(0);
            profileList.remove(0);
            departmentList.remove(0);

            req.setAttribute("titleListVisible", titleListVisible);
            req.setAttribute("titleListUnvisible", titleListUnvisible);
            req.setAttribute("groupDirectionList", groupDirectionList);
            req.setAttribute("directionList", directionList);
            req.setAttribute("profileList", profileList);
            req.setAttribute("departmentList", departmentList);

            req.setAttribute("departmentMap", departmentMap);
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
        req.getRequestDispatcher("/title-managment.jsp").forward(req, resp);
    }
}
