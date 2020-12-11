package com.blog.servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/.jsp,/.java")
public class CharacterEncodingFilter implements Filter {
//    改编码
    String encoding = null;
    FilterConfig filterConfig = null;
    public void destroy() {
        this.encoding = null;
        this.filterConfig = null;
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
//        String uri = ((HttpServletRequest) req).getRequestURI();// 获得请求路径
//        if(uri.endsWith(".css") || uri.endsWith(".js")) {// 如果是css或js文件，直接放行
//            chain.doFilter(req, resp);
//        }
//        HttpServletRequest request = (HttpServletRequest) req;
//        HttpServletResponse response = (HttpServletResponse) resp;
//        request.setCharacterEncoding(encoding);
//        response.setContentType("text/html; charset="+encoding);

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html");
        resp.setCharacterEncoding("utf-8");


        chain.doFilter(req,resp);
    }

    public void init(FilterConfig config) throws ServletException {
        this.filterConfig = config;
        this.encoding = config.getInitParameter("encoding");
    }

}
