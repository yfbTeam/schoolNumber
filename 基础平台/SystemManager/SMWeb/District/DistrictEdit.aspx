<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DistrictEdit.aspx.cs" Inherits="SMWeb.District.DistrictEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>编辑区县</title>
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
                                            <td class="mi"><span class="m">区县名称：</span></td>
                                            <td class="ku">
                                                <input id="Name" type="text" class="hu" /><span class="wstar">*</span></td>
                                        </tr>                                                                       
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="submit_btn">
                            <span class="Save_and_submit">
                                <input type="submit" value="确定" class="Save_and_submit" onclick="Save();" /></span>
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
        var itemid = $("#hid_Id").val();
        
        if (itemid.length) {
            //为控件绑定数据
            BindDataById(itemid);
            
        }
    });
    function BindDataById(Id) {
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "DistrictHandler.ashx",
                func: "GetDistrictById",
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#Name").val(model.Name);
                }
            }
        });
    }

    //保存接口
    function Save() {
        var Name = $("#Name").val().trim();
        var UserIDCard = $("#hid_UserIDCard").val().trim();
        var Id = $("#hid_Id").val();
        var func = Id != "" ? "UpdateDistrict" : "AddDistrict";
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "DistrictHandler.ashx",
                func: func,
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
                UserIDCard: UserIDCard,
                Name: Name
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

