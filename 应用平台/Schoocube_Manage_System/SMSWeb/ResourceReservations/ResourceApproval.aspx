<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceApproval.aspx.cs" Inherits="SMSWeb.ResourceReservations.ResourceApproval" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>审批</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <link href="/css/plan.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">

        var UrlDate = new GetUrlDate();
        $(function () {
            var ID = UrlDate.ID;
            var Type = UrlDate.approvalStutus;
            if (ID != undefined) {
                GetResourceApprovalByID(ID);//AssetManagement
                if (Type == 1) {
                    setDisable(true);
                }
            }
            else {
                $("#ApprovalPeople").val($("#HUserName").val());
            }
        })
    </script>
</head>
<body style="background: #fff;">
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HApprovalStutus" value="" />
    <input type="hidden" id="HApplicant" value="${Applicant}" />
    <input type="hidden" id="HIDCard" value="${IDCard}" />
    <%--<form id="form1">--%>
    <div class="MenuDiv">
        <table class="tbEdit">
            <tbody>
                <tr>
                    <td class="mi">
                        <span class="m">名称：</span>
                    </td>
                    <td class="ku">
                        <input name="Name" type="text" id="Name" value="" disabled="disabled">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">审核状态：
                    </td>
                    <td class="ku">
                        <select name="ApprovalStutus" class="select fl" id="ApprovalStutus">
                            <option value="0" selected="selected">待审批</option>
                            <option value="1">审批</option>
                            <option value="2">无需审批</option>
                            <option value="3">审批未通过</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="mi">审批人：</td>
                    <td class="ku">
                        <input name="ApprovalPeople" type="text" id="ApprovalPeople" value="" >
                    </td>
                </tr>
                <tr>
                    <td class="mi">审批意见：</td>
                    <td class="ku">
                        <input name="ApprovalOpinion" type="text" id="ApprovalOpinion" value="">
                    </td>
                </tr>
                <tr>
                    <td class="ku t_btn" colspan="2">
                        <input type="submit" id="submit" name="" value="提交" class="btn" onclick="AddResourceApproval()">
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <%-- </form>--%>
    <script src="/js/common.js"></script>
    <script>
        //添加数据
        function AddResourceApproval() {
            var UserName = "";
            var Name = "";
            var ApprovalText = "";
            var ApprovalStutus = "";
            var ApprovalOpinion = "";
            var ApprovalPeople = "";
            UserName = $("#HUserName").val();
            Name = $("#Name").val();
            ApprovalText = $("#ApprovalStutus option:selected").text();
            ApprovalStutus = $("#ApprovalStutus").val();
            ApprovalOpinion = $("#ApprovalOpinion").val();
            ApprovalPeople = $("#ApprovalPeople").val();
            var ID = "";
            if (UrlDate.ID != undefined) {
                ID = UrlDate.ID;
            }
            if (ApprovalStutus == "3") {
                if (ApprovalOpinion == "") {
                    layer.msg("请填写审核意见！");
                    return;
                }
            }
            if (ApprovalStutus == $("#HApprovalStutus").val()) {
                layer.msg("请改变审批状态！");
                return;
            }

            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationHandler.ashx",
                    Func: "AddResourceReservation", Id: ID, ApprovalStutus: ApprovalStutus, UserName: UserName, Name: Name, ApprovalOpinion: ApprovalOpinion, ApprovalPeople: ApprovalPeople
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        
                        getEmailInfo();
                        addSysNotice(Name, "您的内容" + ApprovalText + "!", "3", $("#HUserIdCard").val(), $("#HIDCard").val(), $("#HTeacherEmail").val(), "", UserName, $("#HApplicant").val(),0);
                        //parent.getData(1, 10);
                        parent.ApprovalReservation(1, 10, 2);
                        parent.CloseIFrameWindow();
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        $('#ApprovalStutus[name=ApprovalStutus]').change(function () {
            var status = $(this).val();
            if ($("#HApprovalStutus").val() == status) {
                $("#submit").attr("disabled", true);
            } else {
                $("#submit").attr("disabled", false);
            }
        });
        //绑定数据
        function GetResourceApprovalByID(ID) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/ResourceReservationHandler.ashx", "Func": "GetPageList", "ispage": "false", "ID": ID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function (i, n) {
                            $("#HApprovalStutus").val(n.ApprovalStutus);
                            $("#Name").val(n.Name);
                            $("#ApprovalStutus").val(n.ApprovalStutus);
                            $("#ApprovalOpinion").val(n.ApprovalOpinion);
                            $("#HIDCard").val(n.IDCard);
                            $("#HApplicant").val(n.Applicant);
                            if ($("#HApprovalStutus").val() != "1") {
                                $("#ApprovalPeople").val($("#HUserName").val());
                            } else {
                                $("#ApprovalPeople").val(n.ApprovalPeople);
                            }
                            $("#ApprovalStutus option").each(function () {
                                if ($(this).val() == n.ApprovalStutus) {
                                    $(this).attr("selected", "selected");
                                }
                            })
                        });
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

        function setDisable(value) {
            $("#ApprovalStutus").attr("disabled", value);
            $("#ApprovalOpinion").attr("disabled", value);
            $("#submit").attr("disabled", value);
        }

        function getEmailInfo() {
            var IDCard = $("#HIDCard").val();
            var Email = "";
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "Func": "GetTeacherData", "IDCard": IDCard
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        Email = json.result.retData[0].Email;
                    }
                    $("#HTeacherEmail").attr("value", Email);
                },
                error: function (request) {
                    layer.msg("操作失败");
                }
            });
        }
    </script>
</body>
</html>

