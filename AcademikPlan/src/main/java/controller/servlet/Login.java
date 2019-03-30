package controller.servlet;

import connection.pooling.ConnectionPool;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            Connection con = ConnectionPool.getConnection();
            PreparedStatement st = con.prepareStatement("Select * from users");
            ResultSet rs = st.executeQuery();
            List<String> list = new ArrayList<String>();
            while(rs.next()){
                list.add(rs.getString(2));
                System.out.println(rs.getString(2));
            }
            req.setAttribute("name", list);
            con.close();
            st.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

        }


        req.getRequestDispatcher("Login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

}
