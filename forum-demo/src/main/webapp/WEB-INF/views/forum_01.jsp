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
            if(${sessionScope.forumName == "搜索结果"}){
                $.ajax({
                    url:appPath+"pages?title=${sessionScope.searchTitle}",
                    type:"GET",
                    success:function (result){
                        build_posts(result);
                        build_page_num(result);
                    }
                });
            }else if(${sessionScope.forumName == "管理帖子"}){
                $.ajax({
                    url:appPath+"pages?username=${sessionScope.searchUsername}",
                    type:"GET",
                    success:function (result){
                        build_posts(result);
                        build_page_num(result);
                    }
                });
            } else {to_page_num(1);}
        });
        //发送请求获取帖子信息、解析数据
        function to_page_num(pn){
            $.ajax({
                url:"${APP_PATH}/pages?username=${sessionScope.searchUsername}&title=${sessionScope.searchTitle}",
                data:"pn="+pn,
                type:"GET",
                success:function (result){
                    build_posts(result);
                    build_page_num(result);
                }
            });
        }
        //分页页码
        function  build_page_num(result){
            if(result.code==200){return false;}
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
        function build_posts(result,flag) {
            $("#posts_table").empty();
            $("<tr><th colspan=\"5\" style=\"background-color:#f3f9fa\">"+result.msg+"</th></tr>").appendTo($("#posts_table"));
            if(result.code==200){//无帖子
                $(" <tr><th style=\"text-align: center\">还没有帖子哦,快去发帖吧！</th></tr>").appendTo($("#posts_table"));
            }else {
                if(${sessionScope.forumName == "管理帖子"}){
                    $("<tr><td></td><td class=\"col-md-8\"></td><td >发表时间</td><td class=\"font_3\">操作</td></tr>").appendTo($("#posts_table"));
                    $.each(result.extend.pageInfo.list,function (index, item) {
                        $("<tr><td class=\"col-md-1 font_1\" >["+item.columnName+"]</td><td><a href=\"/forum_demo/toForum?id="+item.id+"\">"+item.title+"</a></td><td class=\"font_2\">"+item.date+"</td><td class=\"font_2 font_3\" ><a href='#' class='deletePost' delId="+item.id+">删除</a></td></tr>").appendTo($("#posts_table"));
                    })
                }else{
                    $("<tr><td></td><td class=\"col-md-8\"></td><td >发表时间</td><td class=\"font_3\">作者</td></tr>").appendTo($("#posts_table"));
                    $.each(result.extend.pageInfo.list,function (index, item) {
                        $("<tr><td class=\"col-md-1 font_1\" >["+item.columnName+"]</td><td><a href=\"/forum_demo/toForum?id="+item.id+"\">"+item.title+"</a></td><td class=\"font_2\">"+item.date+"</td><td class=\"font_2 font_3\" >"+item.username+"</td></tr>").appendTo($("#posts_table"));
                    });
                }
            }
        }
        $(document).on("click",".deletePost",function () {
            if(confirm("确定要删除吗？")) {
                $.ajax({
                    url: "/forum_demo/forum/" + $(this).attr("delId"),
                    type:"DELETE",
                    success: function (result) {
                        if (result.code == 100) {
                            alert("删除成功");
                            //刷新当前页面
                            location.reload();
                        } else {
                            alert("删除失败");
                        }
                    }
                });
            }else {return false};
        });
    </script>
</head>
<body>
<jsp:include page="model.jsp"/>
<jsp:include page="myInf.jsp"/>
<div class="container">
    <jsp:include page="headCommon.jsp"/>
    <jsp:include page="searchCommon.jsp"/>
    <jsp:include page="showDataCommon.jsp"/>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" >
                <tbody id="posts_table"></tbody>
<%--                <tr><th colspan="5" style="background-color:#f3f9fa">${sessionScope.forumName}</th></tr>--%>
<%--
<%--                <c:if test="${!empty sessionScope.postsList}" >--%>
<%--                    <tr>--%>
<%--                        <td></td>--%>
<%--                        <td class="col-md-8"></td>--%>
<%--                        <td >发表时间</td>--%>
<%--                        <td class="font_3">作者</td>--%>
<%--                    </tr>--%>
<%--                    <c:forEach items="${sessionScope.postsList}" var="posts">--%>
<%--                        <tr>--%>
<%--                            <td class="col-md-1 font_1" >--%>
<%--                                [${posts.columnName}]--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <a href="${APP_PATH}/toForum?id=${posts.id}">${posts.title}</a>--%>
<%--                            </td>--%>
<%--                            <td class="font_2">${posts.date}</td>--%>
<%--                            <td class="font_2 font_3" >${posts.username}</td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                </c:if>--%>
<%--                <c:if test="${empty sessionScope.postsList}" >--%>
<%--                    <tr>--%>
<%--                        <th style="text-align: center">还没有帖子哦,快去发帖吧！</th>--%>
<%--                    </tr>--%>
<%--                </c:if>--%>
<%--                <c:if test="${!empty sessionScope.postsPageInfo}" >--%>
<%--                    <tr><td></td><td class="col-md-8"></td><td >发表时间</td><td class="font_3">作者</td></tr>--%>
<%--                    <c:forEach items="${sessionScope.postsPageInfo.list}" var="posts">--%>
<%--                        <tr><td class="col-md-1 font_1" >[${posts.columnName}]</td><td><a href="${APP_PATH}/toForum?id=${posts.id}">${posts.title}</a></td><td class="font_2">${posts.date}</td><td class="font_2 font_3" >${posts.username}</td></tr>--%>
<%--                    </c:forEach>--%>
<%--                </c:if>--%>
<%--                <c:if test="${empty sessionScope.postsPageInfo}" >--%>
<%--                    <tr>--%>
<%--                        <th style="text-align: center">还没有帖子哦,快去发帖吧！</th>--%>
<%--                    </tr>--%>
<%--                </c:if>--%>

            </table>
        </div>
    </div>
    <jsp:include page="pagingCommon.jsp"/>
    <jsp:include page="postCommon.jsp"/>
    <jsp:include page="footCommon.jsp"/>
</div>
</body>
</html>
