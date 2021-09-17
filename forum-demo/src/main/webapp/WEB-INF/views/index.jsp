<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
    <%
        session.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--    引入jquety--%>
    <script src="webjars/jquery/3.3.1-1/jquery.min.js"></script>
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
        //回显主版块
        $(function () {
            $.ajax({
                url:"/forum_demo/forum",
                type:"GET",
                success:function (result) {
                    var t= $("#forum_table").find("tr:first").next().next();
                    $.each(result.extend.posts,function (index,item) {
                        if(item!=null){
                            t.find("td:last").text(item.username).prev().text(item.date);
                        }else{
                            t.find("td:last").text("无作者").prev().text("暂无帖子");
                        }
                        t=t.next();
                    })
                }
            });
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
                    <table class="table table-hover" id="forum_table">
                        <tr>
                            <th colspan="5" style="background-color:#f3f9fa">主板块</th>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td>最后发表</td>
                            <td class="font_3">作者</td>
                        </tr>
                        <tr>
                            <td class="col-md-1" >
                                <button type="button" class="btn btn-default btn-lg" >
                                    <span class="glyphicon glyphicon-comment hot" aria-hidden="true"></span>
                                </button>
                            </td>
                            <td>
                                <a class="hot"  href="${APP_PATH}/forum/1">热点资讯</a>
                                <p class="font_2">热点资讯频道。详细的热点资讯报道，提供面向全国的新闻资讯内容。</p>
                            </td>
                            <td class="font_2"></td>
                            <td class="font_2 font_3" ></td>
                        </tr>
                        <tr>
                            <td>
                                <button type="button" class="btn btn-default btn-lg">
                                    <span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
                                </button>
                            </td>
                            <td>
                                <a href="${APP_PATH}/forum/2">文学交流</a>
                                <p class="font_2">文学交流版块，交流文学知识</p>
                            </td>
                            <td class="font_2"></td>
                            <td class="font_2 font_3" ></td>
                        </tr>
                        <tr>
                            <td>
                                <button type="button" class="btn btn-default btn-lg">
                                    <span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
                                </button>
                            </td>
                            <td>
                                <a href="${APP_PATH}/forum/3">娱乐信息</a>
                                <p class="font_2">娱乐信息板块，提供游戏资讯</p>
                            </td>
                            <td class="font_2"></td>
                            <td class="font_2 font_3" ></td>
                        </tr>
                        <tr>
                            <td>
                                <button type="button" class="btn btn-default btn-lg">
                                    <span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
                                </button>
                            </td>
                            <td>
                                <a href="${APP_PATH}/forum/4">问答专区</a>
                                <p class="font_2">问答专区板块，热心网友解答</p>
                            </td>
                            <td class="font_2"></td>
                            <td class="font_2 font_3" ></td>
                        </tr>
                    </table>
                </div>
            </div>
            <jsp:include page="postCommon.jsp"/>
            <jsp:include page="footCommon.jsp"/>
    </div>
</body>
</html>
