package com.blog.Test;

import com.blog.dao.ArticlesDaoImp;
import com.blog.dao.IArticlesDao;
import com.blog.entity.Articles;
import com.blog.util.JDBCUtils;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import java.security.PublicKey;
import java.util.List;


public class ArtikclesDaoImpTest {
    @Test
    public void  testStoreMd(){
        IArticlesDao dao = new ArticlesDaoImp();
        int i = dao.storeMd("sdsd",2,null);
        Assert.assertEquals(1,i);
    }
    @Test
    public void testselectAllMd(){
        IArticlesDao dao = new ArticlesDaoImp();
        List<Articles> a = dao.selectAllMd(2);
        boolean b = false;
        if(a!=null){
            b=true;
        }
        Assert.assertEquals(true,b);
    }
}
