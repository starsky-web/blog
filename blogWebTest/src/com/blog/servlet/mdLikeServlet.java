package com.blog.servlet;

import com.blog.entity.PersonInfo;
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
import java.io.PrintWriter;

@WebServlet("/mdLikeServlet")
public class mdLikeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("1111");
        String mdName = request.getParameter("mdName");
        IArticles ia = new articlesImp();
        int id = ia.selectMdIdByMdName(mdName);
        int like = ia.like(id);
        //重新获取信息
        int user_id = ia.getUserIdByMdId(id);
        PersonInfo newInfo = UserUtil.getPersonInfo(user_id);
        HttpSession session = request.getSession();
        session.setAttribute("personInfo",newInfo);
        PrintWriter pw = response.getWriter();
        System.out.println(like);
        pw.write(like);
    }
}
