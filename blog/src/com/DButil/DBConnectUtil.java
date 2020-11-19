package com.DButil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectUtil {
    public static Connection getConnection(){
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql:///bolog", "root", "starsky001204");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return conn;
    }

}
