package com.blog.service;

import com.blog.entity.User;


public interface IUser {
    //业务逻辑层
    //定义方法，接收控制器传来的数据
    User register(User user);
    User login(User loginUser);
    User getHostUser(int id);

}
