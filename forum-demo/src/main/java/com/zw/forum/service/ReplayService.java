package com.zw.forum.service;

import com.zw.forum.bean.Replay;
import com.zw.forum.bean.ReplayExample;
import com.zw.forum.dao.ReplayMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplayService {
    @Autowired
    ReplayMapper replayMapper;
    //添加回帖
    public boolean addReplay(Replay replay){
        return replayMapper.insertSelective(replay) != 0;
    }
    //查询回帖
    public List<Replay> selectReplays(Integer topicId){
        ReplayExample replayExample = new ReplayExample();
        ReplayExample.Criteria criteria = replayExample.createCriteria();
        criteria.andTopicIdEqualTo(topicId);
        return replayMapper.selectByExample(replayExample);

    }
}
