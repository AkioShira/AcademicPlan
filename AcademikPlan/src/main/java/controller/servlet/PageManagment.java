package controller.servlet;

import controller.xml.editor.XmlEditor;
import data.model.NodePage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/plans/admin/page-managment")
public class PageManagment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        XmlEditor xmlEditor = new XmlEditor(getServletContext().getRealPath("resources/servlet-text.xml"));

        List<NodePage> titleContent = xmlEditor.getArrayXml("content");
        List<NodePage> titleShedules = xmlEditor.getArrayXml("month");
        List<NodePage> titleBudget = xmlEditor.getArrayXml("budget");
        List<NodePage> titlePractics = xmlEditor.getArrayXml("headPractics");
        List<NodePage> titleState = xmlEditor.getArrayXml("headState");
        List<NodePage> cicles0 = xmlEditor.getArrayXml("table-hmp");
        List<NodePage> cicles1= xmlEditor.getArrayXml("table-hmp1");
        List<NodePage> cicles2 = xmlEditor.getArrayXml("table-hmp2");
        req.setAttribute("titleContent", titleContent);
        req.setAttribute("titleShedules", titleShedules);
        req.setAttribute("titleBudget", titleBudget);
        req.setAttribute("titlePractics", titlePractics);
        req.setAttribute("titleState", titleState);
        req.setAttribute("cicles0", cicles0);
        req.setAttribute("cicles1", cicles1);
        req.setAttribute("cicles2", cicles2);
        req.getRequestDispatcher("/page-managment.jsp").forward(req, resp);
    }
}

