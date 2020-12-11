package com.blog.servlet;

import com.blog.entity.PersonInfo;
import com.blog.entity.User;
import com.blog.service.IArticles;
import com.blog.service.IUser;
import com.blog.service.articlesImp;
import com.blog.service.userImp;
import com.blog.util.UserUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/otherMdShowServlet")
public class otherMdShowServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        IArticles ia = new articlesImp();
        HttpSession session = request.getSession();

        String id = request.getParameter("id");
        String mdName = request.getParameter("mdName");

        //获取用户id，然后向下访问获取host用户

        int user_id = Integer.parseInt(id);
        IUser iu = new userImp();
        User hostUser = iu.getHostUser(Integer.parseInt(id));
        request.setAttribute("HostUser",hostUser);

        //获取用户信息
        request.setAttribute("HostUser",hostUser);

        //获取用户展示信息
        PersonInfo info = UserUtil.getPersonInfo(user_id);
        session.setAttribute("HostInfo",info);

        //获取md文件名
        System.out.println("otherMsShowServlet"+mdName);
        request.setAttribute("mdName",mdName);

        //获取评论
        int article_id = ia.selectMdIdByMdName(mdName);
        List comments = ia.selectComment(article_id);
        request.setAttribute("comments",comments);

        //浏览量加一
        int i = ia.viewIncrease(mdName);
        System.out.println("otherMdShowServlet"+i);

        request.getRequestDispatcher("otherPersonShow.jsp").forward(request,response);
    }
}
