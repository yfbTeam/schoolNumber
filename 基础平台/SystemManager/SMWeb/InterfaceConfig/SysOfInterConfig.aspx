<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysOfInterConfig.aspx.cs" Inherits="SMWeb.InterfaceConfig.SysOfInterConfig" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>接口权限管理</title>
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
            <td>${Region}</td>
            <td>${SchoolName}</td>
            <td>${SystemName}</td>
            <td>${InfName}</td>
            <td>${InfKey}</td>
            <td>${InterName}</td>
            <td>${ReturnField}</td>
            <td>
                <input type="button" class="Topic_btn" value="编辑" onclick="javascript: OpenIFrameWindow('编辑权限', 'SysOfInterEdit.aspx?itemid=${Id}', '620px', '270px');" />
                <input type="button" class="Topic_btn" value="删除" onclick="javascript: DeleteSysOfInter_Rel('${Id}')" />
            </td>
        </tr>

    </script>
</head>
<body>
    <input type="hidden" id="hid_UserIDCard" runat="server" />
    <input type="hidden" id="hid_LoginName" runat="server" />
    <form id="form1" runat="server">
        <div class="Teaching_plan_management">
            <h1 class="Page_name">接口权限管理</h1>
            <div class="Operation_area">
                <div class="left_choice fl">
                    <ul>
                        <li class="Sear">
                            <input type="text" id="search_w" name="search_w" class="search_w" placeholder="请输入模块名称" value="" /><a class="sea" href="#" onclick="SearchClass();">搜索</a>
                        </li>
                    </ul>
                </div>
                <div class="right_add fr">
                    <a class="add" href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('新增权限','SysOfInterEdit.aspx', '620px', '270px');"><i class="iconfont">&#xe726;</i>新增权限</a>
                </div>
            </div>
            <div class="Honor_management">
                <table class="W_form" id="tb_UserList">
                    <thead>
                        <tr class="trth">
                            <th class="number">序号</th>
                            <th>区县</th>
                            <th>学校</th>
                            <th>系统名称</th>
                            <th>模块名称</th>
                            <th>模块key</th>
                            <th>接口名称</th>
                            <th class="Project_name">返回字段</th>
                            <th>操作</th>
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
    var sername = $("#search_w").val().trim();
    $(document).ready(function () {
        //获取数据
        getData(1);
    });
    function SearchClass() {
        sername = $("#search_w").val().trim();
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

                "PageName": "InterfaceConfig/SysOfInterRelHandler.ashx",
                func: "GetSysOfInter_RelDataPage",
                SystemKey: SystemKey,
                InfKey: InfKey,
                infname: sername,
                PageIndex: startIndex,
                PageSize: 10,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: OnSuccess,
            error: OnError
        });
    }
    function OnSuccess(json) {
        if (json.result.errNum.toString() == "100") {
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

    function DeleteSysOfInter_Rel(itemid) {
        layer.msg("确定要删除该权限？", {
            time: 0 //不自动关闭
            , btn: ['确定', '取消']
            , yes: function (index) {
                layer.close(index);
                $.ajax({
                    url: "../Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "InterfaceConfig/SysOfInterRelHandler.ashx",
                        func: "DeleteSysOfInter_Rel",
                        SystemKey: SystemKey,
                        InfKey: InfKey,
                        itemid: itemid,
                        loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                        useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            layer.msg("删除成功！");
                            getData(1);; //刷新列表
                        } else {
                            layer.msg("删除失败！");
                        }
                    },
                    //error: OnErrorDelete
                });
            }
        });
    }
</script>
</html>
