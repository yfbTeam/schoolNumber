<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysIndentifyEdit.aspx.cs" Inherits="SMWeb.InterfaceConfig.SysIndentifyEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增系统模块</title>
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
    <input type="hidden" id="hid_CurSysKey" runat="server" />    
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
                                            <td class="mi"><span class="m">系统模块名称：</span></td>
                                            <td class="ku">
                                                <input id="txt_infname" type="text" class="hu" placeholder="请输入系统模块名称" /><span class="wstar">*</span></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">系统模块key：</span></td>
                                            <td class="ku">
                                                <input id="txt_infkey" type="text" class="hu" placeholder="请输入系统模块key" /><span class="wstar">*</span></td>
                                        </tr>                                                                          
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="submit_btn">
                            <span class="Save_and_submit">
                                <input type="submit" value="确定" class="Save_and_submit" onclick="SaveSysIndentify();" /></span>
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
        var itemid = $("#<%=hid_Id.ClientID%>").val();
        if (itemid.length) {
            //为控件绑定数据
            BindDataById(itemid);
        }
    });
    function BindDataById(itemid) {
        $.ajax({
            url: "../Common.ashx",

            async: false,
            dataType: "json",
            data: {
                "PageName":"InterfaceConfig/SysIndentifyHandler.ashx",
                func: "GetSysIndentifyModelById",
                SystemKey: SystemKey,
                InfKey: InfKey,
                itemid: itemid,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#txt_infname").val(model.InfName);
                    $("#txt_infkey").val(model.InfKey);
                }
            }
        });
    }

    //保存系统模块
    function SaveSysIndentify() {
        var infname = $("#txt_infname").val().trim();
        var curinfkey = $("#txt_infkey").val().trim();
        if (!infname.length || !curinfkey.length) {
            layer.msg("请填写完整信息！");
            return;
        }
        var itemid = $("#<%=hid_Id.ClientID%>").val();
        var func = itemid.length ? "EditSysIndentify" : "AddSysIndentify";
        $.ajax({
            url:"../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName":"InterfaceConfig/SysIndentifyHandler.ashx",
                func: func,
                SystemKey: SystemKey,
                InfKey: InfKey,
                itemid: itemid,
                cursyskey: $("#<%=hid_CurSysKey.ClientID%>").val(),
                infname: infname,
                curinfkey: curinfkey,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                var result = json.result;
                if (result.errNum == -1) {
                    layer.msg("该系统模块名称已存在！");
                }
                else if (result.errNum == 0) {
                    parent.layer.msg('操作成功!');
                    parent.getData(1);
                    parent.CloseIFrameWindow();
                } else {
                    layer.msg("操作失败！");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        });
    }
</script>
</html>

