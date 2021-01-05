package com.blog.servlet;

import com.blog.entity.User;
import com.blog.service.IArticles;
import com.blog.service.IUser;
import com.blog.service.articlesImp;
import com.blog.service.userImp;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/uploadServlet")
public class uploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("调用");

        response.setContentType("test/html");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        IArticles ia = new articlesImp();
        IUser iu = new userImp();
        //获取工厂类
        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
        //通过工厂类获取ServletFileUpload实例
        ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);

        try {
            //使用servletFileUpload解析reque中的输入流，FileItem相当于一个input标签
            List<FileItem> list = servletFileUpload.parseRequest(request);
            for (FileItem fileItem : list) {
                //isFormField()用户判断fileItem是文件还是表单字段信息
                if (fileItem.isFormField()) {
                    //如果只是普通的字段，直接控制台输出信息
                    System.out.println(fileItem.getFieldName() + "---" + fileItem.getString("UTF-8"));
                } else {
                    //如果是文件，这时我们需要把文件写到本地（服务器）
                    System.out.println("文件名：" + fileItem.getName());
                    System.out.println("文件类型：" + fileItem.getContentType());
                    System.out.println("文件大小：" + fileItem.getSize());
                    //System.out.println("文件字段：" + fileItem.getString("UTF-8"));
                    //文件保存路径(每一天设置一个子文件夹
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
                    String dateStr = simpleDateFormat.format(new Date());

                    String savePath = "F:\\blogWebTest\\web\\UserFile\\md\\";

//                    String path = request.getServletContext().getRealPath(savePath);
//                    File dir = new File(savePath);
//                    if (!dir.exists()) {
//                        //mkdirs可以多级创建目录
//                        dir.mkdirs();
//                    }
                    //获取文件名后缀
                    String[] tmpStrs = fileItem.getName().split("\\.");
                    String suffix = tmpStrs[tmpStrs.length - 1];

                    //获取指定文件名
//                    String fileName = UUID.randomUUID().toString() + "." + suffix;
                    String fileName = user.getUser_name() +"."+ suffix;
                    //存入数据库
                    ia.updateUserProfilePhoto(fileName,user.getUser_id());
                    //借用方法更新user对象
                    user = iu.getHostUser(user.getUser_id());
                    session.setAttribute("user",user);
                    //拼接保存文件的路径+文件名
                    String saveFileName = savePath + "/" + fileName;
                    File dir = new File(saveFileName);
                    if (dir.exists()){
                        dir.delete();
                    }
                    //写到磁盘
                    fileItem.write(new File(saveFileName));
                    //删除临时文件
                    fileItem.delete();
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
