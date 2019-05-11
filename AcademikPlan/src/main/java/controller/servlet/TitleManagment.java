package controller.servlet;

import connection.pooling.ConnectionPool;
import data.dao.mariaDB.*;
import data.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
            List<Department> departmentList = departmentDao.getDepartmentByVisibleFaculty(true, true);
            List<Title> titleListVisible = new ArrayList<>();
            List<Title> titleListUnvisible = new ArrayList<>();

            for(Department d : departmentList){
                titleListVisible.addAll(titleDao.getTitlesByDepartment(d.getIdDepartment(), true));
                titleListUnvisible.addAll(titleDao.getTitlesByDepartment(d.getIdDepartment(), false));
            }

            HashMap<Integer, String> groupDirectionMap = new HashMap<Integer, String>();
            for(GroupDirection g : groupDirectionList)
                groupDirectionMap.put(g.getIdGroupDirection(), g.getNumber()+ " " + g.getName());

            HashMap<Integer, String> directionMap = new HashMap<Integer, String>();
            for(Direction d : directionList)
                directionMap.put(d.getIdDirection(), d.getNumber()+ " " + d.getName());

            HashMap<Integer, String> profileMap = new HashMap<Integer, String>();
            for(Profile p : profileList)
                profileMap.put(p.getIdProfile(), p.getName());

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
            req.setAttribute("groupDirectionMap", groupDirectionMap);
            req.setAttribute("directionMap", directionMap);
            req.setAttribute("profileMap", profileMap);
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
