package com.blog.servlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.util.Set;

@WebServlet("/GetMd")
public class GetMd extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");
        //获取文件路径
        String mdName=request.getParameter("mdName");
//        File file = null;
//        ServletContext context=getServletContext();
//        Set<String> paths = context.getResourcePaths("/UserFile/md/");
//        for (String path : paths) {
//            if (path.endsWith(mdName)){
//                file=new File(path);
//            }
//            System.out.println(path);
//        }

//        InputStream rs = context.getResourceAsStream("/UserFile/md" + mdName);

//        for (String n:oSet) {
//            System.out.println(n);
//            InputStream is=context.getResourceAsStream(n);
//            int len=0;
//            while ((len=is.read())!=-1){
//                //输出流将文件内容输出到页面
//                response.getWriter().write(len);
//            }
//        }


        File savePath = new File("F:\\blogWebTest\\web\\UserFile\\md\\");
        File file = new File(savePath,mdName);
//
        //使用输入流获取文件内容
        BufferedReader fr = new BufferedReader(new InputStreamReader(new FileInputStream(file),"utf-8"));

        int len = 0;

        while ((len=fr.read())!=-1){
            //输出流将文件内容输出到页面
            response.getWriter().write(len);
        }

    }
}
