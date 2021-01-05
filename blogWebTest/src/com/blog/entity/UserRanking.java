package com.blog.entity;

public class UserRanking {
    private int user_id;
    private String user_name;
    private String user_profile_photo;
    private int likeCounter;

    @Override
    public String toString() {
        return "UserRanking{" +
                "user_id=" + user_id +
                ", user_name='" + user_name + '\'' +
                ", user_profile_photo='" + user_profile_photo + '\'' +
                ", likeCounter=" + likeCounter +
                '}';
    }

    public UserRanking() {
    }

    public UserRanking(int user_id, String user_name, String user_profile_photo, int likeCounter) {
        this.user_id = user_id;
        this.user_name = user_name;
        this.user_profile_photo = user_profile_photo;
        this.likeCounter = likeCounter;
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

    public int getLikeCounter() {
        return likeCounter;
    }

    public void setLikeCounter(int likeCounter) {
        this.likeCounter = likeCounter;
    }
}
