package com.DButil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class User {
    public static boolean login(String username,String psd){
        /**
         * 注册用方法
         */
        boolean isExist = false;
        String sql = "select * from user";
        Map<String,String> user = new HashMap<>();
        Connection conn = DBConnectUtil.getConnection();
        ResultSet rs = null;

       try{
           //获取执行对象
           Statement stmt = conn.createStatement();
           //执行查询语句
           rs = stmt.executeQuery(sql);
           while(rs.next()){
               user.put(rs.getString("username"),rs.getString("password"));
           }
       }catch (Exception e){
           System.out.println("查询用户时出错");
           System.out.println(e);
       }
        if (user.containsKey(username)){
            if(user.get(username).equals(psd)){
                isExist=true;
            }else {
                isExist=false;
            }
        }else{
            isExist=false;
        }

        return isExist;
    }

    public static boolean selectUser(String username){
        /**
         * 查询用户名是否存在
         * 供注册方法调用
         */
        //查询用户名是否存在，返回true为存在，false为不存在
        boolean isExist = false;
        String sql = "select * from user";
        Map<String,String> user = new HashMap<>();
        Connection conn = DBConnectUtil.getConnection();
        ResultSet rs = null;
        try{
            //获取执行对象
            Statement stmt = conn.createStatement();
            //执行查询语句
            rs = stmt.executeQuery(sql);
            while(rs.next()){
                user.put(rs.getString("username"),rs.getString("password"));
            }
        }catch (Exception e){
            System.out.println("查询用户时出错");
            System.out.println(e);
        }
        if (user.containsKey(username)){
            isExist=true;
        }else {
            isExist=false;
        }

        return isExist;
    }

    public static boolean register(String username,String psd){
        /**
         * 注册方法
         */
        boolean isExist = selectUser(username);
        boolean isSuccess = false;
        //查询用户名是否存在，不存在时才会执行
        if(!isExist){
            //获取连接
            Connection conn = DBConnectUtil.getConnection();
            String sql = "insert into user(username,password) values("+username+","+psd+");";
            try{
                //获取执行对象
                Statement stmt = conn.createStatement();
                int i = stmt.executeUpdate(sql);

            }catch (Exception e){
                System.out.println("注册用户时出现出错");
                System.out.println(e);
            }
        }else {
            isSuccess=false;
        }


        return isSuccess;
    }
}
