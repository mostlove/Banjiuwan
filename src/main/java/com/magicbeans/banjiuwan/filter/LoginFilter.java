package com.magicbeans.banjiuwan.filter;

import com.magicbeans.banjiuwan.beans.AdminUser;
import com.magicbeans.banjiuwan.util.LoginHelper;
import com.magicbeans.banjiuwan.util.StatusConstant;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Eric Xie on 2017/2/15 0015.
 */

@WebFilter("/web/*")
public class LoginFilter implements Filter {

    private Logger logger = Logger.getLogger(this.getClass());

    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String url = request.getRequestURI();
        if(null != url && url.indexOf("login") > 0){
            filterChain.doFilter(request,response);
        }
        else{
            AdminUser user = (AdminUser)request.getSession().getAttribute(LoginHelper.SESSION_USER);
            if(null == user){
                response.sendRedirect(request.getContextPath()+"/web/login");
                return;
            }
            filterChain.doFilter(request,response);
        }
    }

    public void destroy() {

    }
}
