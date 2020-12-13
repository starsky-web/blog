package com.blog.entity;

public class hotRecommend {
    private int user_id;
    private String user_name;
    private String user_profile_photo;
    private String article_title;//没有.md
    private int article_views;

    @Override
    public String toString() {
        return "hotRecommend{" +
                "user_id=" + user_id +
                ", user_name='" + user_name + '\'' +
                ", user_profile_photo='" + user_profile_photo + '\'' +
                ", article_title='" + article_title + '\'' +
                ", article_views=" + article_views +
                '}';
    }

    public hotRecommend() {
    }

    public hotRecommend(int user_id, String user_name, String user_profile_photo, String article_title, int article_views) {
        this.user_id = user_id;
        this.user_name = user_name;
        this.user_profile_photo = user_profile_photo;
        this.article_title = article_title;
        this.article_views = article_views;
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

    public int getArticle_views() {
        return article_views;
    }

    public void setArticle_views(int article_views) {
        this.article_views = article_views;
    }
}
