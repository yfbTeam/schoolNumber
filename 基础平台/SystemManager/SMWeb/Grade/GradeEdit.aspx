<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GradeEdit.aspx.cs" Inherits="SMWeb.Grade.GradeEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>编辑年级</title>
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
                                            <td class="mi"><span class="m">年级名称：</span></td>
                                            <td class="ku">
                                                <input id="Name" type="text" class="hu" /><span class="wstar">*</span></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">学段：</span></td>
                                            <td class="ku">
                                                <select id="Period" class="option"></select><span class="wstar">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">备注：</span></td>
                                            <td class="ku">
                                                <input id="Remarks" type="text" class="hu" /></td>
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
        BindPeriodData();//绑定学段数据  
        if (itemid.length) {
            //为控件绑定数据
            BindDataById(itemid);
            
        }
    });
    function BindPeriodData() {
        $.ajax({
            url: "../Common.ashx?Trandom=" + Math.random(),
            type: "get",
            async: false,
            dataType: "json",
            data: {
                "PageName":"PeriodHandler",
                func: "GetPeriodData",
                SystemKey: SystemKey,
                InfKey: InfKey
            },
            success: function (json) {
                $("#Period").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {
                        var option = "<option value='" + item.Id + "'>" + item.Name + "</option>"
                        $("#Period").append(option);
                    });
                }
            }
        });
    }
    function BindDataById(Id) {
        $.ajax({
            url: "../Common.ashx?Trandom=" + Math.random(),
            type: "get",
            async: false,
            dataType: "json",
            data: {
                "PageName":"GradeHandler.ashx",
                func: "GetGradeById",
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#Name").val(model.GradeName);
                    $("#Period").val(model.PeriodID);
                    $("#Remarks").val(model.Remarks);
                }
            }
        });
    }

    //保存接口
    function Save() {
        var Name = $("#Name").val().trim();
        var PeriodID = $("#Period option:selected").val();
        var Remarks = $("#Remarks").val().trim();
        var UserIDCard = $("#hid_UserIDCard").val().trim();
        var Id = $("#hid_Id").val();
        var func = Id != "" ? "UpdateGrade" : "AddGrade";
        $.ajax({
            url:  "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName":"GradeHandler.ashx",
                func: func,
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
                UserIDCard: UserIDCard,
                Name: Name,
                PeriodID: PeriodID,
                Remarks: Remarks
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

