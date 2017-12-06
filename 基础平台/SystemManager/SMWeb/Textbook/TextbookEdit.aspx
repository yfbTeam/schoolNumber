<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TextbookEdit.aspx.cs" Inherits="SMWeb.Textbook.TextbookEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>编辑教材</title>
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
                                            <td class="mi"><span class="m">教材名称：</span></td>
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
                                            <td class="mi"><span class="m">科目：</span></td>
                                            <td class="ku">
                                                <select id="Subject" class="option"></select><span class="wstar">*</span>
                                            </td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">版本：</span></td>
                                            <td class="ku">
                                                <select id="Version" class="option"></select><span class="wstar">*</span>
                                            </td>
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
        BindPeriodData();
        BindSubjectData();
        BindVersionData();
        if (itemid.length) {
            //为控件绑定数据
            BindDataById(itemid);
            
        }
    });
    //学段绑定
    function BindPeriodData() {
        $.ajax({
            type: "post",
            url: "../Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "PeriodHandler.ashx",
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
    //科目绑定
    function BindSubjectData() {
        $.ajax({
            type: "post",
            url: "../Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "SubjectHandler.ashx",
                func: "Plat_GetSubjectData"
            },
            success: function (json) {
                $("#Subject").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {
                        var option = "<option value='" + item.Id + "'>" + item.Name + "</option>"
                        $("#Subject").append(option);
                    });
                }
            }
        });
    }
    //版本绑定
    function BindVersionData() {
        $.ajax({
            type: "post",
            url: "../Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "TextbookVersionHandler.ashx?",
                func: "Plat_GetTVData"
            },
            success: function (json) {
                $("#Version").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {
                        var option = "<option value='" + item.Id + "'>" + item.Name + "</option>"
                        $("#Version").append(option);
                    });
                }
            }
        });
    }
    //获得数据
    function BindDataById(Id) {
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "TextbookHandler.ashx",
                func: "GetTextbookById",
                Id: Id,
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#Name").val(model.Name);
                    $("#Period").val(model.PeriodID);
                    $("#Subject").val(model.SubjectID);
                    $("#Version").val(model.VersionID);
                }
            }
        });
    }
    //保存接口
    function Save() {
        var Name = $("#Name").val().trim();
        var Period = $("#Period option:selected").val();
        var Subject = $("#Subject option:selected").val();
        var Version = $("#Version option:selected").val();

        var UserIDCard = $("#hid_UserIDCard").val().trim();
        var Id = $("#hid_Id").val();
        var func = Id != "" ? "UpdateTextbook" : "AddTextbook";
        $.ajax({
            url: "/Common.ashx?",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "TextbookHandler.ashx",
                func: func,
                Id: Id,
                UserIDCard: UserIDCard,
                Name: Name,
                PeriodID: Period,
                SubjectID: Subject,
                VersionID: Version
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

