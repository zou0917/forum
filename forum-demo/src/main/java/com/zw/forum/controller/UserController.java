package com.zw.forum.controller;

import com.zw.forum.bean.Msg;
import com.zw.forum.bean.User;
import com.zw.forum.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    UserService userService;

    @ResponseBody
    @RequestMapping(value = "/user",method = RequestMethod.POST)
    public Msg addUser(User user){
        if(userService.addUser(user)){
            return Msg.success("成功");
        }else {
            return Msg.fail("失败");
        }
    }

    //按照名称校验
    @RequestMapping(value = "/check/{name}")
    @ResponseBody
    public Msg checkUser(@PathVariable("name") String name){
        boolean flag = userService.checkUser(name);
        if(flag){
            return Msg.success("成功");
        }else {
            return Msg.fail("失败");
        }
    }

    //登录
    @RequestMapping(value = "/user",method = RequestMethod.GET)
    @ResponseBody
    public Msg login(User user, HttpSession session){
        User login = userService.login(user);

        if (login ==null || ! login.getPassword().equals(user.getPassword())){
            return Msg.fail("失败");
        }
        if (login.getPassword().equals(user.getPassword())){
            session.setAttribute("username",login.getUsername());
            return Msg.success(login.getUsername());
        }else {
            return Msg.fail("失败");
        }
    }
    //退出登录
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    @ResponseBody
    public void logOut(HttpSession session){
        session.removeAttribute("username");
    }

    //判断有无登录
    @RequestMapping(value = "/isLogin",method = RequestMethod.GET)
    @ResponseBody
    public Msg isLogin (HttpSession session){
        if (session.getAttribute("username")==null){
            return Msg.fail("未登录");
        }else {
            return Msg.success((String) session.getAttribute("username"));
        }
    }

}
