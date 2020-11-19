package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/SendCookieAndToSuccess")
public class SendCookieAndToSuccess extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //发送cookie
        String username = request.getParameter("username");
        String psd = request.getParameter("password");
        Cookie nameCookie = new Cookie("username", username);
        nameCookie.setMaxAge(120);
        Cookie psdCookie = new Cookie("password", psd);
        psdCookie.setMaxAge(120);
        response.addCookie(nameCookie);
        response.addCookie(psdCookie);

        //存储Session
        HttpSession session = request.getSession();
        session.setAttribute("name", username);
        session.setAttribute("password", psd);
        response.sendRedirect("Success");
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
