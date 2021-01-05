package com.blog.util;

import com.blog.entity.PersonInfo;
import com.blog.service.IArticles;
import com.blog.service.articlesImp;

public class UserUtil {
    public static PersonInfo getPersonInfo(int user_id){
        IArticles ia = new articlesImp();

        PersonInfo info = new PersonInfo();
        info.setRanking(ia.selectRanking(user_id));
        info.setBlogCount(ia.selectBlogCount(user_id));
        info.setLikeCount(ia.countLike(user_id));
        info.setCountView(ia.countView(user_id));
        info.setHotMd(ia.selectHotMd(user_id));
        info.setNewMd(ia.selectNewMd(user_id));
        info.setNewComments(ia.selectNewComments(user_id));
        info.setCommentCounter(ia.selectCommentCounter(user_id));
        return info;
    }
}
