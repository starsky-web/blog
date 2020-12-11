package com.blog.servlet;

import com.blog.entity.User;
import com.blog.service.IUser;
import com.blog.service.userImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
//    登录用
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");

        String user_name = request.getParameter("user_name");
        String user_password = request.getParameter("password");
        String autoLogin = request.getParameter("auto_login");//前端补一个选框
        User loginUser = new User();
        loginUser.setUser_name(user_name);
        loginUser.setUser_password(user_password);

        IUser iu = new userImp();
        User user = iu.login(loginUser);

        if (user!=null){
            if("on".equals(autoLogin)){
                //发送cookie
                Cookie cookie = new Cookie("auto_login", user_name+"#blog#"+user_password);
                cookie.setMaxAge(60*5);
                response.addCookie(cookie);
            }
            //成功进入首页
            request.getSession().setAttribute("user", user);
            response.sendRedirect("index.jsp");
        }else{
            response.sendRedirect("login.html");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
