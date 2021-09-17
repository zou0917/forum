package com.zw.forum.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Replay {
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    private Integer id;

    private Integer topicId;

    private String username;

    private String content;

    private Date date;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTopicId() {
        return topicId;
    }

    public void setTopicId(Integer topicId) {
        this.topicId = topicId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getDate() {

        return simpleDateFormat.format(date);
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Replay{" +
                "id=" + id +
                ", topicId=" + topicId +
                ", username='" + username + '\'' +
                ", content='" + content + '\'' +
                ", date=" + date +
                '}';
    }
}