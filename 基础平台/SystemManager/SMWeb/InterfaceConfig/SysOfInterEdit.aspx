<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysOfInterEdit.aspx.cs" Inherits="SMWeb.InterfaceConfig.SysOfInterEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增权限</title>
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
                                            <td class="mi"><span class="m">学校：</span></td>
                                            <td class="ku">
                                                <select id="sel_school" class="option" onchange="BindSystemBySchoolId(this.value);"></select><span class="wstar">*</span>
                                            </td>
                                            <td class="mi" style="padding-left: 15px;"><span class="m">系统：</span></td>
                                            <td class="ku">
                                                <select id="sel_system" class="option" onchange="BindSysIndentityBySysId(this.value);"></select><span class="wstar">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">系统模块：</span></td>
                                            <td class="ku">
                                                <select id="sel_sysinf" class="option"></select><span class="wstar">*</span>
                                            </td>
                                            <td class="mi" style="padding-left: 15px;"><span class="m">接口：</span></td>
                                            <td class="ku">
                                                <select id="sel_inter" class="option"></select><span class="wstar">*</span>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td class="mi"><span class="m">返回字段：</span></td>
                                            <td class="ku">
                                                <input id="txt_returnfield" type="text" class="hu" placeholder="请输入返回字段" /><span class="wstar">*</span></td>
                                        </tr>                                                                                                                  
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="submit_btn">
                            <span class="Save_and_submit">
                                <input type="submit" value="确定" class="Save_and_submit" onclick="SaveSysOfInter_Rel();" /></span>
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
        } else {
            BindSchoolData("add","");//绑定学校数据  
            BindAllInterface("add","");
        }        
    });
    function BindDataById(itemid) {
        $.ajax({
            url: "/Common.ashx?",

            async: false,
            dataType: "json",
            data: {
                "PageName":"InterfaceConfig/SysOfInterRelHandler.ashx",
                func: "GetSysOfInter_RelDataPage",
                SystemKey: SystemKey,
                InfKey: InfKey,
                ispage: false,
                relid: itemid,
                PageIndex: 1,
                PageSize: 10,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                var rtndata = json.result.retData.PagedData;
                if (rtndata.length) {
                    var model = rtndata[0];
                    BindSchoolData("edit",model);//绑定学校数据  
                    BindAllInterface("edit",model);                  
                    $("#txt_returnfield").val(model.ReturnField);
                }
            }
        });
    }
    function BindSchoolData(type,model) {
        $.ajax({

            url: "../Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "SchoolHandler.ashx",
                func: "GetSchoolAll",
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
                    if (type == "add") {
                        BindSystemBySchoolId($("#sel_school").val(),"add","");
                    } else {
                        BindSystemBySchoolId(model.SchoolId,"edit",model);
                    }                                      
                }              
            }
        });
    }
    //根据学校id绑定学校下的系统
    function BindSystemBySchoolId(schoolid, type, model) {
        $.ajax({
            url: "../Common.ashx",

            async: false,
            dataType: "json",
            data: {
                "PageName": "InterfaceConfig/SystemHandler.ashx",
                func: "GetSystemDataPage",
                SystemKey: SystemKey,
                InfKey: InfKey,
                ispage: false,
                schoolid:schoolid,
                PageIndex: 1,
                PageSize: 10,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                $("#sel_system").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData.PagedData) {
                    $.each(json.result.retData.PagedData, function (i, item) {
                        var option = "<option value='" + item.SystemKey + "'>" + item.SystemName + "</option>";
                        $("#sel_system").append(option);
                    });
                    if (type == "add") {
                        BindSysIndentityBySysId($("#sel_system").val(), "add", "");
                    } else {
                        BindSysIndentityBySysId(model.SystemKey, "edit", model);
                    }
                }
            }
        });
    }
    //根据系统key绑定系统下的模块
    function BindSysIndentityBySysId(selsyskey, type, model) {
        $.ajax({
            url: "../Common.ashx",

            async: false,
            dataType: "json",
            data: {
                "PageName": "InterfaceConfig/SysIndentifyHandler.ashx",
                func: "GetSysIndentifyDataPage",
                SystemKey: SystemKey,
                InfKey: InfKey,
                selsyskey:selsyskey,
                ispage: false,
                PageIndex: 1,
                PageSize: 10,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                $("#sel_sysinf").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData.PagedData) {
                    $.each(json.result.retData.PagedData, function (i, item) {
                        var option = "<option value='" + item.Id + "'>" + item.InfName + "(" + item.InfKey + ")" + "</option>"
                        $("#sel_sysinf").append(option);
                    });
                    if (type == "edit") {
                        $("#sel_sysinf").val(model.IndentifyId);
                    }
                }                
            }
        });
    }
    //绑定所有接口
    function BindAllInterface(type, model) {
        $.ajax({
            url: "../Common.ashx",

            async: false,
            dataType: "json",
            data: {
                "PageName": "InterfaceConfig/InterfaceHandler.ashx",
                func: "GetInterfaceDataPage",
                SystemKey: SystemKey,
                InfKey: InfKey,
                ispage:false,
                PageIndex: 1,
                PageSize: 10,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                $("#sel_inter").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData.PagedData) {
                    $.each(json.result.retData.PagedData, function (i, item) {
                        var option = "<option value='" + item.Id + "'>" + item.Name + "</option>"
                        $("#sel_inter").append(option);
                    });
                    if (type == "edit") {
                        $("#sel_inter").val(model.InterfaceId);
                    }
                }                               
            }
        });
    }    
    //保存权限
    function SaveSysOfInter_Rel() {
        var infid = $("#sel_sysinf").val();
        var interid = $("#sel_inter").val();
        var returnfield = $("#txt_returnfield").val().trim();
        if (infid == null || !infid.length || interid == null || !interid.length || !returnfield.length) {
            layer.msg("请填写完整信息！");
            return;
        }
        var itemid = $("#<%=hid_Id.ClientID%>").val();
        var func = itemid.length ? "EditSysOfInter_Rel" : "AddSysOfInter_Rel";
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "InterfaceConfig/SysOfInterRelHandler.ashx",
                func: func,
                SystemKey: SystemKey,
                InfKey: InfKey,
                itemid: itemid,
                infid: infid,
                interid:interid,
                returnfield: returnfield,
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

