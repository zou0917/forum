
    $(function () {


        //发帖
        $("#post_btn").click(function () {
            if($("#inputTitle").val()=='' || $("#content").val()==''){
              alert("标题或内容不能为空");
              return false;
            };
            $.ajax({
                url:appPath+"forum",
                type:"POST",
                data:$("#post_form").serialize()+"&username="+$("#log_success_div p").attr("n"),
                success:function (result) {
                    if(result.code==100){//成功
                        alert("发帖成功");
                        $("#post_form")[0].reset();
                    }
                }
            })
        });

        //回帖
        $("#replay_btn").click(function () {
            if($("#log_success_div p").attr("n")==undefined){
                alert("登录后才能回复！");
                return false;
            }
            if ($("#replayText").val()==''){
                alert("内容不能为空");
                return false;
            }
            $.ajax({
                url:appPath+"replay",
                type:"POST",
                data:"&content="+$("#replayText").val()+"&username="+$("#log_success_div p").attr("n")+"&topicId="+$("#posts").attr("topic_id"),
                success:function (result) {
                    if (result.code == 100){
                        alert("回帖成功！");
                        $("#replayText").val("");
                        //刷新当前页面
                        location.reload();
                    }else if(result.msg=="未登录"){
                        alert("登录后才能回复！");
                    }else {
                        alert("回帖失败！");
                    }
                }
            });
        });

        //给搜索按钮绑定事件
        $("#searchByTitle").click(function () {
            if($("#searchInput").val()==''){
                alert("请输入内容");
                return false;
            };
            serarchValue=$("#searchInput").val();
            $.ajax({
                url:appPath+"saveValue?title="+serarchValue,
                type:"GET",
                success:function (){
                    location.href="/forum_demo/forum/5";
                }
            });
        });

    });

