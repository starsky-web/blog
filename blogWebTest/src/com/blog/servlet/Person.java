package com.blog.servlet;

import com.blog.entity.PersonInfo;
import com.blog.entity.User;
import com.blog.service.IArticles;
import com.blog.service.articlesImp;
import com.blog.util.UserUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/Person")
public class Person extends HttpServlet {
    /**
     * 进入个人页的中转
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        IArticles ia = new articlesImp();
        //获取user对象
        User user = (User) session.getAttribute("user");
        int user_id = user.getUser_id();
        //获取用户展示信息
        PersonInfo info = UserUtil.getPersonInfo(user_id);
        session.setAttribute("personInfo",info);
        //获取用户所有文章
        List allMd = ia.selectAllMd(user_id);
        session.setAttribute("allMd",allMd);
        request.getRequestDispatcher("person.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
