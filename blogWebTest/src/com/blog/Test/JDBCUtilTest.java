package com.blog.Test;

import com.blog.util.JDBCUtils;
import org.junit.Assert;
import org.junit.Test;

import javax.sql.DataSource;
import java.sql.Connection;

public class JDBCUtilTest {
    @Test
    public void testGetDataSource(){
        DataSource dataSource = JDBCUtils.getDataSource();
        int a=0;
        if (dataSource!=null){
            a = 1;
        }else {
            a = 2;
        }
        Assert.assertEquals(1,a);
    }

    @Test
    public void testGetConnection(){
        Connection connection = JDBCUtils.getConnection();
        int a =0;
        if (connection!=null){
            a = 1;
        }else {
            a = 2;
        }
        Assert.assertEquals(1,a);
    }
}
