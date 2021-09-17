<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%--    引入jquety--%>
    <script src="${APP_PATH}/webjars/jquery/3.3.1-1/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css" integrity="sha384-6pzBo3FDv/PJ8r2KRkGHifhEocL+1X2rVCTTkUfGk7/0pbek5mMa1upzvWbrUbOZ" crossorigin="anonymous">
    <%--    引入自己的css、js--%>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css_01.css"  >
    <script src="${APP_PATH}/static/index_js.js"></script>
    <script src="${APP_PATH}/static/forum_js.js"></script>
    <script type="text/javascript">
        $(function () {
            to_page_num(1);
        });
        function to_build_pages(result) {
            //console.log(result);
            $("#replays_div").empty();
            if (result.code == 100) {
                var s="style='margin-top: -4px'";
                $.each(result.extend.pageInfo.list,function (index, item) {
                    $("<table  class=\"col-md-12 table_interval\" "+s+">" +
                        "<tr><td class=\"col-md-2 table_2 table_interval_1\" > </td><td class=\"col-md-10 table_2\"style=\"border-top: 0px;\"> </td></tr>" +
                        "</table>" +
                        "<table class=\"table\" style=\"margin-top: -17px\"> <tr>" +
                        "<td class=\"col-md-2 table_2\" style=\"border-top: 0px;\">" +
                        "<div class=\"font_3 border_bottom_dashed\">" +
                        "<label >"+item.username+"</label></div>"+
                        "<div>" +
                        "<img src=\"/forum_demo/static/avatar.jpeg\" class=\"avatar\">" +
                        "</div>" +
                        "</td>" +
                        "<td class=\" table_2\"  style=\"border-top: 0px;\">" +
                        "<div class=\"border_bottom_dashed\" style=\"margin-left: 10px; \">" +
                        "<div class=\"border_bottom_dashed\" style=\" height: 30px;\" >" +
                        "<span class=\"glyphicon glyphicon-user\"></span>" +
                        "<em > 发表于："+item.date+"</em>" +
                        "</div>" +
                        "<div class=\"font_1\" style=\"height: 100px;width: 750px;\">"+item.content+ "</div>" +
                        "</div>" +
                        "</td>" +
                        "</tr>" +
                        "</table>").appendTo($("#replays_div"));
                    s="";
                })
            }else {
                $("<table class=\"table table_1\" style='margin-top: -20px;'>\n" +
                    "            <tr>\n" +
                    "                <th class=\"col-md-12 font_3\">还没有人回复，快抢沙发！</th>\n" +
                    "            </tr>\n" +
                    "        </table>").appendTo($("#replays_div"));
            }
        }
        //发送请求获取员工信息、解析数据
        function to_page_num(pn){
            $.ajax({
                url:"${APP_PATH}/replay?topicId=${param.id}",
                data:"pn="+pn,
                type:"GET",
                success:function (result){
                    to_build_pages(result);
                    build_page_num(result);
                }
            });
        }
        //分页页码
        function  build_page_num(result){
            if(result.code==200){return false;};
            //清空分页条
            $("#page_info_nums").empty();
            var previous_page = $("<li> <a href='#' aria-label='Previous'> <span aria-hidden='true'>&laquo;</span> </a> </li>")
                .click(function (){to_page_num(result.extend.pageInfo.pageNum - 1)});
            var next_page = $("<li> <a href='#' aria-label='Next'> <span aria-hidden='true'>&raquo;</span> </a></li>")
                .click(function (){to_page_num(result.extend.pageInfo.pageNum + 1)});
            var first_page = $("<li><a href='#'>首页</a></li>")
                .click(function (){to_page_num(1)});
            var last_page = $("<li><a href='#'>尾页</a></li>")
                .click(function (){to_page_num(result.extend.pageInfo.pages)});
            var navigatepageNums = result.extend.pageInfo.navigatepageNums;
            var $nav = $("<nav aria-label='Page navigation'>");
            var $ul = $("<ul class='pagination'></ul>");
            if( ! result.extend.pageInfo.hasPreviousPage){
                first_page.addClass("disabled").unbind("click");
                previous_page.addClass("disabled").unbind("click");
            }
            $ul.append(first_page).append(previous_page);
            $.each(navigatepageNums,function (index,page_number){
                var $li = $("<li><a href='#'>"+page_number+"</a></li>");
                if(page_number == result.extend.pageInfo.pageNum){
                    $li.addClass("active");
                }
                $li.click(function (){
                    to_page_num(page_number);
                });
                $ul.append($li);
            });
            if( ! result.extend.pageInfo.hasNextPage){
                last_page.addClass("disabled").unbind("click");
                next_page.addClass("disabled").unbind("click");
            }
            $ul.append(next_page).append(last_page);
            $nav.append($ul).appendTo("#page_info_nums");
        }
    </script>
    <style type="text/css">
        .table_1{
            border-top: 1px  #d4d4d4 solid;border-left: 1px  #d4d4d4 solid;border-right: 1px  #d4d4d4 solid;
        }
        .table_2{
            border-right: 1px  #d4d4d4 solid;
            border-left: 1px  #d4d4d4 solid;
        }
        .table_interval{
            margin-top: -20px; background-color:#ebf5f6;height: 4px;
        }
        .table_interval_1{
            border-top: 0px;background-color: #c5e6df
        }
        .border_bottom_solid{
            border-bottom:1px  #d4d4d4 solid;
        }
        .border_bottom_dashed{
            border-bottom:2px  #d4d4d4 dashed;
        }
        .avatar{
            width: 100px;width: 100px;margin-top: 10px;margin-left: 37px;
        }
    </style>
</head>
<body>
<jsp:include page="model.jsp"/>
<jsp:include page="myInf.jsp"/>
<div class="container">
    <jsp:include page="headCommon.jsp"/>
    <jsp:include page="searchCommon.jsp"/>
    <jsp:include page="showDataCommon.jsp"/>
        <c:if test="${sessionScope.posts.id == param.id }">
            <table class="table table_1"  topic_id="${param.id}" id="posts">
                <tr>
                    <td class="col-md-2 table_2 font_3" >[${sessionScope.posts.columnName}]</td>
                    <td class="col-md-10"><label style="margin-left: 10px;">${sessionScope.posts.title}</label></td>
                </tr>
            </table>
            <table  class="col-md-12 table_interval" >
                <tr>
                    <td class="col-md-2 table_2 table_interval_1" > </td>
                    <td class="col-md-10 table_2"style="border-top: 0px;"> </td>
                </tr>
            </table>

                <table class="table" style="margin-top: -17px">
                    <tr>
                        <td class="col-md-2 table_2" style="border-top: 0px;">
                            <div class="font_3 border_bottom_dashed"  >
                                <label>${sessionScope.posts.username}</label>
                            </div>
                            <div>
                                <img src="${APP_PATH}/static/avatar.jpeg" class="avatar">
                            </div>
                        </td>
                        <td class=" table_2"  style="border-top: 0px;">
                            <div class="border_bottom_dashed" style="margin-left: 10px; ">
                            <div class="border_bottom_dashed" style=" height: 30px;" >
                                <span class="glyphicon glyphicon-user"></span>
                                <em > 发表于：${sessionScope.posts.date} <em style="color:#007c7c;">&nbsp;[主贴]</em></em>
                            </div>
                                <div class="font_1" style="height: 100px;width: 750px;">
                                        ${sessionScope.posts.content}
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            <div id="replays_div">
            </div>
        </c:if>
    <table class="col-md-12 table_interval" id="bottom_table">
        <tbody><tr>
            <td class="col-md-2 table_2 table_interval_1 border_bottom_solid"> </td>
            <td class="col-md-10 table_2 border_bottom_solid" style="border-top: 0px;"> </td>
        </tr>
        </tbody>
    </table>
    <jsp:include page="pagingCommon.jsp"/>
    <jsp:include page="replayCommon.jsp"/>
    <jsp:include page="footCommon.jsp"/>
</div>
</body>
</html>
