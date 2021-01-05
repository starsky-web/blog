package com.blog.service;

import com.blog.entity.Articles;
import com.blog.entity.Comments;
import com.blog.entity.User;

import java.util.List;

public interface IArticles {
    int storeMd(String article_title,int user_id,String preview);
    int getCount(int user_id);
    List selectAllMd(int user_id,int page,int count);
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
    int updateUserProfilePhoto(String profilePhotoPath,int user_id);
    List searchLimitId(String search,int user_id);
    //首页用
    List getUserRanking();
    List getHotRecommend();
    List getIndexMd();//随机拉取90篇文章
    List getIndexMdByClassFy(String classFy);
    //查询用户所有文章的评论数量
    int selectCommentCounter(int user_id);
    int delete(int article_id);
    Articles getArticles(int article_id);
    int mdUpdate(int article_id,String article_title,String preview);
    int getUserIdByMdId(int article_id);
}
