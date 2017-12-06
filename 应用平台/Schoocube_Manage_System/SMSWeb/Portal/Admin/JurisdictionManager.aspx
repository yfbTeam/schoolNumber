<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JurisdictionManager.aspx.cs" Inherits="SMSWeb.Portal.Admin.JurisdictionManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="/PortalCss/reset.css" rel="stylesheet" />
    <link href="//css/common.css" rel="stylesheet" />
    <link href="//css/font-awesome.min.css" rel="stylesheet" />
    <link href="//css/reset.css" rel="stylesheet" />
    <link href="//css/onlinetest.css" rel="stylesheet" />
    <link href="//PortalCss/style.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script id="tr_itemData" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${LoginName}</td>
            <td>${Name}</td>
            <td>${Email}</td>
            <td>{{if RoleType==0}}学生
                {{else}} 教师
                {{/if}}
            </td>
            <td>
                <a href="javascript:;" onclick="DeleteUser('${Id}')"><i class="icon icon-trash"></i>删除</a>
            </td>
        </tr>
    </script>
     <script id="tr_MenuData" type="text/x-jquery-tmpl">
         <li  mneuId="${Id}">
             <a href="javascript:;">${Name}
             </a>
         </li>
     </script>
</head>
<body>
    <form id="form1" runat="server">
     <div style="padding:20px;" class="clearfix">
        <input type="hidden" id="MenuId" />
            <!--内容区域-->
                <!--左边-->
            <div class="fl bordshadrad" id="sliderbox" style="width:210px;" >
                <div class="menubox">
                    <div class="aside" style="display: block;"></div>
                    <!--菜单区域-->
                    <div class="menu" id="menubox">
                        <ul id="ul_leftmenu">
                                
                        </ul>
                    </div>
                    <!--end 菜单区域-->
                </div>
            </div>
    <!--右边-->
        <div class="" style="margin-left:222px;">
            <div class="onlinetest_item">
                <div class="course_manage bordshadrad">
                    <script type="text/javascript">
                        var ptitle = getQueryString("ptitle");
                        var title = getQueryString("title");
                        document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                    </script>
                   <%--<div class="newcourse_select clearfix" style="height:50px;">
                        <div class="clearfix fl course_select">
                            <label for="">输入用户名/姓名：</label>
                            <input type="text" placeholder="输入用户名/姓名" id="Name" />
                        </div>
                        
                    </div>   --%>       
                    <div>
                        <div class="course_form_div fl">
                            <label for="">输入用户名/姓名：</label>
                            <input type="text" placeholder="输入用户名/姓名" id="Name" class="text"/>
                        </div>
                        <div class="distributed fr">
                            <a href="javascript:void(0);" onclick="javascript:OpenAddUserInfo()">添加</a>
                            <a href="javascript:void(0);" onclick="query()">查询</a>
                        </div>
                    </div> 
                   <div class="wrap">
                        <table class="PL_form">
                            <thead>
                                <tr>
                                    <th class="number">序号</th>
                                    <th>用户名</th>
                                    <th>姓名</th>
                                    <th>邮箱</th>
                                    <th>角色</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="tb_itemData"></tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="page">
                <span id="pageBar"></span>
            </div>
        </div>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            GetMenu();
        });

        function GetMenu()
        {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/PortalManage/AdminManager.ashx",
                    Func: "GetParentMenu"
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#ul_leftmenu").html('');
                        var items = json.result.retData;
                        $("#tr_MenuData").tmpl(items).appendTo("#ul_leftmenu");
                        if (items != null && items.length > 0) {
                            $("#MenuId").val(items[0].Id);
                            $("#ul_leftmenu").find('li:eq(0)').addClass('active');
                        }
                    }
                    $('#ul_leftmenu li').click(function () {
                        $(this).addClass('active').siblings().removeClass('active');
                        $("#MenuId").val($(this).attr("mneuId"));
                        getData(1, 10);
                    })
                    getData(1, 10);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function getData(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/PortalManage/AdminManager.ashx",
                    Func: "GetUserInfoList",
                    isPage: true,
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    Name: $("#Name").val(),
                    MenuId: $("#MenuId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData.PagedData;
                        $("#tb_itemData").html('');
                        $("#tr_itemData").tmpl(items).appendTo("#tb_itemData");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    } else
                    {
                        $("#tb_itemData").html('');
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function OpenAddUserInfo()
        {
            OpenIFrameWindow('修改通知', 'AddUserInfo.aspx?MenuId=' + $("#MenuId").val(), '700px', '500px');
        }

        function DeleteUser(Id) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "UpdatePortalMenuDroit",
                    IsDelete: 1,
                    Id: Id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg("操作成功！");
                        query();
                    }
                    else {
                        layer.msg("操作失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function query()
        {
            getData(1, 10);
        }
    </script>

</body>
</html>
