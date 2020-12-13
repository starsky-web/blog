package com.blog.servlet;

import com.blog.entity.indexImg;
import com.blog.service.IArticles;
import com.blog.service.articlesImp;
import com.blog.util.indexUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebFilter("/index.jsp")
public class indexFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        IArticles ia = new articlesImp();
        HttpServletRequest request = (HttpServletRequest) req;
        System.out.println("拦截首页");
        HttpSession session = request.getSession();
        List userRanking = ia.getUserRanking();
        List hotRecommend = ia.getHotRecommend();
        List indexMd = ia.getIndexMd();
        List AIMD = ia.getIndexMdByClassFy("人工智能");
        List FrondMD = ia.getIndexMdByClassFy("前端");
        List lifeMD = ia.getIndexMdByClassFy("程序人生");
        indexImg indexImg = indexUtil.getImgs();
        session.setAttribute("userRanking",userRanking);
        session.setAttribute("hotRecommend",hotRecommend);
        session.setAttribute("indexMd",indexMd);//随机90篇文章
        session.setAttribute("indexImg",indexImg);
        session.setAttribute("AIMD",AIMD);
        session.setAttribute("FrondMD",FrondMD);
        session.setAttribute("LifeMd",lifeMD);



        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
