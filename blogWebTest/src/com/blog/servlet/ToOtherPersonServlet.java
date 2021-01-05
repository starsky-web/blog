package com.blog.servlet;

import com.blog.entity.PersonInfo;
import com.blog.entity.User;
import com.blog.service.IArticles;
import com.blog.service.IUser;
import com.blog.service.articlesImp;
import com.blog.service.userImp;
import com.blog.util.MdUtil;
import com.blog.util.UserUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * otherPersonShow点头像进入其他用户的主页
 * 这里获取其他用户的id来获取对象，并通过request发送给otherPerson.jsp
 */
@WebServlet("/ToOtherPersonServlet")
public class ToOtherPersonServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        IUser iu = new userImp();
        IArticles ia = new articlesImp();
        HttpSession session = request.getSession();

        //获取id
        String id = request.getParameter("id");
        System.out.println("获取的id值="+id);
        int user_id = Integer.parseInt(id);

        //获取用户对象并存入session
        User hostUser = iu.getHostUser(user_id);
        request.setAttribute("HostUser",hostUser);

        //获取用户展示信息
        PersonInfo info = UserUtil.getPersonInfo(user_id);
        session.setAttribute("HostInfo",info);

        int Count = ia.getCount(user_id);//获取md文章总数
        //获取页数
        int page = 1;
        try{
            page = Integer.parseInt(request.getParameter("page"));
        }catch (Exception e){
            page=1;
        }
        System.out.println("当前页"+page);

        //获取该用户所有文章并存入session
        List otherAllMd = ia.selectAllMd(user_id,page, MdUtil.PAGE_COUNT);
        int i = Count/MdUtil.PAGE_COUNT;
        int j = Count%MdUtil.PAGE_COUNT;
        if (j>0) {
            i++;
        }
        System.out.println("总页数="+i);
        session.setAttribute("pages",i);
        session.setAttribute("otherAllMd",otherAllMd);
        request.getRequestDispatcher("otherPerson.jsp").forward(request,response);
    }
}
