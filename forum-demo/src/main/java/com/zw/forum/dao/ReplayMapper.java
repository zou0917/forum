package com.zw.forum.dao;

import com.zw.forum.bean.Replay;
import com.zw.forum.bean.ReplayExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ReplayMapper {
    long countByExample(ReplayExample example);

    int deleteByExample(ReplayExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Replay record);

    int insertSelective(Replay record);

    List<Replay> selectByExample(ReplayExample example);

    Replay selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Replay record, @Param("example") ReplayExample example);

    int updateByExample(@Param("record") Replay record, @Param("example") ReplayExample example);

    int updateByPrimaryKeySelective(Replay record);

    int updateByPrimaryKey(Replay record);
}