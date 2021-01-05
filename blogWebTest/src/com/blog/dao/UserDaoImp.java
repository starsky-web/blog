package com.blog.dao;

import com.blog.entity.User;
import com.blog.util.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.Timestamp;

public class UserDaoImp implements IUserDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public User register(User user) {
        String sql = "insert into users values(?,?,?,?,?,?,?,?)";
        int update = template.update(sql, user.getUser_id(), user.getUser_name(), user.getUser_password(), "default.png", new Timestamp(System.currentTimeMillis()),
                user.getUser_birthday(), user.getUser_age(), user.getUser_telephone_number());
        if (update==1){
            return user;
        }else {
            return null;
        }
    }

    @Override
    public User login(User loginUser) {
        try{
            String sql = "select * from users where user_name = ? and user_password = ?";
            User user = template.queryForObject(sql,
                    new BeanPropertyRowMapper<User>(User.class), loginUser.getUser_name(), loginUser.getUser_password());
            return user;
        }catch (DataAccessException e){
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public User getHostUser(int id) {
        String sql = "select * from users where user_id = ?";
        User hostUser = template.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), id);
        return hostUser;
    }

    @Override
    public int deleteUser() {
        /**
         * 注册测试方法用，测试完后删除添加的用户
         */
        String sql = "delete from users where user_name = 'test'";
        int delete = template.update(sql);
        return delete;
    }

}
