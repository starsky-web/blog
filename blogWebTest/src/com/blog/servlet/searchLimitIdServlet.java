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

@WebServlet("/searchLimitIdServlet")
public class searchLimitIdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("searchId");

        String search = request.getParameter("SLI");
        String id = request.getParameter("id");
        int user_id = Integer.parseInt(id);
        System.out.println("searchLimitId"+search);

        IArticles ia = new articlesImp();
        List searchResult = ia.searchLimitId(search, user_id);
        HttpSession session = request.getSession();
        session.setAttribute("searchResult",searchResult);
        PrintWriter pw = response.getWriter();
        pw.write(1);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
