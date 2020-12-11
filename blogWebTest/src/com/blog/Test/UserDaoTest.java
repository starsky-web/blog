package com.blog.Test;

import com.blog.dao.IUserDao;
import com.blog.dao.UserDaoImp;
import com.blog.entity.User;
import org.junit.Assert;
import org.junit.Test;

import java.sql.Timestamp;

public class UserDaoTest {
    @Test
    public void testRegister(){
        User user = new User(1,"test","456",null,new Timestamp(System.currentTimeMillis()),null,
                18,"15270696715");
        IUserDao iud = new UserDaoImp();
        User b = iud.register(user);
        int boo=0;
        if (b!=null){
            boo=1;
            iud.deleteUser();
        }else {
            boo=2;
        }
        Assert.assertEquals(1,boo);
    }
    @Test
    public void testLogin(){
        User loginUser = new User();
        loginUser.setUser_name("loginTest");
        loginUser.setUser_password("456");
        IUserDao iud = new UserDaoImp();
        User login = iud.login(loginUser);
        int boo=0;
        if (login!=null){
            boo = 1;
        }else{
            boo = 2;
        }
        Assert.assertEquals(1,boo);
    }
}
