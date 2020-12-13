package com.blog.servlet;

import com.blog.service.IArticles;
import com.blog.service.articlesImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/searchServlet")
public class searchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("search");
        String search = request.getParameter("search");
        System.out.println("search---"+search);
        IArticles ia = new articlesImp();
        List searchResult = ia.search(search);
        HttpSession session = request.getSession();
        session.setAttribute("searchResult",searchResult);
        PrintWriter pw = response.getWriter();
        pw.write(1);
        response.sendRedirect("resultDisplay.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("search");
        String search = request.getParameter("search");
        System.out.println("search---"+search);
        IArticles ia = new articlesImp();
        List searchResult = ia.search(search);
        HttpSession session = request.getSession();
        session.setAttribute("searchResult",searchResult);
        PrintWriter pw = response.getWriter();
        pw.write(1);
        response.sendRedirect("resultDisplay.jsp");
    }
}
