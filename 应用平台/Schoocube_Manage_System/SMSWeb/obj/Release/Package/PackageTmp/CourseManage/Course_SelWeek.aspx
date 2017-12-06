<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_SelWeek.aspx.cs" Inherits="SMSWeb.CourseManage.Course_SelWeek" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>课程管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />

    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="Term.js"></script>
    <script src="../CourseMenu.js"></script>

    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td class="checkradio pr">${WeekName}</td>
            <td>${ExcWeek}</td>
            <%--<td>{{if Status==1}}启用
                {{else}}禁用
                {{/if}}</td>--%>
            <td>${CreateTime}</td>
            <td>
                <a href="javascript:;" onclick="Del(${ID})"><i class="icon icon-edit"></i>删除</a>
            </td>
        </tr>
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/coursesystem.png" /></div>
                <nav class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                       <%-- <li><a href="CourseIndex.aspx">课程首页</a></li>
                        <li><a href="CourceManage.aspx">课程管理</a></li>
                        <li><a href="MyCourceManage.aspx">我的课程</a></li>
                        <li class="active"><a href="#">选课管理</a></li>--%>
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
                        <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">
                <div class="crumbs">
                    <a id="CourseSelManage">选课管理</a>
                    <span>&gt;</span>
                    <a href="#">周设置</a>
                </div>
                <div class="newcourse_select clearfix">
                    <%--<div class="clearfix fl course_select">
                        <label for="">学年学期：</label>
                         <select name="" class="select" id="StudyTerm" onchange="getData(1, 10)">
                        </select>
                    </div>--%>
                    <%--<div class="clearfix fl course_select">
                        <label for="">课程状态：</label>
                        <select name="" class="select">
                            <option value="1">待审核</option>
                            <option value="2">审核通过</option>
                        </select>
                    </div>--%>
                    <div class="distributed fr">
                        <a href="javascript:;" onclick="Add()"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <th class="pr checkall">周次</th>
                            <th>互斥周</th>
                            <%--<th>状态</th>--%>
                            <th>创建时间</th>
                            <th>操作</th>
                        </thead>
                        <tbody id="tb_Manage">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--分页-->
        <%--<div class="page">
            <span id="pageBar"></span>
        </div>--%>
        <script src="../js/common.js"></script>
    </form>
</body>


<script type="text/javascript">
    var UrlDate = new GetUrlDate();

    $(document).ready(function () {
        $("#CourseSelManage").attr("href", UrlDate.PageName + "?ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName)

        CourceMenu();
        GetTerm();
        getData(1, 10);
    });
    var UrlDate = new GetUrlDate();

    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "CourseManage/CourseSet.ashx", "Func": "GetWeekList", PageIndex: startIndex, pageSize: pageSize, ID: UrlDate.ID },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_Manage").html(html);

                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //修改设置
    function Del(ID) {
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "CourseManage/CourseSet.ashx", func: "DelWeek", ID: ID
            },
            success: function (json) {
                var result = json.result;
                if (result.errNum == 0) {
                    layer.msg('操作成功!');
                    getData(1, 10);
                } else {
                    layer.msg(result.errMsg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        });
        //OpenIFrameWindow('修改课程', 'Course_SelAdd.aspx?ID=' + ID, '380px', '420px');
    }
    function Add() {
        OpenIFrameWindow('添加课程', 'CourceWeekAdd.aspx?ID=' + UrlDate.ID, '380px', '420px');
    }
</script>
</html>
