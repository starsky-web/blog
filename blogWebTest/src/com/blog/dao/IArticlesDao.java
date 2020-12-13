package com.blog.dao;

import com.blog.entity.Comments;

import java.util.List;

public interface IArticlesDao {
    int storeMd(String article_title,int user_id,String prevoew);//存储md
    List selectAllMd(int user_id);//查询指定用户所有md
    int viewIncrease(String mdName);//点赞数增加
    int like(int id);//点赞
    int selectMdIdByMdName(String mdName);//使用md文件的name查找该文件的id
    List selectHotMd(int user_id);//查询指定用户的5篇热门文章
    int countLike(int user_id);//
    int countView(int user_id);
    List selectNewMd(int user_id);//查找新发布的md
    int selectBlogCount(int user_id);//
    int selectRanking(int user_id);//查找指定用户排名
    int storeComment(Comments comments);//保存评论
    List selectComment(int article_id);//查询评论
    String selectUserNameById(int user_id);//根据id查找用户
    List selectNewComments(int user_id);//根据用户id查找该用户的所有文章中最新的5条评论
    String getArticleTitleById(int article_id);//使用id获取md文件的title
    List search(String search);//搜索
    int updateUserProfilePhoto(String profilePhotoPath,int user_id);//更新用户头像
    List searchLimitId(String search,int user_id);//个人页搜索
    //首页用
    List getUserRanking();//获取前8位用户排名
    List getHotRecommend();//获取8篇热门文章
    List getIndexMd();
    List getIndexMdByClassFy(String classFy);
}
