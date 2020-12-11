package com.blog.service;

import com.blog.dao.IUserDao;
import com.blog.dao.UserDaoImp;
import com.blog.entity.User;

public class userImp implements IUser{
    @Override
    public User register(User user) {
        IUserDao dao = new UserDaoImp();
        User registerUser = dao.register(user);
        return registerUser;
    }

    @Override
    public User login(User loginUser) {
        IUserDao dao = new UserDaoImp();
        User user = dao.login(loginUser);
        return user;
    }

    @Override
    public User getHostUser(int id) {
        IUserDao dao = new UserDaoImp();
        User hostUser = dao.getHostUser(id);
        return hostUser;
    }
}
