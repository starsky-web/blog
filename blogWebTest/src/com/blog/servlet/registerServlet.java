package com.blog.servlet;

import com.blog.entity.User;
import com.blog.service.IUser;
import com.blog.service.userImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/registerServlet")
public class registerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");


        String user_name = request.getParameter("user_name");
        String user_password = request.getParameter("user_password");
        String birthdayYear = request.getParameter("birthdayYear");
        String birthdayMouth = request.getParameter("birthdayMouth");
        String birthdayDay = request.getParameter("birthdayDay");

        Date user_birthday = new Date(Integer.parseInt(birthdayYear)-1900,Integer.parseInt(birthdayMouth)-1,Integer.parseInt(birthdayDay));

        //int  user_age = Integer.parseInt(request.getParameter("user_age"));
        String user_telephone_number = request.getParameter("user_telephone_number");

        User user = new User();
        user.setUser_name(user_name);
        user.setUser_password(user_password);
        user.setUser_birthday(user_birthday);
        //user.setUser_age(user_age);
        user.setUser_telephone_number(user_telephone_number);

        IUser iu = new userImp();
        User registerUser = iu.register(user);
        if (registerUser!=null){
            //非空则跳转主页，并登录
            HttpSession session = request.getSession();
            session.setAttribute("user",user);
            //request.setAttribute("user",user);
            request.getRequestDispatcher("login.html").forward(request,response);
        }else{
            //为空则返回注册页，并弹出警告
            request.getRequestDispatcher("register.jsp").forward(request,response);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
