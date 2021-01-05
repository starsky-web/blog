package com.blog.servlet;

import com.blog.service.IArticles;
import com.blog.service.articlesImp;
import com.blog.util.MdUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/mdChange")
public class mdChange extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int article_id = Integer.parseInt(request.getParameter("article_id"));
        String article_title = request.getParameter("article_title");
        String article_content = request.getParameter("article_content");
        IArticles ia = new articlesImp();

        //重新生成预览
        String preview = MdUtil.mdToPreview(article_content);
        //重新存储
        int i = MdUtil.storeMd(article_content, article_title);

        //更新数据库
        int mdUpdate = ia.mdUpdate(article_id, article_title, preview);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
