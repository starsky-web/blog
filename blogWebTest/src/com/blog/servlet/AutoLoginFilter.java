package com.blog.servlet;

import com.blog.dao.IUserDao;
import com.blog.dao.UserDaoImp;
import com.blog.entity.User;
import com.blog.util.CookieUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter("/.jsp")
public class AutoLoginFilter implements Filter {
//    自动登录
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        String uri = ((HttpServletRequest) req).getRequestURI();// 获得请求路径
        if(uri.endsWith(".css") || uri.endsWith(".js")) {// 如果是css或js文件，直接放行
            chain.doFilter(req, resp);
        }
        try{
            HttpServletRequest request = (HttpServletRequest) req;

            User user = (User) request.getSession().getAttribute("user");
            if(user!=null){
                chain.doFilter(request,resp);
            }else {
                //session失效，使用cookie

                //取出cookie
                Cookie[] cookies = request.getCookies();
                //找到需要的cookie
                Cookie cookie = CookieUtil.findCookie(cookies, "auto_login");

                //第一次登陆
                if (cookie==null){
                    chain.doFilter(request,resp);
                }else {
                    String value = cookie.getValue();
                    String username = value.split("#blog#")[0];
                    String password = value.split("#blog#")[1];

                    //完成登录
                    User loginUser = new User();
                    loginUser.setUser_name(username);
                    loginUser.setUser_password(password);

                    IUserDao dao = new UserDaoImp();
                    user = dao.login(loginUser);

                    //使用session存这个值到域中，方便下一次未过期前还可以用。
                    request.getSession().setAttribute("user", user);

                    chain.doFilter(request, resp);
                }

            }
        }catch (Exception e){
            e.printStackTrace();
            chain.doFilter(req,resp);

        }


        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
