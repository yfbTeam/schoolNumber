<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FMenuInfoEdit.aspx.cs" Inherits="SMSWeb.MenuInfo.FMenuInfoEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="JS/jquery-1.11.2.min.js"></script>
    <script src="JS/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <link href="CSS/animate.css" rel="stylesheet" />
    <link href="CSS/common.css" rel="stylesheet" />
    <link href="CSS/iconfont.css" rel="stylesheet" />
    <link href="CSS/style.css" rel="stylesheet" />

</head>
<body>
    <input type="hidden" id="hid_Id" runat="server" />
    <input type="hidden" id="hid_Name" runat="server" />
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
                                            <td class="mi"><span class="m">父节点名称：</span></td>
                                            <td class="ku">
                                                <input id="txt_name" type="text" class="hu" placeholder="请输入父节点名称" /><span class="wstar">*</span></td>
                                        </tr>
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="submit_btn">
                            <span class="Save_and_submit">
                                <input type="submit" value="确定" class="Save_and_submit" onclick="SaveTeacher();" /></span>
                            <span class="cancel">
                                <input type="submit" value="取消" class="cancel" onclick="javascript: parent.CloseIFrameWindow();" /></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

<script type="text/javascript">
    //    $(document).ready(function () {
    //        if ($("#hid_id").val().trim() != "" && $("#hid_Name").val().trim() != "")
    //        {
    //            $("#txt_name").val($("#hid_Name").val());
    //        }
    //});

    //保存用户
    function SaveTeacher() {

        var name = $("#txt_name").val().trim();
        if (!name.length) {
            layer.msg("请填写完整信息！");
            return;
        }
        $.ajax({
            url: "MenuInfo.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: { Name: name, action: "Set_FMenuInfo" },
            success: function (json) {
                if (json.result == "CF") {
                    layer.msg("该父节点名称已存在！");
                }
                else if (json.result == "OK") {
                    parent.layer.msg('操作成功!');
                    parent.getData(1);
                    parent.CloseIFrameWindow();
                } else {
                    layer.msg("操作失败！");
                }
            },
            error: OnSaveError
        });

    }


    function OnSaveError(XMLHttpRequest, textStatus, errorThrown) {
        layer.msg("操作失败！");
    }
</script>
</html>
