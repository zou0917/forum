
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--        标题--%>
<div class="row">
    <div style="float: left">
        <img style="width: 200px;height: 80px;" src="${APP_PATH}/static/1.jpg">
    </div>
    <div  id="user_div" style="float: right">
        <div id="log_div" >
            <form id="login_form">
                <div class="form-group" style="margin-top: 5px;">
                    <label class="col-sm-3 control-label ">账号:</label>
                    <div class="col-sm-6" >
                        <input type="text" class="form-control" name="username" id="username" style="margin-left: -25px;width: 135px;" placeholder="账号">
                    </div>
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="register" >注册</button>
                </div>
                <div class="form-group" style="margin-top: -5px">
                    <label  class="col-sm-3 control-label">密码:</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" name="password" style="margin-left: -25px;width: 135px;"  placeholder="密码">
                        <span id='pwd_errorMsg' style=" color:#595959"></span>
                    </div>
                    <button type="button" class="btn btn-primary" id="login">登录</button>
                </div>
            </form>
        </div>
        <div style="float: right;" class="font_1" id="log_success_div"></div>
    </div>
</div>