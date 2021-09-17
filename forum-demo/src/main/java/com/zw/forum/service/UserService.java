package com.zw.forum.service;

import com.zw.forum.bean.User;
import com.zw.forum.bean.UserExample;
import com.zw.forum.dao.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    UserMapper userMapper;

    public boolean addUser(User user){
        int i = userMapper.insertSelective(user);
        return i!=0? true:false;
    }

    //按名称查询用户 return true 表示用户名可以用
    public boolean checkUser(String name){
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andUsernameEqualTo(name);
       return userMapper.countByExample(userExample) ==0;
    }

    public User login(User user){
        UserExample userExample =new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andUsernameEqualTo(user.getUsername());
        List<User> users = userMapper.selectByExample(userExample);
        return users.get(0);
    }
}
