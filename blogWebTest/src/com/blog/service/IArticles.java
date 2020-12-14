package com.blog.service;

import com.blog.entity.Comments;

import java.util.List;

public interface IArticles {
    int storeMd(String article_title,int user_id,String preview);
    List selectAllMd(int user_id);
    int viewIncrease(String mdName);
    int like(int id);
    int selectMdIdByMdName(String mdName);
    List selectHotMd(int user_id);
    int countLike(int user_id);
    int countView(int user_id);
    List selectNewMd(int user_id);
    int selectBlogCount(int user_id);
    int selectRanking(int user_id);
    int storeComment(Comments comments);
    List selectComment(int article_id);
    String selectUserNameById(int user_id);
    List selectNewComments(int user_id);//根据用户id查找该用户的所有文章中最新的5条评论
    String getArticleTitleById(int article_id);
    List search(String search);
}
