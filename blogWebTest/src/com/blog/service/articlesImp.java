package com.blog.service;

import com.blog.dao.ArticlesDaoImp;
import com.blog.dao.IArticlesDao;
import com.blog.entity.Comments;
import com.blog.entity.UserRanking;

import java.util.List;

public class articlesImp implements IArticles{
    @Override
    public int storeMd(String article_title,int user_id,String preview) {
        IArticlesDao dao = new ArticlesDaoImp();
        int i = dao.storeMd(article_title, user_id,preview);
        return i;
    }

    @Override
    public List selectAllMd(int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        List mdList = dao.selectAllMd(user_id);
        return mdList;
    }

    @Override
    public int viewIncrease(String mdName) {
        IArticlesDao dao = new ArticlesDaoImp();
        int i = dao.viewIncrease(mdName);
        return i;
    }

    @Override
    public int like(int id) {
        IArticlesDao dao = new ArticlesDaoImp();
        int i = dao.like(id);
        return i;
    }

    @Override
    public int selectMdIdByMdName(String mdName) {
        IArticlesDao dao = new ArticlesDaoImp();
        int id = dao.selectMdIdByMdName(mdName);
        return id;
    }

    @Override
    public List selectHotMd(int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        List hotMd = dao.selectHotMd(user_id);
        return hotMd;
    }

    @Override
    public int countLike(int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        int countLike = dao.countLike(user_id);
        return countLike;
    }

    @Override
    public int countView(int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        int countView = dao.countView(user_id);
        return countView;
    }

    @Override
    public List selectNewMd(int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        List newMd = dao.selectNewMd(user_id);
        return newMd;
    }

    @Override
    public int selectBlogCount(int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        int blogCount = dao.selectBlogCount(user_id);
        return blogCount;
    }

    @Override
    public int selectRanking(int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        int ranking = dao.selectRanking(user_id);
        return ranking;
    }

    @Override
    public int storeComment(Comments comments) {
        IArticlesDao dao = new ArticlesDaoImp();
        int i = dao.storeComment(comments);
        return i;
    }

    @Override
    public List selectComment(int article_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        List comments = dao.selectComment(article_id);
        return comments;
    }

    @Override
    public String selectUserNameById(int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        String userName = dao.selectUserNameById(user_id);
        return userName;
    }

    @Override
    public List selectNewComments(int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        List newComments = dao.selectNewComments(user_id);
        return newComments;
    }

    @Override
    public String getArticleTitleById(int article_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        String articleTitle = dao.getArticleTitleById(article_id);
        return articleTitle;
    }

    @Override
    public List search(String search) {
        IArticlesDao dao = new ArticlesDaoImp();
        List searchResult = dao.search(search);
        return searchResult;
    }

    @Override
    public int updateUserProfilePhoto(String profilePhotoPath,int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        return dao.updateUserProfilePhoto(profilePhotoPath,user_id);
    }

    @Override
    public List searchLimitId(String search, int user_id) {
        IArticlesDao dao = new ArticlesDaoImp();
        List searchResult = dao.searchLimitId(search, user_id);
        return searchResult;
    }

    @Override
    public List getUserRanking() {
        IArticlesDao dao = new ArticlesDaoImp();
        List<UserRanking> userRanking = dao.getUserRanking();
        return userRanking;
    }

    @Override
    public List getHotRecommend() {
        IArticlesDao dao = new ArticlesDaoImp();
        List hotRecommend = dao.getHotRecommend();
        return hotRecommend;
    }

    @Override
    public List getIndexMd() {
        IArticlesDao dao = new ArticlesDaoImp();
        List indexMd = dao.getIndexMd();
        return indexMd;
    }

    @Override
    public List getIndexMdByClassFy(String classFy) {
        IArticlesDao dao = new ArticlesDaoImp();
        List indexMdByClassFy = dao.getIndexMdByClassFy(classFy);
        return indexMdByClassFy;
    }
}
