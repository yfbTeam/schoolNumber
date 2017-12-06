<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemEdit.aspx.cs" Inherits="SMWeb.InterfaceConfig.SystemEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增系统</title>
    <link href="/css/style.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <link href="/css/iconfont.css" rel="stylesheet" />
    <link href="/css/animate.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
</head>
<body>
    <input type="hidden" id="hid_Id" runat="server" />
    <input type="hidden" id="hid_UserIDCard" runat="server" />
    <input type="hidden" id="hid_LoginName" runat="server" />
    <!--tz_dialog start-->
    <div class="yy_dialog">
        <div class="t_content">
            <div class="yy_tab">
                <div class="content">
                    <div class="tc">
                        <div class="t_message">
                            <div class="message_con">
                                <form>
                                    <table class="m_top">
                                        <tr>
                                            <td class="mi"><span class="m">区县：</span></td>
                                            <td class="ku">
                                                <input id="txt_region" type="text" class="hu" placeholder="请输入区县" /><span class="wstar">*</span></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">学校：</span></td>
                                            <td class="ku">
                                                <select id="sel_school" class="option"></select><span class="wstar">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">系统名称：</span></td>
                                            <td class="ku">
                                                <input id="txt_name" type="text" class="hu" placeholder="请输入系统名称" /><span class="wstar">*</span></td>
                                        </tr>  
                                         <tr>
                                            <td class="mi"><span class="m">系统key：</span></td>
                                            <td class="ku">
                                                <input id="txt_syskey" type="text" class="hu" placeholder="请输入系统key" /><span class="wstar">*</span></td>
                                        </tr>                                                                            
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="submit_btn">
                            <span class="Save_and_submit">
                                <input type="submit" value="确定" class="Save_and_submit" onclick="SaveSystem();" /></span>
                            <span class="cancel">
                                <input type="submit" value="取消" class="cancel" onclick="javascript: parent.CloseIFrameWindow();" /></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end tz_dialog-->

    <!--tz_yy start-->
    <div class="tz_yy"></div>
    <!--end tz_yy-->
</body>
<script type="text/javascript">
    $(document).ready(function () {
        BindSchoolData();//绑定学校数据
    });
    function BindSchoolData() {
        $.ajax({

            url:"../Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "SchoolHandler.ashx",
                func: "GetSchoolAll",
            },
            success: function (json) {
                $("#sel_school").empty();
                if (json.result.errNum.toString() != "0") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {
                        var option = "<option value='" + item.Id + "'>" + item.Name + "</option>"
                        $("#sel_school").append(option);
                    });
                }                
                var itemid = $("#<%=hid_Id.ClientID%>").val();
                if (itemid.length) {
                    $("#txt_syskey").attr("disabled", "disabled");
                    //为控件绑定数据
                    BindDataById(itemid);
                }                
            }
        });
    }
    function BindDataById(itemid) {
        $.ajax({
            url: "../Common.ashx",

            async: false,
            dataType: "json",
            data: {
                "PageName": "InterfaceConfig/SystemHandler.ashx",
                func: "GetSystemModelById",
                SystemKey: SystemKey,
                InfKey: InfKey,
                itemid: itemid,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function(json) {
                var model = json.result.retData;
                if (model.toString() != "") {                    
                    $("#txt_region").val(model.Region);
                    $("#sel_school").val(model.SchoolId);
                    $("#txt_name").val(model.SystemName);
                    $("#txt_syskey").val(model.SystemKey);
                }
            }
        });
    }
    
    //保存系统
    function SaveSystem() {        
        var region = $("#txt_region").val().trim();
        var schoolid = $("#sel_school").val();
        var sysname = $("#txt_name").val().trim();
        var syskey = $("#txt_syskey").val().trim();
        if (!region.length || schoolid == null || !schoolid.length || !sysname.length || !syskey.length) {
            layer.msg("请填写完整信息！");
            return;
        }
        var itemid = $("#<%=hid_Id.ClientID%>").val();
        var func =itemid.length ? "EditSystem" : "AddSystem";
        $.ajax({
            url:"../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "InterfaceConfig/SystemHandler.ashx",
                func: func,
                SystemKey: SystemKey,
                InfKey: InfKey,
                itemid: itemid,
                region: region,
                schoolid:schoolid,
                opersysname: sysname,
                opersyskey:syskey,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                var result = json.result;
                if (result.errNum == 0) {
                    parent.layer.msg('操作成功!');
                    parent.getData(1);
                    parent.CloseIFrameWindow();
                } else {
                    layer.msg(result.errMsg);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        });
    }
</script>
</html>

