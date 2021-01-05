package com.blog.servlet;

import com.blog.service.IArticles;
import com.blog.service.articlesImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete")
public class delete extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int article_id = Integer.parseInt(request.getParameter("article_id"));
        IArticles ia = new articlesImp();
        ia.delete(article_id);
        request.getRequestDispatcher("Person").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int article_id = Integer.parseInt(request.getParameter("article_id"));
        IArticles ia = new articlesImp();
        ia.delete(article_id);
        request.getRequestDispatcher("Person").forward(request,response);
    }
}
