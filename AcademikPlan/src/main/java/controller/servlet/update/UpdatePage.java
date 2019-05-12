package controller.servlet.update;


import controller.xml.editor.XmlEditor;
import data.model.NodePage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/updatePage")
public class UpdatePage extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        XmlEditor xmlEditor = new XmlEditor(getServletContext().getRealPath("resources/servlet-text.xml"));
        int item = Integer.parseInt(req.getParameter("item"));
        String nodeName = req.getParameter("nodeName");
        String value = req.getParameter("valueArea");
        NodePage nodePage = new NodePage();
        nodePage.setItem(item);
        nodePage.setNodeName(nodeName);
        nodePage.setValue(value);
        if(!xmlEditor.edit(nodePage))
            session.setAttribute("erMessage", "Не удалось провести операцию");
        else session.setAttribute("message", "Значение редактировано");
        resp.sendRedirect("/plans/admin/page-managment");
    }
}
