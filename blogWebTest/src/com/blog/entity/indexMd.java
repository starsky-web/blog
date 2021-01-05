package com.blog.entity;

/**
 * 首页遍历文章
 */
public class indexMd {
    private int user_id;
    private String user_name;
    private String user_profile_photo;
    private String article_title;
    private String article_content;

    public indexMd() {
    }

    public indexMd(int user_id, String user_name, String user_profile_photo, String article_title, String article_content) {
        this.user_id = user_id;
        this.user_name = user_name;
        this.user_profile_photo = user_profile_photo;
        this.article_title = article_title;
        this.article_content = article_content;
    }

    @Override
    public String toString() {
        return "indexMd{" +
                "user_id=" + user_id +
                ", user_name='" + user_name + '\'' +
                ", user_profile_photo='" + user_profile_photo + '\'' +
                ", article_title='" + article_title + '\'' +
                ", article_content='" + article_content + '\'' +
                '}';
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_profile_photo() {
        return user_profile_photo;
    }

    public void setUser_profile_photo(String user_profile_photo) {
        this.user_profile_photo = user_profile_photo;
    }

    public String getArticle_title() {
        return article_title;
    }

    public void setArticle_title(String article_title) {
        this.article_title = article_title;
    }

    public String getArticle_content() {
        return article_content;
    }

    public void setArticle_content(String article_content) {
        this.article_content = article_content;
    }
}
