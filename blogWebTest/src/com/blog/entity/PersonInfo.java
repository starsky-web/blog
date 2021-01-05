package com.blog.entity;

import java.util.List;

public class PersonInfo {
    private int blogCount;//博文总数
    private int likeCount;//点赞总数
    private List<Articles> HotMd;
    private int countView;
    private List<Articles> NewMd;
    private int ranking;//排名
    private List<Comments> newComments;
    private int CommentCounter;

    @Override
    public String toString() {
        return "PersonInfo{" +
                "blogCount=" + blogCount +
                ", likeCount=" + likeCount +
                ", HotMd=" + HotMd +
                ", countView=" + countView +
                ", NewMd=" + NewMd +
                ", ranking=" + ranking +
                ", newComments=" + newComments +
                ", CommentCounter=" + CommentCounter +
                '}';
    }

    public PersonInfo(int blogCount, int likeCount, List<Articles> hotMd, int countView, List<Articles> newMd, int ranking, List<Comments> newComments, int commentCounter) {
        this.blogCount = blogCount;
        this.likeCount = likeCount;
        HotMd = hotMd;
        this.countView = countView;
        NewMd = newMd;
        this.ranking = ranking;
        this.newComments = newComments;
        CommentCounter = commentCounter;
    }

    public PersonInfo() {
    }

    public int getBlogCount() {
        return blogCount;
    }

    public void setBlogCount(int blogCount) {
        this.blogCount = blogCount;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public List<Articles> getHotMd() {
        return HotMd;
    }

    public void setHotMd(List<Articles> hotMd) {
        HotMd = hotMd;
    }

    public int getCountView() {
        return countView;
    }

    public void setCountView(int countView) {
        this.countView = countView;
    }

    public List<Articles> getNewMd() {
        return NewMd;
    }

    public void setNewMd(List<Articles> newMd) {
        NewMd = newMd;
    }

    public int getRanking() {
        return ranking;
    }

    public void setRanking(int ranking) {
        this.ranking = ranking;
    }

    public List<Comments> getNewComments() {
        return newComments;
    }

    public void setNewComments(List<Comments> newComments) {
        this.newComments = newComments;
    }

    public int getCommentCounter() {
        return CommentCounter;
    }

    public void setCommentCounter(int commentCounter) {
        CommentCounter = commentCounter;
    }
}
