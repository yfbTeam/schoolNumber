<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemManager.aspx.cs" Inherits="SMWeb.InterfaceConfig.SystemManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>系统模块管理</title>
    <link href="/css/style.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <link href="/css/iconfont.css" rel="stylesheet" />
    <link href="/css/animate.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/tz_slider.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script id="trTemp" type="text/x-jquery-tmpl">
        <li name="${SystemKey}">
            <a class="Topic_click" href="#">
                <table class="W_form1">
                    <tr name="trName1">
                        <td class="number">${pageIndex()}</td>
                        <td class="erlie">${Region}</td> 
                        <td class="erlie">${SchoolName}</td> 
                        <td class="Project_name">${SystemName}</td>   
                        <td class="erlie">${SystemKey}</td>                     
                        <td>
                            <input type="button" class="Topic_btn" value="编辑" onclick="javascript: OpenIFrameWindow('编辑系统', 'SystemEdit.aspx?itemid=${Id}', '560px', '320px');" />
                            <input type="button" class="Topic_btn" value="删除" onclick="javascript: DeleteSystem('${Id}')" />
                            <input type="button" class="Topic_btn" value="新增系统模块" onclick="javascript: OpenIFrameWindow('新增系统模块', 'SysIndentifyEdit.aspx?cursyskey=${SystemKey}', '560px', '240px');" />
                        </td>
                        <td class="slidedown"><i>+</i></td>
                    </tr>
                </table>
            </a>
            <div class="Topic_con" style="display: none;">
                <table class="W_form" >
                    <thead>
                        <tr class="trth">
                            <th class="number"></th>
                            <%--<th class="number">序号</th>--%>
                            <th>模块名称</th>
                            <th>模块key</th>
                            <th>操作</th>
                            <th class="slidedown">&nbsp;&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody name="SecondList">

                    </tbody>
                </table>
            </div>
        </li>
    </script>

    <!--系统模块模板-->
    <script id="trSecondTemp" type="text/x-jquery-tmpl">
        <tr class="Single" name="trName">
            <td class="checkbox">
                </td>
            <%--<td>${pageIndex()}</td>--%>
            <td>${InfName}</td>
            <td>${InfKey}</td>
            <td >
                 <input type="button" class="Topic_btn" value="编辑" onclick="javascript: OpenIFrameWindow('编辑系统模块', 'SysIndentifyEdit.aspx?itemid=${Id}&cursyskey=${SystemKey}', '560px', '240px');" />
                 <input type="button" class="Topic_btn" value="删除" onclick="javascript: DeleteSysIndentify('${Id}')" />
            </td>
            <td class="slidedown">&nbsp;&nbsp;</td>
        </tr>
    </script>
    <!--系统模块模板-->
</head>
<body>
    <input type="hidden" id="hid_UserIDCard" runat="server" />
    <input type="hidden" id="hid_LoginName" runat="server" />
    <form id="form1" runat="server">
        <div class="Teaching_plan_management">
            <h1 class="Page_name">系统模块管理</h1>
            <div class="Operation_area">
                <div class="left_choice fl">
                    <ul>
                        <li class="Sear">
                            <input type="text" id="search_w" name="search_w" class="search_w" placeholder="请输入系统名称" value="" /><a class="sea" href="#" onclick="SearchClass();">搜索</a>
                        </li>
                    </ul>
                </div>
                <div class="right_add fr">
                    <a class="add" href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('新增系统','SystemEdit.aspx', '560px', '320px');"><i class="iconfont">&#xe726;</i>新增系统</a>
                    <a class="add" href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('系统菜单配置','SysMenuSettings.aspx', '650px', '510px');"><i class="iconfont">&#xe726;</i>系统菜单配置</a>
                </div>
            </div>
            <div class="Topic_tcon">
                <div id="slide">
                    <!--菜单区域-->
                    <table class="W_form1">
                        <tr class="trth1">
                            <th class="number">序号</th>  
                            <th class="erlie">区县</th>
                            <th class="erlie">学校</th>                          
                            <th class="Project_name">系统名称</th>
                            <th class="erlie">系统key</th>                            
                            <th>操作</th>
                            <th class="slidedown">&nbsp;&nbsp;</th>
                        </tr>
                    </table>
                    <ul class="Two_list" id="ulList">
                    </ul>
                    <!--end 菜单区域-->
                </div>
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
                "PageName": "InterfaceConfig/SystemHandler.ashx",
                func: "GetSystemDataPage",
                SystemKey: SystemKey,
                InfKey: InfKey,
                name: sername,
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
            $("#ulList").html("");
            $("#pageBar").hide();
        } else {
            $("#ulList").html("");
            $("#trTemp").tmpl(json.result.retData.PagedData).appendTo("#ulList");
            SubLevelExpand();
            $("#pageBar").show();
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
            makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
            GetSysIndentityData(1);
        }
    }
    function OnError(XMLHttpRequest, textStatus, errorThrown) {
        $("#ulList").html("");
    }
    function GetSysIndentityData(startIndex) {
        //初始化序号 
        pageNum = (startIndex - 1) * 10 + 1;
        $.ajax({
            url:"../Common.ashx",

            async: false,
            dataType: "json",
            data: {
                "PageName": "InterfaceConfig/SysIndentifyHandler.ashx",
                func: "GetSysIndentifyDataPage",
                SystemKey: SystemKey,
                InfKey: InfKey,
                PageIndex: startIndex,
                PageSize: 10,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: OnSysIndentitySuccess,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var wwli = $(this).find("[name='SecondList']");
                wwli.append("<tr><td colspan='100' text-align='center'>暂无系统模块</td></tr>");
            }
        });
    }
    function OnSysIndentitySuccess(json) {
        //加载二级列表
        if (json.result.errNum.toString() == "100") {
            return;
        } else {
            $("#ulList").children().each(function () {
                var cursyskey = $(this).attr("name");
                var wwli = $(this).find("[name='SecondList']");
                if (json.result.errNum.toString()=="0") {
                    $.each(json.result.retData.PagedData, function (i, data) {
                        if (data.SystemKey == cursyskey) {
                            $("#trSecondTemp").tmpl(data).appendTo(wwli);
                        }
                    });
                }
                if (wwli.children().length == 0) {
                    wwli.append("<tr><td colspan='100' text-align='center'>暂无系统模块</td></tr>");
                }
            });
        }
    }
    function SubLevelExpand() { //加载展开二级列表的方法
        $("#slide").find("ul.Two_list li a table tr td.slidedown").click(function () {
            var thisparent = $(this).parent().parent().parent().parent();
            thisparent.parent().toggleClass("selected").siblings().removeClass("selected");
            thisparent.next().slideToggle("fast").end().parent().siblings().find(".Topic_con")
            .addClass("animated bounceIn")
            .slideUp("fast").end().find("i").text("+");
            var t = $(this).find("i").text();
            $(this).find("i").text((t == "+" ? "-" : "+"));
        });
    }

    function DeleteSystem(itemid) {
        layer.msg("确定要删除该系统？", {
            time: 0 //不自动关闭
            , btn: ['确定', '取消']
            , yes: function (index) {
                layer.close(index);
                $.ajax({
                    url: "../Common.ashx",
        
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "InterfaceConfig/SystemHandler.ashx",
                        func: "DeleteSystem",
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
    //删除系统模块
    function DeleteSysIndentify(itemid) {
        layer.msg("确定要删除该系统模块？", {
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
                                "PageName": "InterfaceConfig/SysIndentifyHandler.ashx",
                                func: "DeleteSysIndentify",
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
