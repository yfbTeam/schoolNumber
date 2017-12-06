<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InterfaceEdit.aspx.cs" Inherits="SMWeb.InterfaceConfig.InterfaceEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增接口</title>
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
                                            <td class="mi"><span class="m">接口名称：</span></td>
                                            <td class="ku">
                                                <input id="txt_name" type="text" class="hu" placeholder="请输入接口名称" /><span class="wstar">*</span></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">接口描述：</span></td>
                                            <td class="ku">
                                                <input id="txt_description" type="text" class="hu" placeholder="请输入接口描述" /><span class="wstar">*</span></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">服务页面：</span></td>
                                            <td class="ku">
                                                <input id="txt_servicepage" type="text" class="hu" placeholder="请输入服务页面" /><span class="wstar">*</span></td>
                                        </tr>                                                                          
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="submit_btn">
                            <span class="Save_and_submit">
                                <input type="submit" value="确定" class="Save_and_submit" onclick="SaveInterface();" /></span>
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
                "PageName":"InterfaceConfig/InterfaceHandler.ashx",
                func: "GetInterfaceModelById",
                SystemKey: SystemKey,
                InfKey: InfKey,
                itemid: itemid,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#txt_name").val(model.Name);
                    $("#txt_description").val(model.Description);
                    $("#txt_servicepage").val(model.ServicePage);
                }
            }
        });
    }

    //保存接口
    function SaveInterface() {
        var name = $("#txt_name").val().trim();
        var description = $("#txt_description").val().trim();
        var servicepage = $("#txt_servicepage").val().trim();
        if (!name.length || !description.length || !servicepage.length) {
            layer.msg("请填写完整信息！");
            return;
        }
        var itemid = $("#<%=hid_Id.ClientID%>").val();
        var func = itemid.length ? "EditInterface" : "AddInterface";
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName":"InterfaceConfig/InterfaceHandler.ashx",
                func: func,
                SystemKey: SystemKey,
                InfKey: InfKey,
                itemid: itemid,
                name: name.trim(),
                description:description,
                servicepage:servicepage,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                var result = json.result;
                if (result.errNum == -1) {
                    layer.msg(result.errMsg);
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

