package com.blog.Test;

import com.blog.entity.UserRanking;
import com.blog.service.IArticles;
import com.blog.service.articlesImp;
import com.blog.util.indexUtil;
import org.junit.Test;

import java.util.List;
import java.util.Set;

public class test {
    @Test
    public void test(){
        List<String> pythonImg = indexUtil.getPythonImg();
        for (String s : pythonImg) {
            System.out.println(s);
        }

    }
}
