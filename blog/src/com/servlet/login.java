package com.servlet;

import com.DButil.User;
import com.ServletUtil.Send;
import com.ServletUtil.Verify;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Cookie验证
        Cookie[] cookies = request.getCookies();
        boolean CookieSuccess = Verify.CookieVerify(cookies);
        //验证成功则直接跳至成功界面
        if (CookieSuccess){
            request.getRequestDispatcher("Success").forward(request,response);
        }

        String username = request.getParameter("username");
        String psd = request.getParameter("password");
        //验证用户名密码
        boolean success = User.login(username,psd);
        if (success){
            //成功则发放cookie并跳至个人主页
            request.getRequestDispatcher("SendCookieAndToSuccess").forward(request,response);
        }else{
            //失败则跳回登录页面
            response.sendRedirect("login.html");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
