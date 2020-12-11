package com.blog.servlet;

import com.blog.service.IArticles;
import com.blog.service.articlesImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        PrintWriter pw = response.getWriter();
        System.out.println(like);
        pw.write(like);
    }
}
