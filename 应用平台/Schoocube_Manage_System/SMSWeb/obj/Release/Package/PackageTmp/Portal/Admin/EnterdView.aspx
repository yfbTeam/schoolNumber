<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnterdView.aspx.cs" Inherits="SMSWeb.Portal.Admin.EnterdView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/PortalCss/layout.css" rel="stylesheet" />
      <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
     <script src="/Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HId" runat="server" />
    <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">姓名：</label>
                            <label id="Name"></label>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">性别：</label>
                            <label id="Sex"></label>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">年龄：</label>
                            <label id="Age"></label>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">籍贯：</label>
                            <label id="Roots"></label>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">身份证号：</label>
                            <label id="IDCard"></label>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">联系电话：</label>
                            <label id="Phone"></label>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">家庭住址：</label>
                            <label id="Address"></label>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">个人简历：</label>
                            <textarea id="Job" name="content" style="width:664px;height:300px;">
                            </textarea>
                        </div>
                        <div style="clear: both"></div>
                        <div class="course_form_select clearfix" id="approval">
                            <a href="javscript:;" class="course_btn confirm_btn" onclick="Operation()" id="btnApproval">审核通过</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            initData();
        })
        function initData() {
            if ($("#HId").val() != "") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/AdminManager.ashx",
                        "func": "GetWebEntered",
                        "Id": $("#HId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null) {
                                $("#Name").html(item.Name);
                                var sex = item.Sex == 0 ? "女" : "男";
                                $("#Sex").html(sex);
                                $("#Age").html(item.Age);
                                $("#Roots").html(item.Roots);
                                $("#IDCard").html(item.IDCard);
                                $("#Phone").html(item.Phone);
                                $("#Address").html(item.Address);
                                $("#Job").html(item.Job);
                                if (item.Status == 1 || item.Status == "1") $("#approval").hide();
                            }
                        }
                    },
                    error: OnError
                });
            }
        }

        function Operation() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "UpdateWebEnterd",
                    Status: 1,
                    Id: $("#HId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg("操作成功！");
                        parent.query();
                        parent.CloseIFrameWindow();
                        
                    }
                    else {
                        layer.msg("操作失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>

</body>
</html>
