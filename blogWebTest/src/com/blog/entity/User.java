package com.blog.entity;

import java.sql.Date;
import java.sql.Timestamp;

public class User {
    private int user_id;
    private String user_name;
    private String user_password;
    private String user_profile_photo;
    private Timestamp user_register_time;
    private Date user_birthday;
    private int user_age;
    private String user_telephone_number;

    @Override
    public String toString() {
        return "User{" +
                "user_id=" + user_id +
                ", user_name='" + user_name + '\'' +
                ", user_password='" + user_password + '\'' +
                ", user_profile_photo='" + user_profile_photo + '\'' +
                ", user_register_time=" + user_register_time +
                ", user_birthday=" + user_birthday +
                ", user_age=" + user_age +
                ", user_telephone_number=" + user_telephone_number +
                '}';
    }

    public User(int user_id, String user_name, String user_password, String user_profile_photo, Timestamp user_register_time, Date user_birthday, int user_age, String user_telephone_number) {
        this.user_id = user_id;
        this.user_name = user_name;
        this.user_password = user_password;
        this.user_profile_photo = user_profile_photo;
        this.user_register_time = user_register_time;
        this.user_birthday = user_birthday;
        this.user_age = user_age;
        this.user_telephone_number = user_telephone_number;
    }

    public User() {
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

    public String getUser_password() {
        return user_password;
    }

    public void setUser_password(String user_password) {
        this.user_password = user_password;
    }

    public String getUser_profile_photo() {
        return user_profile_photo;
    }

    public void setUser_profile_photo(String user_profile_photo) {
        this.user_profile_photo = user_profile_photo;
    }

    public Timestamp getUser_register_time() {
        return user_register_time;
    }

    public void setUser_register_time(Timestamp user_register_time) {
        this.user_register_time = user_register_time;
    }

    public Date getUser_birthday() {
        return user_birthday;
    }

    public void setUser_birthday(Date user_birthday) {
        this.user_birthday = user_birthday;
    }

    public int getUser_age() {
        return user_age;
    }

    public void setUser_age(int user_age) {
        this.user_age = user_age;
    }

    public String getUser_telephone_number() {
        return user_telephone_number;
    }

    public void setUser_telephone_number(String user_telephone_number) {
        this.user_telephone_number = user_telephone_number;
    }
}
