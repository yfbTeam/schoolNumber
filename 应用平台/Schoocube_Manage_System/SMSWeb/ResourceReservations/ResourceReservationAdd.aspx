<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceReservationAdd.aspx.cs" Inherits="SMSWeb.ResourceReservations.ResourceReservationAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>预约信息</title>
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

            var ReSourceClassId = UrlDate.ReSourceClassId;
            if (ReSourceClassId == 27) {
                $("#Address1").show();
                $("#Address").val("");
            }
            else {
                $("#Address1").hide();
                $("#Address").val("0");

            }

            if (ID != undefined) {
                $("#btnCreate").val("编辑预约");
                GetAssetByID(ID);//AssetManagement
                var record = UrlDate.isUpdateRecords;
                if (record == "") {
                    if ($("#HUserName").val() == $("#HApplicant").val()) {
                        setDisable(false);
                    } else {
                        setDisable(true);
                    }
                }
            }
            else {
                $("#Applicant").text($("#HUserName").val());
                $("#btnCreate").val("预约");
            }
            //$("#Applicant").text($("#HUserName").val());
            if (parent.window.$("#approvalreservation").text() == "预约审批") {
                $("#trApprovalStutus").hide();
                $("#trApprovalOpinion").hide();
              
            } else {
                $("#trApprovalStutus").show();
                $("#trApprovalOpinion").show();
            }
        })
    </script>
</head>
<body style="background: #fff;">
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HApplicant" value="" />
    <div class="MenuDiv">
        <table class="tbEdit">
            <tbody>
                <tr>
                    <td class="mi">
                        预约<span class="m">事由：</span>
                    </td>
                    <td class="ku">
                        <input name="Name" type="text" id="Name" value="">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">所属学校：
                    </td>
                    <td class="ku">
                        <input name="School" type="text" id="School" value="">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">联系电话：</td>
                    <td class="ku">
                        <input name="Telephone" type="text" id="Telephone" value="">
                        <span style="color: red;">* </span>
                    </td>
                </tr>
                <tr id="Address1">
                    <td class="mi">使用场所：</td>
                    <td class="ku">
                        <input name="Address" type="text" id="Address" value="">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">预约备注：
                    </td>
                    <td class="ku">
                        <input name="Remark" type="text" id="Remark" value="">
                    </td>
                </tr>
                <tr>
                    <td class="mi">申请人：</td>
                    <td class="ku">
                        <span name="Applicant" id="Applicant"></span>
                    </td>
                </tr>
                <tr id="trApprovalStutus" style="display:none">
                    <td class="mi">审批状态：
                    </td>
                    <td class="ku">
                        <%--<input name="ApprovalStutus" type="text" id="ApprovalStutus" value="">--%>
                        <select name="ApprovalStutus" class="select fl" id="ApprovalStutus">
                            <option value="0" selected="selected">待审批</option>
                            <option value="1">审批</option>
                            <option value="2">无需审批</option>
                            <option value="3">审批未通过</option>
                        </select>
                    </td>
                </tr>
                <tr id="trApprovalOpinion" style="display:none">
                    <td class="mi">审批意见：
                    </td>
                    <td class="ku">
                        <input name="ApprovalOpinion" type="text" id="ApprovalOpinion" value="">
                    </td>
                </tr>
                <tr>
                    <td class="ku t_btn" colspan="2">
                        <input type="submit" name="" value="提交" class="btn" onclick="AddResourceReservation()" id="submit">
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <script src="/js/common.js"></script>
    <script>
        //添加数据
        function AddResourceReservation() {
            var UserName = $("#Applicant").text();
            var Name = $("#Name").val();
            var School = $("#School").val();
            var Telephone = $("#Telephone").val();
            var Address = $("#Address").val();
            var Remark = $("#Remark").val();
            var UserIdCard = $("#HUserIdCard").val();
            var ApprovalStutus = $("#ApprovalStutus").val();
            var ApprovalOpinion = $("#ApprovalOpinion").val();
            if (isNaN(Telephone)) {
                layer.alert("电话号码请输入数字！");
                $("#Telephone").focus();
                return;
            }
            var ID = "";
            if (UrlDate.ID != undefined) {
                ID = UrlDate.ID;
            }
            if (Name == "" || School == "" || Telephone == "" || Address == "") {
                layer.msg("请填写完整信息！");
            }
            else {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "ResourceReservations/ResourceReservationHandler.ashx",
                        Func: "AddResourceReservation", "Name": Name, "School": School, "Telephone": Telephone, "Address": Address, "Remark": Remark, "ApprovalStutus": ApprovalStutus, "ApprovalOpinion": ApprovalOpinion,
                        "ReSourceInfoId": UrlDate.ReSourceInfoId, "ReSourceClassId": UrlDate.ReSourceClassId, "TimeInterval": UrlDate.TimeInterval, "AppoIntmentTime": UrlDate.selectData, "ID": ID, "UserName": UserName, "UserIdCard": UserIdCard
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            parent.layer.msg('操作成功!');
                            parent.BindResourceReservation();
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
        }

        //绑定数据
        function GetAssetByID(ID) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/ResourceReservationHandler.ashx", "Func": "GetPageList", "ispage": "false", "ID": ID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function (i, n) {
                            $("#Name").val(n.Name);
                            $("#School").val(n.School);
                            $("#Telephone").val(n.Telephone);
                            $("#Address").val(n.Address);
                            $("#Remark").val(n.Remark);
                            $("#ApprovalStutus").val(n.ApprovalStutus);
                            $("#ApprovalOpinion").val(n.ApprovalOpinion);
                            $("#Applicant").text(n.Applicant);
                            $("#HApplicant").attr("value", n.Applicant);
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
            $("#Name").attr("disabled", value);
            $("#School").attr("disabled", value);
            $("#Telephone").attr("disabled", value);
            $("#Address").attr("disabled", value);
            $("#Remark").attr("disabled", value);
            $("#ApprovalStutus").attr("disabled", value);
            $("#ApprovalOpinion").attr("disabled", value);
            $("#submit").attr("disabled", value);
        }
    </script>
</body>
</html>
