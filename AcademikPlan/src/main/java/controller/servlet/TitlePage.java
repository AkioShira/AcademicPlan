package controller.servlet;


import connection.pooling.ConnectionPool;
import controller.xml.editor.XmlEditor;
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
import java.util.HashMap;
import java.util.List;


@WebServlet("/title")
public class TitlePage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int id=0;
        try {
            id = Integer.parseInt(req.getParameter("idTitle"));
            session.setAttribute("idTitle", id);
        }catch (Exception e){
            id = (int) session.getAttribute("idTitle");
        }

        Connection connection = null;
        try{
            connection = ConnectionPool.getConnection();
            FactoryMariaDb fb = new FactoryMariaDb();
            TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
            Title title = titleDao.getTitleById(id);
            DirectionMariaDb directionDao = fb.getDirectionMariaDb(connection);
            List<Direction> directionList = directionDao.getAllDirections();
            GroupDirectionMariaDb groupDirectionDao = fb.getGroupDirectionMariaDb(connection);
            List<GroupDirection> groupDirectionList = groupDirectionDao.getAllDirections();
            ProfileMariaDb profileDao = fb.getProfileMariaDb(connection);
            List<Profile> profileList = profileDao.getAllProfiles();

            HashMap<Integer, String> directionMap = new HashMap<Integer, String>();
            for(Direction d : directionList)
                directionMap.put(d.getIdDirection(), d.getNumber()+ " " + d.getName());

            HashMap<Integer, String> groupDirectionMap = new HashMap<Integer, String>();
            for(GroupDirection g : groupDirectionList)
                groupDirectionMap.put(g.getIdGroupDirection(), g.getNumber()+ " " + g.getName());

            HashMap<Integer, String> profileMap = new HashMap<Integer, String>();
            for(Profile p : profileList)
                profileMap.put(p.getIdProfile(), p.getName());


            XmlEditor xmlEditor = new XmlEditor(getServletContext().getRealPath("resources/servlet-text.xml"));
            List<NodePage> titleContent = xmlEditor.getArrayXml("content");
            List<NodePage> titleShedules = xmlEditor.getArrayXml("month");
            List<NodePage> titleBudget = xmlEditor.getArrayXml("budget");
            List<NodePage> titleState = xmlEditor.getArrayXml("headState");
            List<NodePage> titlePractics = xmlEditor.getArrayXml("headPractics");

            groupDirectionList.remove(0);
            directionList.remove(0);
            profileList.remove(0);

            if(title.getFormEducation().equals("null"))
                title.setFormEducation("");

            req.setAttribute("groupDirectionList", groupDirectionList);
            req.setAttribute("directionList", directionList);
            req.setAttribute("profileList", profileList);

            req.setAttribute("titleContent", titleContent);
            req.setAttribute("titleShedules", titleShedules);
            req.setAttribute("titleBudget", titleBudget);
            req.setAttribute("titlePractics", titlePractics);
            req.setAttribute("titleState", titleState);
            req.setAttribute("idTitle", id);
            req.setAttribute("title", title);
        }catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if(connection != null)
                    connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        req.getRequestDispatcher("/title.jsp").forward(req, resp);
    }
}
