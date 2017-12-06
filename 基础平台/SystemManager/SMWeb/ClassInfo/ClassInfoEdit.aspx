<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClassInfoEdit.aspx.cs" Inherits="SMWeb.ClassInfo.ClassInfoEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>编辑班级</title>
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
                                            <td class="mi"><span class="m">班级名称：</span></td>
                                            <td class="ku">
                                                <input id="Name" type="text" class="hu" /><span class="wstar">*</span></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">班号：</span></td>
                                            <td class="ku">
                                                <input id="ClassNO" type="text" class="hu" /></td>
                                        </tr>
                                        <!--<tr>
                                            <td class="mi"><span class="m">学校：</span></td>
                                            <td class="ku">
                                                <select id="School" class="option"></select><span class="wstar">*</span>
                                            </td>
                                        </tr>    
                                        <tr>
                                            <td class="mi"><span class="m">年级：</span></td>
                                            <td class="ku">
                                                <select id="Grade" class="option"></select><span class="wstar">*</span>
                                            </td>
                                        </tr> --> 
                                        <tr>
                                            <td class="mi"><span class="m">班主任：</span></td>
                                            <td class="ku">
                                                <!--<input id="HeadteacherNO" type="text" class="hu" />-->
                                                <select id="HeadteacherNO" class="option">
                                                    <option value="">不分配</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="tr_MonitorNO">
                                            <td class="mi"><span class="m">班长：</span></td>
                                            <td class="ku">
                                                <!--<input id="MonitorNO" type="text" class="hu" />-->
                                                <select id="MonitorNO" class="option">
                                                    <option value="">不分配</option>
                                                </select>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td class="mi"><span class="m">文理类型：</span></td>
                                            <td>
                                                <input type="radio" id="CultureScienceType0" name="CultureScienceType" value="0" checked="checked"/>不分科
                                                <input type="radio" id="CultureScienceType1" name="CultureScienceType" value="1" />文科
                                                <input type="radio" id="CultureScienceType2" name="CultureScienceType" value="2" />理科
                                            </td>
                                        </tr>     
                                        
                                        <tr>
                                            <td class="mi"><span class="m">建班年月：</span></td>
                                            <td class="ku">
                                                <input id="CreateClassDate" type="text" class="hu" onclick="javascript: WdatePicker();"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">毕业时间：</span></td>
                                            <td class="ku">
                                                <input id="GraduationDate" type="text" class="hu" onclick="javascript: WdatePicker();"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">备注：</span></td>
                                            <td class="ku">
                                                <input id="Remarks" type="text" class="hu" />
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
    var SchoolID = "0";
    var GradeID = "0";
    $(document).ready(function () {
        var itemid = $("#hid_Id").val();
        $("#tr_MonitorNO").hide();
        if (itemid != "") {
            SchoolID = parent.SchoolID;
            GradeID = parent.GradeID;
        } else {
            SchoolID = $("#School option:selected", window.parent.document).val();
            GradeID = $("#Grade option:selected", window.parent.document).val();
        }
        BindTeacher();
        $("#CreateClassDate").val(NowDate());
        if (itemid.length) {
            $("#tr_MonitorNO").show();
            BindStudent();
            //为控件绑定数据
            BindDataById(itemid);
        }
    });
    //教师绑定
    function BindTeacher() {
        $.ajax({
            url: "../Common.ashx?Trandom=" + Math.random(),
            type: "get",
            async: false,
            dataType: "json",
            data: {
                "PageName": "TeacherHandler.ashx",
                func: "GetNotHeadTeacher",
                SystemKey: SystemKey,
                InfKey: InfKey,
                SchoolID: SchoolID
            },
            success: function (json) {
                $("#HeadteacherNO").empty();
                var option = "<option value=''>不分配</option>"
                $("#HeadteacherNO").append(option);
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "999") {
                    //layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {
                        var option = "<option value='" + item.IDCard + "'>" + item.Name + "</option>"
                        $("#HeadteacherNO").append(option);
                    });
                }
            }
        });
    }
    //学生绑定
    function BindStudent() {
        $.ajax({
            url: "../Common.ashx?Trandom=" + Math.random(),
            type: "get",
            async: false,
            dataType: "json",
            data: {
                "PageName": "StudentHandler.ashx",
                func: "GetStudentData",
                SystemKey: SystemKey,
                InfKey: InfKey,
                ClassID: $("#hid_Id").val()
            },
            success: function (json) {
                $("#MonitorNO").empty();
                var option = "<option value=''>不分配</option>"
                $("#MonitorNO").append(option);
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "999") {
                    //layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {
                        var option = "<option value='" + item.IDCard + "'>" + item.Name + "</option>"
                        $("#MonitorNO").append(option);
                    });
                }
            }
        });
    }
    //获得数据
    function BindDataById(Id) {
        $.ajax({
            url: "../Common.ashx?Trandom=" + Math.random(),
            type: "get",
            async: false,
            dataType: "json",
            data: {
                "PageName": "ClassInfoHandler.ashx",
                func: "GetClassInfoById",
                Id: Id,
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#Name").val(model.ClassName);
                    $("#ClassNO").val(model.ClassNO);
                    $("#HeadteacherNO").val(model.HeadteacherNO);
                    $("#MonitorNO").val(model.MonitorNO);
                    if (model.CultureScienceType == "0") {
                        $("#CultureScienceType0").attr("checked", true);
                        $("#CultureScienceType1").attr("checked", false);
                        $("#CultureScienceType2").attr("checked", false);
                    } else if (model.CultureScienceType == "1") {
                        $("#CultureScienceType0").attr("checked", false);
                        $("#CultureScienceType1").attr("checked", true);
                        $("#CultureScienceType2").attr("checked", false);
                    } else if (model.CultureScienceType == "2") {
                        $("#CultureScienceType0").attr("checked", false);
                        $("#CultureScienceType1").attr("checked", false);
                        $("#CultureScienceType2").attr("checked", true);
                    }
                    $("#CreateClassDate").val(DateTimeConvert(model.CreateClassDate));
                    $("#GraduationDate").val(DateTimeConvert(model.GraduationDate));
                    $("#Remarks").val(model.Remarks);
                }
            }
        });
    }
    //保存接口
    function Save() {
        var Name = $("#Name").val().trim();
        var ClassNO = $("#ClassNO").val().trim();
        var HeadteacherNO = $("#HeadteacherNO").val().trim();
        var MonitorNO = $("#MonitorNO").val().trim();
        var CreateClassDate = $("#CreateClassDate").val().trim();
        var GraduationDate = $("#GraduationDate").val().trim();
        var Remarks = $("#Remarks").val().trim();
        //var SchoolID = $("#School option:selected", window.parent.document).val();
        //var GradeID = $("#Grade option:selected", window.parent.document).val();
        var CultureScienceType = $("input:radio[name='CultureScienceType']:checked").val();

        var UserIDCard = $("#hid_UserIDCard").val().trim();
        var Id = $("#hid_Id").val();

        var func = Id != "" ? "UpdateClassInfo" : "AddClassInfo";
        //if (Id != "") {
        //    SchoolID = parent.SchoolID;
        //    GradeID = parent.GradeID;
        //}
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "ClassInfoHandler.ashx",
                func: func,
                Id: Id,
                UserIDCard: UserIDCard,
                Name: Name,
                ClassNO: ClassNO,
                HeadteacherNO: HeadteacherNO,
                MonitorNO: MonitorNO,
                CreateClassDate: CreateClassDate,
                GraduationDate: GraduationDate,
                Remarks: Remarks,
                SchoolID: SchoolID,
                GradeID: GradeID,
                CultureScienceType: CultureScienceType
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
    //获取当前日期
    function NowDate() {
        var mydate = new Date();
        var str = "" + mydate.getFullYear() + "-";
        str += (mydate.getMonth() + 1) + "-";
        str += mydate.getDate();
        return str;
    }
</script>
</html>

