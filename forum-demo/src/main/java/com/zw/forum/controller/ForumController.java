package com.zw.forum.controller;



import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zw.forum.bean.Msg;
import com.zw.forum.bean.Posts;
import com.zw.forum.bean.Replay;

import com.zw.forum.service.PostsService;
import com.zw.forum.service.ReplayService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class ForumController {
    @Autowired
    PostsService postsService;
    @Autowired
    ReplayService replayService;
    //跳转页面并回显板块信息
    @RequestMapping(value = "/forum/{forumNumber}")
    public String forums(@PathVariable("forumNumber") Integer forumNumber, HttpSession session){

        switch (forumNumber){
            case 1 : session.setAttribute("forumName","热点资讯");break;
            case 2 : session.setAttribute("forumName","文学交流");break;
            case 3 : session.setAttribute("forumName","娱乐信息");break;
            case 4 : session.setAttribute("forumName","问答专区");break;
            case 5 : session.setAttribute("forumName","搜索结果");break;
            case 6 : session.setAttribute("forumName","管理帖子");break;
            default:return "error";
        }
        return "forum_01";
    }

    //分页
    @RequestMapping(value = "/pages")
    @ResponseBody
    public Msg pages( @RequestParam(value = "pn",defaultValue = "1") Integer page,@RequestParam(value = "username",defaultValue = "") String username,@RequestParam(value = "title",defaultValue = "") String title, HttpSession session){
        //设置分页的当前页码及每页显示条目数
        PageHelper.startPage(page, 10);
        List<Posts> postsList;
        if((session.getAttribute("forumName")).equals("搜索结果")){
            postsList = postsService.queryByTitle(title);
        }else if ((session.getAttribute("forumName")).equals("管理帖子")){
            if(username.equals("管理员")){
                postsList=postsService.queryByTitle("");
            }else {
                postsList = postsService.queryByUserName(username);
            }
        }else{
            postsList = postsService.selectForumPosts((String) session.getAttribute("forumName"));
        }
        if(postsList.size()!=0){
            PageInfo<Posts> pageInfo = new PageInfo<>(postsList, 5);
           return Msg.success((String) session.getAttribute("forumName")).add("pageInfo",pageInfo);
        }
        return Msg.fail("无帖子");
    }
    //添加帖子
    @RequestMapping(value = "/forum",method = RequestMethod.POST)
    @ResponseBody
    public Msg addPost(Posts posts){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        try {
            posts.setDate(simpleDateFormat.parse(simpleDateFormat.format(new Date())));
            if(postsService.addPost(posts)){return Msg.success("成功");}
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return Msg.fail("失败");
    }
    //删除帖子
    @RequestMapping(value = "/forum/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deletePostById(@PathVariable("id") Integer id){
       if(postsService.deleteById(id)){
           return Msg.success("成功");
       }else {
           return Msg.fail("失败");
       }
    }
    //添加回帖
    @RequestMapping(value = "/replay",method = RequestMethod.POST)
    @ResponseBody
    public Msg addPost(Replay replay,HttpSession session){
        if (session.getAttribute("username")==null){
            return Msg.fail("未登录");
        }
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        try {
            replay.setDate(simpleDateFormat.parse(simpleDateFormat.format(new Date())));
            if(replayService.addReplay(replay)){return Msg.success("成功");}
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return Msg.fail("失败");
    }
    //获取回帖
    @RequestMapping(value = "/replay",method = RequestMethod.GET)
    @ResponseBody
    public Msg getReplays(Integer topicId, @RequestParam(value = "pn",defaultValue = "1") Integer page){
        PageHelper.startPage(page, 5);
        List<Replay> replays = replayService.selectReplays(topicId);
        if(replays.size()!=0){
            PageInfo<Replay> pageInfo = new PageInfo<Replay>(replays, 5);
            return Msg.success("成功").add("pageInfo",pageInfo);
        }else {
            return Msg.fail("失败");
        }
    }

    //回显板块数据
    @RequestMapping(value = "/forum",method = RequestMethod.GET)
    @ResponseBody
    public Msg showForumData(){
        List<Posts> posts = postsService.selectForum();
        return Msg.success("成功").add("posts",posts);
    }

    //跳转到帖子详情页面
    @RequestMapping(value = "/toForum",method = RequestMethod.GET)
    public String showForumData(@RequestParam(value = "id") Integer id,HttpSession session){
        session.removeAttribute("posts");
        Posts posts = postsService.selectPostsById(id);
        session.setAttribute("posts",posts);
        return "forum_02";
    }
    //保存值
    @RequestMapping(value = "/saveValue",method = RequestMethod.GET)
    @ResponseBody
    public void saveValue(@RequestParam(value = "username",defaultValue = "") String username,@RequestParam(value = "title",defaultValue = "") String title, HttpSession session){
        //有title时username就为“”，有username时title就为“”
            session.setAttribute("searchTitle",title);
            session.setAttribute("searchUsername",username);

    }
    @RequestMapping("/{page}")
    public String showPage(@PathVariable String page) {
        return page;
    }

}
