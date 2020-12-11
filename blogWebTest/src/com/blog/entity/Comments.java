package com.blog.entity;

import java.sql.Timestamp;

public class Comments {
    private int comment_id;
    private int user_id;
    private String user_name;
    private int article_id;
    private String article_title;
    private Timestamp comment_date;
    private String comment_content;

    @Override
    public String toString() {
        return "Comments{" +
                "comment_id=" + comment_id +
                ", user_id=" + user_id +
                ", user_name='" + user_name + '\'' +
                ", article_id=" + article_id +
                ", article_title='" + article_title + '\'' +
                ", comment_date=" + comment_date +
                ", comment_content='" + comment_content + '\'' +
                '}';
    }

    public Comments(int comment_id, int user_id, String user_name, int article_id, String article_title, Timestamp comment_date, String comment_content) {
        this.comment_id = comment_id;
        this.user_id = user_id;
        this.user_name = user_name;
        this.article_id = article_id;
        this.article_title = article_title;
        this.comment_date = comment_date;
        this.comment_content = comment_content;
    }

    public Comments() {
    }

    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
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

    public int getArticle_id() {
        return article_id;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }

    public String getArticle_title() {
        return article_title;
    }

    public void setArticle_title(String article_title) {
        this.article_title = article_title;
    }

    public Timestamp getComment_date() {
        return comment_date;
    }

    public void setComment_date(Timestamp comment_date) {
        this.comment_date = comment_date;
    }

    public String getComment_content() {
        return comment_content;
    }

    public void setComment_content(String comment_content) {
        this.comment_content = comment_content;
    }
}
