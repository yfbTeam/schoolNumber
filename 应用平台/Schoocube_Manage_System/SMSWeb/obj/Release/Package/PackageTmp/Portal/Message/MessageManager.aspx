<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MessageManager.aspx.cs" Inherits="SMSWeb.Portal.Message.MessageManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../../css/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
     <script src="../../Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../../js/menu_top.js"></script>
    <script src="../../Scripts/My97DatePicker/WdatePicker.js"></script>

    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <script id="tr_message" type="text/x-jquery-tmpl">
        <tr>
            <td>
                <input type="checkbox" name="cbkmessage" value="${Id}" onclick="checkItem(this)" /></td>
            <td>${pageIndex()}
            </td>
            <td>${NameLengthUpdate(Title,30)}</td>
            <td>{{if Type==0}}待批改作业
                {{else Type==1}}待批试卷
                {{else Type==2}}调查问卷
                {{else Type==3}}资源审核
                {{else}}暂无
                {{/if}}
            </td>
            <td>{{if Status==0}}未读
                {{else}}已读
                {{/if}}</td>
            <td>${Creator}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
            <td>  
                 <a  href="javascript:;" onclick="javascript: OpenIFrameWindow('查看消息', 'MessageView.aspx?Id=${Id}', '700px', '65%');"><i class="icon icon-road"></i>查看</a>
              <%--  {{if Status==0}}
                
                {{/if}}--%>
                 <a  href="javascript:;" onclick="UpdateMessage('${Id}','no')"><i class="icon icon-road"></i>标识已读</a>
                 <a href="javascript:;" onclick="DeleteMessage('${Id}')"><i class="icon icon-trash"></i>删除</a>

            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <!--header-->
        
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">选择类型：</label>
                        <select name="" class="select" id="selType" onchange="getData(1, 10)">
                            <option value="">请选择类型</option>
                            <option value="0">待批改作业</option>
                            <option value="1">待批试卷</option>
                            <option value="2">调查问卷</option>
                        </select>
                        <label for="">选择状态：</label>
                        <select name="" class="select" id="selStatus" onchange="getData(1, 10)">
                            <option value="">请选择状态</option>
                            <option value="0">未读</option>
                            <option value="1">已读</option>
                        </select>


                    </div>
                     <div class="clearfix fl course_select">
                        <label for="">选择日期：</label>
                        <input type="text" class="Wdate" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" />
                        <input type="text" class="Wdate" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" />

                    </div>
                    <div class="distributed fr">
                         <a href="javascript:void(0);" onclick="query()"><i class="icon icon-plus"></i>查询</a>
                        <a href="javascript:void(0);" onclick="readerMessage('read')"><i class="icon icon-plus"></i>标记为已读</a>
                        <a href="javascript:void(0);" onclick="readerMessage('del')"><i class="icon icon-plus"></i>标记为删除</a>
                        <%--<a href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('添加消息','MessageEdit.aspx', '580px', '360px');"><i class="icon icon-plus"></i>添加</a>--%>
                    </div>
                </div>
                <div class="wrap">
                    <table class="PL_form">
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" name="cbkAllmessage" class="Check_box" onclick="checkItem(this);" /></th>
                                <th class="number">序号</th>
                                <th>标题</th>
                                <th>类型</th>
                                <th>状态</th>
                                <th>创建时间</th>
                                <th>创建人</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="tb_message"></tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            getUserInfoCookie();
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
                    PageName: "PortalManage/MessageHandler.ashx",
                    Func: "GetPageList",
                    type: $("#selType").val(),
                    Status: $("#selStatus").val(),
                    Creator: $("#HUserName").val(),
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_message").html('');
                        $("#tr_message").tmpl(json.result.retData.PagedData).appendTo("#tb_message");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_message").html("<tr><td colspan='8'>暂无系统通知！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function DeleteMessage(delid) {
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
                       data: { PageName: "PortalManage/MessageHandler.ashx", Func: "UpdateMessage", Id: delid, IsDelete: 1 },
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

        function UpdateMessage(id, noopen) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "PortalManage/MessageHandler.ashx", Func: "UpdateMessage", Id: id, Status: 1 },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (json.result.retData != "" && noopen != "no") {
                            window.location = json.result.retData;
                            return;
                        }
                    }
                    getData(1, 10);
                },
                error: function (errMsg) {
                    layer.msg('读取失败！');
                }
            });
        }

        function checkItem(obj) {
            var checkArry = $(".PL_form").find("input[type='checkbox']");
            checkAll(checkArry);
        }

        function checkAll(oInput) {
            var isCheckAll = function () {
                for (var i = 1, n = 0; i < oInput.length; i++) {
                    oInput[i].checked && n++
                }
                oInput[0].checked = n == oInput.length - 1;
            };
            //全选
            oInput[0].onchange = function () {
                for (var i = 1; i < oInput.length; i++) {
                    oInput[i].checked = this.checked
                }
                isCheckAll()
            };
            //根据复选个数更新全选框状态
            for (var i = 1; i < oInput.length; i++) {
                oInput[i].onchange = function () {
                    isCheckAll()
                }
            }
        }

        function readerMessage(param) {
            var messages = "";
            var optValDel = "";
            var optValStus = "";
            $("input[name='cbkmessage']").each(function () {
                if ($(this).is(':checked')) {
                    var vals = $(this).val();
                    messages += vals + ",";
                }
            });
            if (param == "del") {
                optValDel = 1;
            } else {
                optValStus = 1;
            }
            if (messages != "") {
                messages = messages.substring(0, messages.length - 1);
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { PageName: "PortalManage/MessageHandler.ashx", Func: "ReaderMessage", Ids: messages, IsDelete: optValDel, Status: optValStus },
                    success: function (json) {
                        if (json.result.errMsg.toString() == "success") {
                            layer.msg('更新成功！');
                        }
                        getData(1, 10);
                    },
                    error: function (errMsg) {
                        layer.msg('更新失败！');
                    }
                });
            }
        }

        function query() {
            getData(1, 10);
        }
        function getUserInfoCookie() {
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                if (UserInfo != null) {
                    $("#HUserName").val(UserInfo.LoginName);
                }
            }
        }
    </script>
</body>
</html>
