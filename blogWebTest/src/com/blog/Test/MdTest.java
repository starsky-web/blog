package com.blog.Test;

import com.blog.dao.ArticlesDaoImp;
import com.blog.dao.IArticlesDao;
import com.blog.entity.Articles;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class MdTest {
    @Test
    public void mdLoadTest(){
        String savePath = ".\\web\\UserFile\\md";
        File file = new File(savePath);
        String content = "这里";

        try {
            file = new File(file.getCanonicalPath(),content+".md");
            file.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @Test
    public void selectAllMdTest(){
        int user_id=2;
        IArticlesDao ia = new ArticlesDaoImp();
        List<Articles> list = ia.selectAllMd(user_id);


        for (Articles o : list) {
            System.out.println(o.toString());
        }

    }
}
