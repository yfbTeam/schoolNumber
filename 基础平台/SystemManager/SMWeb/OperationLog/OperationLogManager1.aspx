<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OperationLogManager1.aspx.cs" Inherits="SMWeb.OperationLog.OperationLogManager1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>操作日志管理</title>
    <link href="/css/style.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <link href="/css/iconfont.css" rel="stylesheet" />
    <link href="/css/animate.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${UserName}</td> 
            <td>${Module}</td> 
            <td>${Type}</td>                 
            <td>${CreateTime}</td>
        </tr>

    </script>
</head>
<body>
    <input type="hidden" id="hid_UserIDCard" runat="server" />
    <input type="hidden" id="hid_LoginName" runat="server" />
    <form id="form1" runat="server">
        <div class="Teaching_plan_management">
            <h1 class="Page_name">操作日志列表</h1>
            <div class="Operation_area">
                <div class="left_choice fl">
                    <ul>
                        <li class="Select">操作模块：
                            <select class="option" id="Module">
                                <option value=''>全部</option>
                                <option value='管理员设置'>管理员设置</option>
                                <option value='接口信息管理'>接口信息管理</option>
                                <option value='菜单管理'>菜单管理</option>
                                <option value='接口权限管理'>接口权限管理</option>
                                <option value='用户登录模块'>用户登录模块</option>
                                <option value='系统模块管理'>系统模块管理</option>
                            </select>
                        </li>
                        <li class="Select">操作：
                            <select class="option" id="Type">
                                <option value=''>全部</option>
                                <option value='删除'>删除</option>
                                <option value='添加'>添加</option>
                                <option value='修改'>修改</option>
                                <option value='查询'>查询</option>
                                <option value='登录'>登录</option>
                            </select>
                        </li>
                        <li class="Sear">
                            <%--<input type="text" id="search_w" name="search_w" class="search_w" placeholder="" value="" /><a class="sea" href="#" onclick="SearchClass();">搜索</a>--%>
                            <a class="btn1" href="#" onclick="javascript:SearchClass();">搜索</a>
                        </li>
                    </ul>
                </div>
                <div class="right_add fr">
                </div>
            </div>
            <div class="Honor_management">
                <table class="W_form" id="tb_UserList">
                    <thead>
                        <tr class="trth">
                            <th class="number">序号</th>  
                            <th class="Project_name">操作用户</th>
                            <th>模块</th>                          
                            <th>操作类型</th>
                            <th>创建时间</th>                            
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
           <!--分页页码开始-->
        <div class="paging">
            <span id="pageBar"></span>
        </div>
        <!--分页页码结束-->
        </div>        	
    </form>
</body>
<script type="text/javascript">
    var Module = "";
    var Type = "";
    $(document).ready(function () {
        //获取数据
        getData(1);
    });
    function SearchClass() {
        Module = $("#Module option:selected").val().trim();
        Type = $("#Type option:selected").val().trim();
        getData(1);
    }
    //获取数据
    function getData(startIndex) {
        //初始化序号 
        pageNum = (startIndex - 1) * 10 + 1;
        $.ajax({
            url: "../Common.ashx?Trandom=" + Math.random(),
            type: "get",
            async: false,
            dataType: "json",
            data: {
                "PageName": "LogInfoHandler.ashx",
                func: "GetLogInfoData",
                SystemKey: SystemKey,
                InfKey: InfKey,
                Module: Module,
                Type: Type,
                PageIndex: startIndex,
                PageSize: 10
            },
            success: OnSuccess,
            error: OnError
        });
    }
    function OnSuccess(json) {
        if (json.result.errNum.toString() != "0") {
            $("#tb_UserList tbody").html("<tr><td class='NoContent' colspan='100'>无内容</td></tr>");
            $("#pageBar").hide();
        } else {
            $("#tb_UserList tbody").html('');
            $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_UserList");
            //隔行变色以及鼠标移动高亮
            $(".main-bd table tbody tr").mouseover(function () {
                $(this).addClass("over");
            }).mouseout(function () {
                $(this).removeClass("over");
            })
            $(".main-bd table tbody tr:odd").addClass("alt");
            $("#pageBar").show();
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
            makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
        }
    }
    function OnError(XMLHttpRequest, textStatus, errorThrown) {
        $("#tb_UserList tbody").html("<tr><td class='NoContent' colspan='100'>无内容</td></tr>");
    }
</script>
</html>
