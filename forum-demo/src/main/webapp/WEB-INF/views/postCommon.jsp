
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row">
    <div class="col-md-12">
        <div class="btn-group " role="group" >
            <button type="button" class="btn btn-primary"style="width: 80px;height: 33px;font-size: 15px;" id="post_btn">发 帖</button>
        </div>
        <div style="font-size: 15px;background-color: #ebf5f6;height: 30px; border: 1px solid #d4d4d4;margin-top: 10px; " >
            <p style="line-height: 30px;">&nbsp;&nbsp;&nbsp;快速发帖</p>
        </div>
        <div style="border: 1px solid #d4d4d4;">
            <form class="form-horizontal" id="post_form">
                <div class="form-group" style="margin-top: 5px;">
                    <div class="col-sm-2">
                        <select class="form-control" name="columnName">
                            <option value="热点资讯">热点资讯</option>
                            <option value="文学交流">文学交流</option>
                            <option value="娱乐信息">娱乐信息</option>
                            <option value="问答专区">问答专区</option>
                        </select>
                    </div>
                    <label  class="col-sm-1 control-label">标题：</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="inputTitle" name="title" placeholder="标题">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-3 control-label">内容：</label>
                    <div class="col-sm-5">
                                   <textarea  name="content" id="content" style="width: 530px;height: 115px;resize: none"></textarea>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>