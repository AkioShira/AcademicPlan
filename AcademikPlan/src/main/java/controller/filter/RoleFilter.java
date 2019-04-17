package controller.filter;

import data.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/plans/admin/*"})
public class RoleFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        final HttpServletRequest req = (HttpServletRequest) servletRequest;
        final HttpServletResponse resp = (HttpServletResponse) servletResponse;
        HttpSession session = req.getSession();


        User user = null;
        if(session != null){
            user = (User) session.getAttribute("sessionUser");
        }

        if(user!=null) {
            // Do stuff here
            if (user.getIdRole() == 1)
                filterChain.doFilter(req, resp);
            else
                resp.sendRedirect("/plans");
        }
        if(session != null)
            session.removeAttribute("erMessage");
        if(session != null)
            session.removeAttribute("message");
    }

    @Override
    public void destroy() {
    }
}
