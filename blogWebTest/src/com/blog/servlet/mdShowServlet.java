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
import java.util.List;

@WebServlet("/mdShowServlet")
public class mdShowServlet extends HttpServlet {
    /**
     * 接收参数，存入request，并请求转发到展示页
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        IArticles ia = new articlesImp();
        String mdName = request.getParameter("mdName");
        System.out.println("msShowServlet"+mdName);
        HttpSession session = request.getSession();


        //获取评论集合
        int article_id = ia.selectMdIdByMdName(mdName);
        List comments = ia.selectComment(article_id);
//        request.setAttribute("comments",comments);
//        request.setAttribute("mdName",mdName);
        session.setAttribute("comments",comments);
        session.setAttribute("mdName",mdName);



        //浏览量加一
        int i = ia.viewIncrease(mdName);
        System.out.println("mdShowServlet"+i);

        request.getRequestDispatcher("personShow.jsp").forward(request,response);
    }
}
