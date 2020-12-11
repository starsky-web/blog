package com.blog.servlet;

import com.blog.entity.Comments;
import com.blog.service.IArticles;
import com.blog.service.articlesImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        IArticles ia = new articlesImp();

        //获取相应信息，并转化格式
        String mdName = request.getParameter("mdName");
        int userId = Integer.parseInt(request.getParameter("userId"));
        int articleId = ia.selectMdIdByMdName(mdName);
        String articleTitle = ia.getArticleTitleById(articleId);
        String content = request.getParameter("comment");
        String userName = ia.selectUserNameById(userId);

        //封装对象
        Comments comments = new Comments();
        comments.setArticle_id(articleId);
        comments.setArticle_title(articleTitle);
        comments.setUser_id(userId);
        comments.setComment_content(content);
        comments.setUser_name(userName);

        //存储至数据库
        int i = ia.storeComment(comments);
        PrintWriter pw = response.getWriter();
        pw.write(1);
    }
}
