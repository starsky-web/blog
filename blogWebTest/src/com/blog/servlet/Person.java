package com.blog.servlet;

import com.blog.entity.PersonInfo;
import com.blog.entity.User;
import com.blog.service.IArticles;
import com.blog.service.articlesImp;
import com.blog.util.JDBCUtils;
import com.blog.util.MdUtil;
import com.blog.util.UserUtil;
import org.springframework.dao.EmptyResultDataAccessException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/Person")
public class Person extends HttpServlet {
    /**
     * 进入个人页的中转
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        IArticles ia = new articlesImp();
        User user = null;
        int user_id = 0;
        //获取user对象
        try{
            user = (User) session.getAttribute("user");
            user_id =  user.getUser_id();
        }catch (Exception e){

        }


        //获取用户展示信息
        PersonInfo info = null;
        List allMd = null;
        int Count = ia.getCount(user_id);//获取md文章总数
        //获取页数
        int page = 1;
        try{
            page = Integer.parseInt(request.getParameter("page"));
        }catch (Exception e){
            page=1;
        }
        System.out.println("当前页"+page);


        try{
            info = UserUtil.getPersonInfo(user_id);
            allMd = ia.selectAllMd(user_id,page, MdUtil.PAGE_COUNT);//已改，获取一页的文章
        }catch (EmptyResultDataAccessException e){

        }
        //获取总页数并传给前端
        int i = Count/MdUtil.PAGE_COUNT;
        int j = Count%MdUtil.PAGE_COUNT;
        if (j>0) {
            i++;
        }
        System.out.println("总页数="+i);
        session.setAttribute("pages",i);
        //获取用户所有文章
        session.setAttribute("personInfo",info);
        session.setAttribute("allMd",allMd);

//        request.getRequestDispatcher("person.jsp").forward(request,response);
        response.sendRedirect("person.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
