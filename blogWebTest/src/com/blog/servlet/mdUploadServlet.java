package com.blog.servlet;

import com.blog.entity.User;
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
import java.io.PrintWriter;

@WebServlet("/mdUploadServlet")
public class mdUploadServlet extends HttpServlet {
    /**
     * 上传md文件用
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");


        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int user_id = user.getUser_id();//获取上传用户的ID

        String article_title = request.getParameter("article_title");//获取文章标题
        //article_title= new String(article_title.getBytes("iso-8859-1"),"utf-8");
        String article_content = request.getParameter("article_content");//获取文章内容
        //article_content = new String(article_content.getBytes("iso-8859-1"),"utf-8");

        //获取预览内容
        String preview = MdUtil.mdToPreview(article_content);
        int i = MdUtil.storeMd(article_content, article_title);//i为1则正确存储，为0则出现异常
        //将信息传入下一层，最终存入数据库
        IArticles ia = new articlesImp();
        int storeMdReturn = ia.storeMd(article_title, user_id,preview);
        PrintWriter pw = response.getWriter();
        if (storeMdReturn!=0){
            System.out.println("存储成功");


        }else{
            System.out.println("存储失败");

        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
