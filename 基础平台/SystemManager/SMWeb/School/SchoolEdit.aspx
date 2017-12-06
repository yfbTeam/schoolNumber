<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SchoolEdit.aspx.cs" Inherits="SMWeb.School.SchoolEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>编辑学校</title>
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
                                            <td class="mi"><span class="m">学校名称：</span></td>
                                            <td class="ku">
                                                <input id="Name" type="text" class="hu" /><span class="wstar">*</span></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">学校地址：</span></td>
                                            <td class="ku">
                                                <input id="Address" type="text" class="hu" /></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">校长工号：</span></td>
                                            <td class="ku">
                                                <input id="PrincipalNumber" type="text" class="hu" /></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">校长姓名：</span></td>
                                            <td class="ku">
                                                <input id="PrincipalName" type="text" class="hu"/><span class="wstar">*</span></td>
                                        </tr>    
                                        <tr>
                                            <td class="mi"><span class="m">联系电话：</span></td>
                                            <td class="ku">
                                                <input id="Phone" type="text" class="hu"/></td>
                                        </tr>   
                                        <tr>
                                            <td class="mi"><span class="m">传真电话：</span></td>
                                            <td class="ku">
                                                <input id="Fax" type="text" class="hu"/></td>
                                        </tr>  
                                        <tr>
                                            <td class="mi"><span class="m">电子邮箱：</span></td>
                                            <td class="ku">
                                                <input id="Email" type="text" class="hu"/></td>
                                        </tr>   
                                        <tr>
                                            <td class="mi"><span class="m">主页地址：</span></td>
                                            <td class="ku">
                                                <input id="Homepage" type="text" class="hu"/></td>
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
                                <input type="submit" value="确定" class="Save_and_submit" onclick="SaveSchool();" /></span>
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

            async: false,
            dataType: "json",
            data: {
                "PageName": "SchoolHandler.ashx",
                func: "GetSchoolById",
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#Name").val(model.Name);
                    $("#Address").val(model.Address);
                    $("#PrincipalNumber").val(model.PrincipalNumber);
                    $("#PrincipalName").val(model.PrincipalName);
                    $("#Phone").val(model.Phone);
                    $("#Fax").val(model.Fax);
                    $("#Email").val(model.Email);
                    $("#Homepage").val(model.Homepage);
                    $("#Remarks").val(model.Remarks);
                }
            }
        });
    }

    //保存接口
    function SaveSchool() {
        var Name = $("#Name").val().trim();
        var Address = $("#Address").val().trim();
        var PrincipalNumber = $("#PrincipalNumber").val().trim();
        var PrincipalName = $("#PrincipalName").val().trim();
        var Phone = $("#Phone").val().trim();
        var Fax = $("#Fax").val().trim();
        var Email = $("#Email").val().trim();
        var Homepage = $("#Homepage").val().trim();
        var Remarks = $("#Remarks").val().trim();

        var Id = $("#hid_Id").val();
        var func = Id != "" ? "UpdateSchool" : "AddSchool";
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "SchoolHandler.ashx",
                func: func,
                SystemKey: SystemKey,
                InfKey: InfKey,
                Id: Id,
                Name: Name,
                Address: Address,
                PrincipalNumber: PrincipalNumber,
                PrincipalName: PrincipalName,
                Phone: Phone,
                Fax: Fax,
                Email: Email,
                Homepage: Homepage,
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

