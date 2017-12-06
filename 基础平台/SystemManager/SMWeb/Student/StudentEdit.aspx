<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentEdit.aspx.cs" Inherits="SMWeb.Student.StudentEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>编辑学生</title>
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
                                            <td class="mi"><span class="m">学生名称：</span></td>
                                            <td class="ku">
                                                <input id="Name" type="text" class="hu" /><span class="wstar">*</span></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">昵称：</span></td>
                                            <td class="ku">
                                                <input id="Nickname" type="text" class="hu"/></td>
                                        </tr> 
                                        <tr>
                                            <td class="mi"><span class="m">身份证号：</span></td>
                                            <td class="ku">
                                                <input id="IDCard" type="text" class="hu" /></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">用户账号：</span></td>
                                            <td class="ku">
                                                <input id="LoginName" type="text" class="hu" /></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">密码：</span></td>
                                            <td class="ku">
                                                <input id="Password" type="password" class="hu" />
                                            </td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">学校：</span></td>
                                            <td class="ku">
                                                <select id="sel_school" class="option"></select></td>
                                        </tr>    
                                        <tr>
                                            <td class="mi"><span class="m">用户状态：</span></td>
                                            <td>
                                                <input type="radio" id="State1" name="State" value="启用" checked="checked"/>启用
                                                <input type="radio" id="State2" name="State" value="禁用" />禁用
                                            </td>
                                        </tr>   
                                        <tr>
                                            <td class="mi"><span class="m">学号：</span></td>
                                            <td class="ku">
                                                <input id="SchoolNO" type="text" class="hu"/></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">性别：</span></td>
                                            <td>
                                                <input type="radio" id="Sex1" name="Sex" value="男" checked="checked"/>男
                                                <input type="radio" id="Sex2" name="Sex" value="女" />女
                                            </td>
                                        </tr>   
                                        <tr>
                                            <td class="mi"><span class="m">出生年月：</span></td>
                                            <td class="ku">
                                                <input id="Birthday" type="text" class="hu" onclick="javascript: WdatePicker();"/></td>
                                        </tr>   

                                        <tr>
                                            <td class="mi"><span class="m">照片：</span></td>
                                            <td class="ku">
                                                <input id="Photo" type="text" class="hu"/></td>
                                        </tr> 
                                        <tr>
                                            <td class="mi"><span class="m">现住址：</span></td>
                                            <td class="ku">
                                                <input id="Address" type="text" class="hu"/></td>
                                        </tr> 
                                        <tr>
                                            <td class="mi"><span class="m">联系电话：</span></td>
                                            <td class="ku">
                                                <input id="Phone" type="text" class="hu"/></td>
                                        </tr> 
                                        <tr>
                                            <td class="mi"><span class="m">备注：</span></td>
                                            <td class="ku">
                                                <input id="Remarks" type="text" class="hu"/></td>
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
        BindSchoolData();//绑定学校数据  
        if (itemid.length) {
            $("#IDCard").attr({"disabled":"disabled"});
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
                "PageName": "StudentHandler.ashx",
                func: "GetStudentById",
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#Name").val(model.Name);
                    $("#Nickname").val(model.Nickname);
                    $("#IDCard").val(model.IDCard);
                    $("#LoginName").val(model.LoginName);
                    $("#sel_school").val(model.SchoolID);
                    if (model.State=="0") {
                        $("#State1").attr("checked", true);
                        $("#State2").attr("checked", false);
                    } else {
                        $("#State1").attr("checked", false);
                        $("#State2").attr("checked", true);
                    }
                    $("#SchoolNO").val(model.SchoolNO);
                    if (model.Sex == "0") {
                        $("#Sex1").attr("checked", true);
                        $("#Sex2").attr("checked", false);
                    } else {
                        $("#Sex1").attr("checked", false);
                        $("#Sex2").attr("checked", true);
                    }
                    $("#Birthday").val(DateTimeConvert(model.Birthday));
                    $("#Photo").val(model.Photo);
                    $("#Phone").val(model.Phone);
                    $("#Address").val(model.Address);
                    $("#Password").val("123456");
                    $("#Remarks").val(model.Remarks);
                }
            }
        });
    }

    //保存接口
    function Save() {
        var Name = $("#Name").val().trim();
        var Nickname = $("#Nickname").val().trim();
        var IDCard = $("#IDCard").val().trim();
        var LoginName = $("#LoginName").val().trim();
        var SchoolID = $("#sel_school option:selected").val();
        var State = $("input:radio[name='State']:checked").val() == "启用" ? 0 : 1;
        var SchoolNO = $("#SchoolNO").val().trim();
        var Sex = $("input:radio[name='Sex']:checked").val() == "男" ? 0 : 1;
        var Birthday = $("#Birthday").val().trim();
        var Photo = $("#Photo").val().trim();
        var Phone = $("#Phone").val().trim();
        var Address = $("#Address").val().trim();
        var Remarks = $("#Remarks").val().trim();
        var Password = $("#Password").val().trim() == "123456" ? "": $("#Password").val().trim();

        var Id = $("#hid_Id").val();
        var func = Id != "" ? "UpdateStudent" : "AddStudent";
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "StudentHandler.ashx",
                func: func,
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
                Name: Name,
                Nickname: Nickname,
                IDCard: IDCard,
                LoginName: LoginName,
                SchoolID: SchoolID,
                State: State,
                SchoolNO: SchoolNO,
                Sex: Sex,
                Birthday: Birthday,
                Photo: Photo,
                Phone: Phone,
                Address: Address,
                Password: Password,
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

