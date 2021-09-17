    var appPath="/forum_demo/";
    var serarchValue='';
    $(function () {

        $.ajax({
            url:appPath+"isLogin",
            success:function (result) {
                if(result.code ==100){//已登录
                    show_login_success(result.msg);
                }
            }
        });

        $("#login").click(function () {
            //验证账户
            to_login();

        });
        $("#register").click(function () {
            clean_form();
            //给按钮绑定调用模态窗事件
            $("#add__modal").modal({
                backdrop:"static"
            });
        });
        //用户名绑定事件
        $("#userName").change(function (){
            to_isExist_name();
        });
        //给保存注册按钮绑定事件
        $("#save_user_btn").click(function () {
            if(name_check("#userName","#name_errorMsg")==false){return false;};
            if(password_check("#password","#password_errorMsg") == false){return false};
            if (!check_rePassword()){return false};
            to_saveUser();
        });
    });
    //清空表单
    function clean_form(){
        $(".modal-body form div > input").val("");
        $(".modal-body form div span").text("");
        $(".modal-body form div").removeClass("has-success has-warning  has-error");
        $("#empName").removeAttr("name_flag");

    }
    function to_login() {
        $.ajax({
            url:"/forum_demo/user",
            type:"GET",
            data:$("#login_form").serialize(),
            success:function (result) {
                if(result.code == 100){//登录
                    $("#log_div").prop("hidden","hidden");
                    $("#log_success_div").append($("<p n="+result.msg+">"+result.msg+"，欢迎回来！</p>"))
                        .append($("<button style='position:relative;right: 0px;float: right;' type=\"button\" class=\"btn btn-default\" id=\"logout\" >注销</button>"))
                        .append($("<button style='position:relative;right: 5px;float: right;' type=\"button\" class=\"btn btn-default\" id='manage' >管理帖子</button>"));
                    return true;
                }else {
                    $("#pwd_errorMsg").text("用户名或密码错误！");
                    return false;
                }
            }
        });
    }
    //保存用户
    function to_saveUser(){
        $.ajax({
            url:"/forum_demo/user",
            type:"POST",
            data:$("#addUser_div form").serialize(),
            success:function (result) {
                alert("添加成功");
                //隐藏模态框
                $("#add__modal").modal('hide');
            }
        });
    }
    //重复密码校验
    function check_rePassword(){
        if( $("#password").val() == $("#replay_password").val()){
            show_check_msg($("#replay_password"),"true",$("#re_password_errorMsg"),"");
            return true;
        }else {
            show_check_msg($("#replay_password"),"false",$("#re_password_errorMsg"),"请输入相同的密码");
            return false
        }
    }
    //密码校验
    function password_check(ele,err_ele){
        var password = $("#password").val();
        //可以为5-16位的a-zA-Z0-9_-，
        var regPassword=/(^[a-zA-Z0-9_-]{6,18}$)/;
        if(!regPassword.test(password)){//不合法
            show_check_msg(ele,"false",err_ele,"密码由6-18位字母、下划线、数字组成");
            return false;
        }else {
            show_check_msg(ele,"true",err_ele,"");
        }
    }
    //用户名前端校验
    function name_check(ele,err_ele){
        if($(ele).attr("name_flag")=="false"){return false;}
        var name = $("#userName").val();
        //可以为2-8位中文、字符、数字、下划线组成
        var regName=/(^[\u2E80-\u9FFFa-zA-Z0-9_-]{2,8}$)/;
        if(!regName.test(name)){//不合法
            show_check_msg(ele,"false",err_ele,"用户名由2-8位中文、字符、数字、下划线组成");
            return false;
        }else {
            show_check_msg(ele,"true",err_ele,"");
            return true;
        }
    }
    //发送请求，校验用户名是否存在
    function to_isExist_name(){
        $.ajax({
            url:"/forum_demo/check/"+$("#userName").val(),
            type:"GET",
            success:function (result){
                if(result.code =="200"){//表示用户名不可用
                    $("#userName").attr("name_flag","false");
                    show_check_msg("#userName","false","#name_errorMsg","用户名已经存在");
                }else if(result.code =="100"){//表示用户名可用
                    $("#userName").attr("name_flag","true");
                    show_check_msg("#userName","true","#name_errorMsg","");
                }
            }
        });
    }
    //显示校验信息
    function show_check_msg(ele,status,ele_err,msg){
        //ele表示要设置的标签，status表示状态，成功或失败，msg表示要显示的信息 ele_err表示要显示错误信息的标签
        $(ele).parent().removeClass("has-success has-warning  has-error");
        status == "false" ?
            $(ele).parent().addClass(" has-error")
            : $(ele).parent().addClass(" has-success");
        $(ele_err).text(msg);
    }

    $(document).on("click","#manage",function () {
        $.ajax({
            url: appPath + "saveValue?username=" + $("#log_success_div p").attr("n"),
            type: "GET",
            success: function () {
                location.href = "/forum_demo/forum/6";
            }
        });
    });

    $(document).on("click","#logout",function () {
        $.ajax({
            url:"/forum_demo/logout/",
            success:function () {
                $("#log_success_div").empty();
                $("#log_div").removeAttr("hidden");
            }
        });
    });

    function show_login_success(name) {
        $("#log_div").prop("hidden","hidden");
        $("#log_success_div").append($("<p n="+name+">"+name+"，欢迎回来！</p>"))
            .append($("<button style='position:relative;right: 0px;float: right;' type=\"button\" class=\"btn btn-default\" id=\"logout\" >注销</button>"))
            .append($("<button style='position:relative;right: 5px;float: right;' type=\"button\" class=\"btn btn-default\" id='manage' >管理帖子</button>"));
    }