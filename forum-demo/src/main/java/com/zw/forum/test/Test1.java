package com.zw.forum.test;


import com.zw.forum.bean.Posts;
import com.zw.forum.dao.PostsMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class Test1 {
    @Autowired
    PostsMapper postsMapper;
    @Test
    public void a() throws ParseException {
//        String time="2021-09-02 19:07:55";
//        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//        Date date = new Date();
//        System.out.println(simpleDateFormat.parse(time));

        Posts post = postsMapper.selectLastPostByColumnName("热点资讯");
        System.out.println(post);
    }
}




