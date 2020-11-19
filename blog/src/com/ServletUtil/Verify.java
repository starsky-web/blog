package com.ServletUtil;

import com.DButil.User;

import javax.servlet.http.Cookie;
import java.util.HashMap;
import java.util.Map;


public class Verify {
    public static boolean CookieVerify(Cookie[] cookies){

        boolean condition = false;
        Map<String,String> cookie = new HashMap<>();
        if (cookie==null){
            //如果无cookie且ID验证为true则发放cookie
            condition=false;
            return condition;
        }
        //将cookie存入map集合
        for (Cookie cookie1 : cookies) {
            cookie.put(cookie1.getName(),cookie1.getValue());
        }
        //判断是否有username
        if (cookie.containsKey("username")&&cookie.containsKey("password")){
            if (User.login(cookie.get("username"),cookie.get("password"))){
                condition=true;
                return condition;
            }
        }else{
            condition=false;
            return condition;
        }

        return condition;
    }
}
