package com.zw.forum.service;

import com.zw.forum.bean.Posts;
import com.zw.forum.bean.PostsExample;
import com.zw.forum.dao.PostsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PostsService {
    @Autowired
    PostsMapper postsMapper;


    //添加帖子
    public boolean addPost(Posts posts){
        return postsMapper.insertSelective(posts) != 0;
    }

    //查询板块帖子
    public List<Posts> selectForumPosts(String columnName){
        PostsExample postsExample = new PostsExample();
        PostsExample.Criteria criteria = postsExample.createCriteria();
        criteria.andColumnNameEqualTo(columnName);
         return postsMapper.selectByExample(postsExample);
    }
    //按照标题模糊查询
    public List<Posts> queryByTitle(String title){
        PostsExample postsExample = new PostsExample();
        PostsExample.Criteria criteria = postsExample.createCriteria();
        criteria.andTitleLike("%"+title+"%");
        return postsMapper.selectByExample(postsExample);
    }
    //  根据ID查询帖子
    public Posts selectPostsById(Integer id){
        return postsMapper.selectByPrimaryKey(id);
    }
    //查询主板块信息
    public List<Posts> selectForum(){
        List<Posts> posts = new ArrayList<Posts>();
        Posts hot = postsMapper.selectLastPostByColumnName("热点资讯");
        Posts letter = postsMapper.selectLastPostByColumnName("文学交流");
        Posts recreation = postsMapper.selectLastPostByColumnName("娱乐信息");
        Posts answer = postsMapper.selectLastPostByColumnName("问答专区");
        posts.add(hot);
        posts.add(letter);
        posts.add(recreation);
        posts.add(answer);
        return posts;
    }

    public List<Posts> queryByUserName(String username) {
        PostsExample postsExample = new PostsExample();
        PostsExample.Criteria criteria = postsExample.createCriteria();
        criteria.andUsernameEqualTo(username);
        return postsMapper.selectByExample(postsExample);
    }

    //根据ID删除
    public boolean deleteById(Integer id){
       return postsMapper.deleteByPrimaryKey(id) !=0;
    }
}
