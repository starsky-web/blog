package com.blog.dao;

import com.blog.entity.User;

public interface IUserDao {
    User register(User user);
    User login(User loginUser);
    User getHostUser(int id);


    int deleteUser();//测试类用方法，其他类不允许调用
}
