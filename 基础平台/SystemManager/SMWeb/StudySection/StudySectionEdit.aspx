<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudySectionEdit.aspx.cs" Inherits="SMWeb.StudySection.StudySectionEdit" %>

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
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
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
                                            <td class="mi"><span class="m">学校：</span></td>
                                            <td class="ku">
                                                <select id="sel_school" class="option"></select><span class="wstar">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">学年：</span></td>
                                            <td class="ku">
                                                <input id="Academic" type="text" class="hu" placeholder="请输入学年" /><span class="wstar">*</span></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">学期：</span></td>
                                            <td class="ku">
                                                <input id="Semester" type="text" class="hu" placeholder="请输入学期" /><span class="wstar">*</span></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">起始时间：</span></td>
                                            <td class="ku">
                                                <input id="SStartDate" type="text" class="hu" placeholder="起始时间" onclick="javascript: WdatePicker();"/><span class="wstar">*</span></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">结束时间：</span></td>
                                            <td class="ku">
                                                <input id="SEndDate" type="text" class="hu" placeholder="结束时间" onclick="javascript: WdatePicker();"/><span class="wstar">*</span></td>
                                        </tr>                                                                          
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="submit_btn">
                            <span class="Save_and_submit">
                                <input type="submit" value="确定" class="Save_and_submit" onclick="SaveStudySection();" /></span>
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
        BindSchoolData();//绑定学校数据  
        if (itemid.length) {
            //为控件绑定数据
            BindDataById(itemid);
            
        }
    });
    function BindSchoolData() {
        $.ajax({

            url: "../Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "SchoolHandler.ashx",
                func: "GetSchoolAll"
            },
            success: function (json) {
                $("#sel_school").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {
                        var option = "<option value='" + item.Id + "'>" + item.Name + "</option>"
                        $("#sel_school").append(option);
                    });
                }
            }
        });
    }
    function BindDataById(Id) {
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "StudySectionHandler.ashx",
                func: "GetStudySectionById",
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#sel_school").val(model.SchoolID);
                    $("#Academic").val(model.Academic);
                    $("#Semester").val(model.Semester);
                    $("#SStartDate").val(DateTimeConvert(model.SStartDate));
                    $("#SEndDate").val(DateTimeConvert(model.SEndDate));
                }
            }
        });
    }

    //保存接口
    function SaveStudySection() {
        var SchoolID = $("#sel_school option:selected").val();
        var Academic = $("#Academic").val().trim();
        var Semester = $("#Semester").val().trim();
        var SStartDate = $("#SStartDate").val().trim();
        var SEndDate = $("#SEndDate").val().trim();

        var Id = $("#hid_Id").val();
        var func = Id !="" ? "UpdateStudySection" : "AddStudySection";
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "StudySectionHandler.ashx",
                func: func,
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
                SchoolID: SchoolID,
                Academic: Academic,
                Semester: Semester,
                SStartDate: SStartDate,
                SEndDate: SEndDate
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

