package com.blog.util;

import javax.servlet.http.Cookie;

public class CookieUtil {
    /**
     * 用于从cookie列表中找到指定cookie
     * @param cookies
     * @param name
     * @return
     */
    public static Cookie findCookie(Cookie[] cookies,String name){
        if (cookies!=null){
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())){
                    return cookie;
                }
            }
        }

        return null;
    }
}
