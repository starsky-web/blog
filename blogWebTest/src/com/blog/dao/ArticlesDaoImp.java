package com.blog.dao;

import com.blog.entity.*;
import com.blog.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.Timestamp;
import java.util.List;

public class ArticlesDaoImp implements IArticlesDao{
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public int storeMd(String article_title,int user_id,String preview) {
        String sql = "insert into articles values(?,?,?,?,?,?,?,?,?)";
        int update = template.update(sql, null, user_id, article_title, article_title+".md", 0, 0, new Timestamp(System.currentTimeMillis()), 0,preview);
        return update;
    }

    @Override
    public int getCount(int user_id) {
        String sql = "select COUNT(*) from articles where user_id = ?";
        return template.queryForObject(sql, Integer.class, user_id);
    }

    @Override
    public List selectAllMd(int user_id,int page,int count) {
        //一页40篇

        String sql = "select * from articles where user_id = ? ORDER BY article_date desc LIMIT ?,? ";
        List<Articles> articles = template.query(sql, new BeanPropertyRowMapper<Articles>(Articles.class),user_id,(page-1)*count,count);
        return articles;
    }

    @Override
    public int viewIncrease(String mdName) {
        String sql = "update articles set article_views=article_views+1 where article_content = ?";
        int i = template.update(sql, mdName);
        return i;
    }

    @Override
    public int like(int id) {
        String sql = "update articles set article_like_count=article_like_count+1 where article_id = ?";
        int i = template.update(sql, id);
        return i;
    }

    @Override
    public int selectMdIdByMdName(String mdName) {
        String sql = "select article_id from articles where article_content = ?";
        int id = template.queryForObject(sql, Integer.class, mdName);

        return id;
    }

    @Override
    public List selectHotMd(int user_id) {
        String sql = "select * from articles where user_id=? order by article_like_count desc limit 0,5";
        List<Articles> HotMd = template.query(sql, new BeanPropertyRowMapper<Articles>(Articles.class), user_id);
        return HotMd;
    }

    @Override
    public int countLike(int user_id) {
        String sql = "SELECT SUM(article_like_count) FROM articles WHERE user_id=?";
        int countLike = template.queryForObject(sql, Integer.class, user_id);
        return countLike;
    }

    @Override
    public int countView(int user_id) {
        String sql = "SELECT SUM(article_views) FROM articles WHERE user_id=?";
        int countView = template.queryForObject(sql, Integer.class, user_id);
        return countView;
    }

    @Override
    public List selectNewMd(int user_id) {
        String sql = "select * from articles where user_id=? order by article_date desc limit 0,5";
        List<Articles> newMd = template.query(sql, new BeanPropertyRowMapper<Articles>(Articles.class), user_id);
        return newMd;
    }

    @Override
    public int selectBlogCount(int user_id) {
        String sql = "SELECT COUNT(article_title) FROM articles WHERE user_id=?";
        Integer blogCount = template.queryForObject(sql, Integer.class, user_id);
        return blogCount;
    }

    @Override
    public int selectRanking(int user_id) {
        String sql = "SELECT rowNo\n" +
                "from (\n" +
                "\tSELECT (@rowNum:=@rowNum+1) as rowNo,user_id\n" +
                "from (SELECT (@rowNum:=0)) b,\n" +
                "\t(SELECT user_id,SUM(article_like_count) \n" +
                "\t\tfrom  articles \n" +
                "\t\tGROUP BY user_id \n" +
                "\t\tORDER BY SUM(article_like_count) desc) as a\n" +
                ") as c\n" +
                "where user_id = ?";

        int ranking = template.queryForObject(sql, Integer.class, user_id);

        return ranking;
    }

    @Override
    public int storeComment(Comments comments) {
        String sql = "insert into comments values (?,?,?,?,?,?,?)";
        int i = template.update(sql, null, comments.getUser_id(), comments.getUser_name(),comments.getArticle_id(),comments.getArticle_title(),
                new Timestamp(System.currentTimeMillis()), comments.getComment_content());
        return i;
    }

    @Override
    public List selectComment(int article_id) {
        String sql = "select * from comments where article_id = ?";
        List<Comments> comments = template.query(sql, new BeanPropertyRowMapper<Comments>(Comments.class), article_id);
        return comments;
    }

    @Override
    public String selectUserNameById(int user_id) {
        String sql = "select user_name from users where user_id = ?";
        String userName = template.queryForObject(sql, String.class, user_id);
        return userName;
    }

    @Override
    public List selectNewComments(int user_id) {
        String sql = "select * from comments where article_id in (SELECT article_id from articles where user_id = ?)  ORDER BY comment_date DESC LIMIT 0,5";
        List<Comments> newComments = template.query(sql, new BeanPropertyRowMapper<Comments>(Comments.class), user_id);
        return newComments;
    }

    @Override
    public String getArticleTitleById(int article_id) {
        String sql = "select article_title FROM articles where article_id = ?";
        String articleTitle = template.queryForObject(sql, String.class, article_id);
        return articleTitle;
    }

    @Override
    public List search(String search) {
        String sql = "select * from articles where article_title like ?";
        List<Articles> searchResult = template.query(sql, new BeanPropertyRowMapper<Articles>(Articles.class), "%" + search + "%");
        return searchResult;
    }

    @Override
    public int updateUserProfilePhoto(String profilePhotoPath,int user_id) {
        String sql = "update users set user_profile_photo = ? where user_id = ?";
        return template.update(sql,profilePhotoPath,user_id);
    }

    @Override
    public List searchLimitId(String search, int user_id) {
        String sql = "select * from articles where article_title like ? and user_id = ?";
        List<Articles> searchResult = template.query(sql, new BeanPropertyRowMapper<Articles>(Articles.class), "%" + search + "%", user_id);
        return searchResult;
    }

    @Override
    public List getUserRanking() {
        String sql = "select users.user_id,user_name,user_profile_photo,SUM(article_like_count) as likeCounter from users,articles where users.user_id=articles.user_id GROUP BY user_id ORDER BY SUM(article_like_count) DESC LIMIT 0,8";
        List<UserRanking> userRankings = template.query(sql, new BeanPropertyRowMapper<UserRanking>(UserRanking.class));
        return userRankings;
    }

    @Override
    public List getHotRecommend() {
        String sql = "select users.user_id,user_name,user_profile_photo,article_title,article_views from users,articles where users.user_id=articles.user_id ORDER BY article_views DESC LIMIT 0,8";
        List<hotRecommend> hotRecommends = template.query(sql, new BeanPropertyRowMapper<hotRecommend>(hotRecommend.class));
        return hotRecommends;
    }

    @Override
    public List getIndexMd() {
        String sql = "select users.user_id,user_name,user_profile_photo,article_title,article_content from users,articles where users.user_id=articles.user_id ORDER BY RAND() LIMIT 0,60";
        List<indexMd> indexMds = template.query(sql, new BeanPropertyRowMapper<indexMd>(indexMd.class));
        return indexMds;
    }

    @Override
    public List getIndexMdByClassFy(String classFy) {
        String sql = "select users.user_id,user_name,user_profile_photo,article_title,article_content from users,articles where users.user_id=articles.user_id AND article_title like ? ORDER BY RAND() LIMIT 0,8";
        List<indexMd> mds = template.query(sql, new BeanPropertyRowMapper<indexMd>(indexMd.class), "%" + classFy + "%");
        return mds;
    }

    @Override
    public int selectCommentCounter(int user_id) {
        String sql = "SELECT COUNT(*) from comments WHERE article_id IN (SELECT article_id FROM articles where user_id = ?)";
        Integer integer = template.queryForObject(sql, Integer.class, user_id);
        return integer;
    }

    @Override
    public int delete(int article_id) {
        String sql = "DELETE FROM articles WHERE article_id = ?";
        int i = template.update(sql, article_id);
        return i;
    }

    @Override
    public Articles getArticles(int article_id) {
        String sql = "select * from articles where article_id = ?";
        Articles articles = template.queryForObject(sql, new BeanPropertyRowMapper<Articles>(Articles.class), article_id);
        return articles;
    }

    @Override
    public int mdUpdate(int article_id, String article_title, String preview) {
        String sql = "UPDATE articles SET article_title = ?,article_content = ?,article_date=?,article_preview=? where article_id = ?";
        int update = template.update(sql, article_title, article_title + ".md", new Timestamp(System.currentTimeMillis()), preview, article_id);
        return update;
    }

    @Override
    public int getUserIdByMdId(int article_id) {
        String sql = "select user_id from articles where article_id = ?";

        return template.queryForObject(sql, Integer.class, article_id);
    }

}
