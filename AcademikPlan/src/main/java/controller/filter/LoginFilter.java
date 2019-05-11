package controller.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static java.util.Objects.nonNull;

@WebFilter(urlPatterns = {"/*"})
public class LoginFilter implements Filter {


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        final HttpServletRequest req = (HttpServletRequest) servletRequest;
        final HttpServletResponse resp = (HttpServletResponse) servletResponse;
        HttpSession session = req.getSession();

        //пользователь уже авторизован
        if(nonNull(session) && nonNull(session.getAttribute("sessionUser"))) {

            filterChain.doFilter(req, resp);
        }else {
            req.getRequestDispatcher("/").forward(req, resp);
        }
    }

    @Override
    public void destroy() {

    }
}
