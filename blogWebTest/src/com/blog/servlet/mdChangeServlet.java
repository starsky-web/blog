package com.blog.servlet;

import com.blog.entity.Articles;
import com.blog.service.IArticles;
import com.blog.service.articlesImp;
import com.blog.util.MdUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/mdChangeServlet")
public class mdChangeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        IArticles ia = new articlesImp();
        HttpSession session = request.getSession();
        //获取博文id
        int article_id = Integer.parseInt(request.getParameter("id"));
        System.out.println(article_id);

        Articles changeArticle = ia.getArticles(article_id);
        session.setAttribute("changeArticle",changeArticle);
        String mdFullText = MdUtil.mdFullText(changeArticle.getArticle_content());
        session.setAttribute("mdFullText",mdFullText);


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);

    }
}
