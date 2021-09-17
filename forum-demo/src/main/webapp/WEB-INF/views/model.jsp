<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/31
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 添加模态框 -->
<div class="modal fade" id="add__modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">注册账号</h4>
            </div>
            <div class="modal-body" id="addUser_div">
                <%--                添加表单--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">账号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="username" id="userName" placeholder="账号">
                            <span id='name_errorMsg' style=" color:#595959"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">密码：</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" name="password" id="password" placeholder="密码">
                            <span id='password_errorMsg' style=" color:#595959"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">确认密码：</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control"  id="replay_password" placeholder="确认密码">
                            <span id='re_password_errorMsg' style=" color:#595959"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
                <button type="button" class="btn btn-primary" id="save_user_btn">注册</button>
            </div>
        </div>
    </div>
</div>