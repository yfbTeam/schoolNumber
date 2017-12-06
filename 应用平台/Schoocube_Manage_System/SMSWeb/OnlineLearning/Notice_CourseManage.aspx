<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notice_CourseManage.aspx.cs" Inherits="SMSWeb.OnlineLearning.Notice_CourseManage" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>课程通知管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/CourseMenu.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_notice" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Title}</td>
            <td>{{if IsTop==0}}<span>否</span>{{else}}<span style="color:red;">是</span>{{/if}}</td> 
            <td>${CreateTime}</td>           
            <td>
                <a href="javascript:;" onclick="javascript: OpenIFrameWindow('修改课程通知', '/OnlineLearning/Notice_CourseEdit.aspx?itemid=${Id}', '580px', '360px');"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DeleteNotice_Course('${Id}')"><i class="icon icon-road"></i>删除</a>
           </td>
        </tr>
    </script>

</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <form id="form1" runat="server">
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" /></a>
                <div class="coursesystem  fl"></div>
                <nav class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                        <%--<li><a href="/CourseManage/CourseIndex.aspx">课程首页</a></li>
                        <li><a href="/CourseManage/CourceManage.aspx">课程管理</a></li>
                        <li><a href="/CourseManage/MyCourceManage.aspx">我的课程</a></li>
                        <li><a href="#">选课管理</a></li>
                        <li class="active"><a href="#">课程通知管理</a></li>--%>
                    </ul>
                </nav>
                <div class="search_account fr clearfix">
                     <ul class="account_area fl">
                    <li>
                        <a href="javascript:;" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">3</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;" class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %></h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr ">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">
                <div class="newcourse_select clearfix">
                    <%--<div class="clearfix fl course_select">
                        <label for="">学年学期：</label>
                        <select name="" class="select" id="StudyTerm" onchange="getData(1, 10)">
                        </select>
                    </div>--%>
                    <div class="stytem_select_right fr">
                        <a href="javascript:void(0);" class="newcourse"  onclick="javascript: OpenIFrameWindow('添加课程通知','/OnlineLearning/Notice_CourseEdit.aspx?itemid=0', '580px', '360px');"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>              
                                <th>标题</th>
                                <th>是否置顶</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="tb_notice"></tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
        <script src="/js/common.js"></script>
    </form>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        CourceMenu();
        getData(1, 10);
    });
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/OnlineLearning/NoticeHandler.ashx",
                Func: "GetNotice_CourseDataPage",
                PageIndex: startIndex,
                pageSize: pageSize
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tb_notice").html('');
                    $("#tr_notice").tmpl(json.result.retData.PagedData).appendTo("#tb_notice");
                    $("#pageBar").show();
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                }
                else {
                    $("#tb_notice").html("<tr><td colspan='5'>暂无课程通知！</td></tr>");
                    $("#pageBar").hide();
                }
            },
            error: function (errMsg) {
                $("#ul_notice_course").html(errMsg);
            }
        });
    }

    function DeleteNotice_Course(delid) {
        layer.msg("确定要删除该通知?", {
            time: 0 //不自动关闭
           , btn: ['确定', '取消']
           , yes: function (index) {
               layer.close(index);
               $.ajax({
                   url: "/Common.ashx",
                   type: "post",
                   async: false,
                   dataType: "json",
                   data: { PageName: "/OnlineLearning/NoticeHandler.ashx", Func: "DeleteNotice_Course", DelId: delid },
                   success: function (json) {
                       if (json.result.errNum.toString() == "0") {
                           layer.msg("删除成功");
                           getData(1, 10);
                       }
                       else { layer.msg('删除失败！'); }
                   },
                   error: function (errMsg) {
                       layer.msg('删除失败！');
                   }
               });
           }
        });
    }
</script>
</html>
