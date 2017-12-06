<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZMenuEdit.aspx.cs" Inherits="SMSWeb.Menu.ZMenuEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
     <link rel="stylesheet" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <link rel="stylesheet" href="/css/plan.css" />
    <link href="CSS/style.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="JS/jquery.tmpl.js"></script>
    <style>
        .course_form_div{margin-left:130px;}
        .course_form_div label{width:84px;}
    </style>
</head>
<body style="background:#fff;">
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="hid_MenuCode" value="" runat="server" />
        <input type="hidden" id="hid_id" value="" runat="server" />
        <input type="hidden" id="hid_Name" value="" runat="server" />
        <input type="hidden" id="hid_Pid" value="" runat="server" />
        <input type="hidden" id="hid_Url" value="" runat="server" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix pr">
                    <div class="course_form_div">
                        <label for="">子节点名称：</label>
                        <input type="text" placeholder="子节点名称" class="text" id="txt_Name" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div">
                        <label for="">子节点样式：</label>
                        <input type="text" placeholder="子节点样式" class="text" id="txt_MenuCode" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div">
                        <label for="">Url：</label>
                        <input type="text" placeholder="Url" class="text" id="txt_Url" />
                        <i class="stars"></i>
                    </div>

                </div>
                <div class="clearfix">
                    <div class="clearfix">

                        <div class="course_form_select clearfix" style="text-align:center;">
                            <a class="course_btn confirm_btn" onclick="ZMenuEdit()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
</body>

<script type="text/javascript">
    $(function () {
        $("#txt_Name").val($("#hid_Name").val());
        $("#txt_MenuCode").val($("#hid_MenuCode").val())
        $("#txt_Url").val($("#hid_Url").val())

    });


    function ZMenuEdit() {
     
        var name = $("#txt_Name").val().trim();
        var Pid = $("#hid_Pid").val();
        var id = $("#hid_id").val().trim();
        var Url = $("#txt_Url").val().trim();
        var MenuCode = $("#txt_MenuCode").val();
        if (!name.length) {
            layer.msg("请填写子节点名称！");
            return;
        }
        if (!Url.length) {
            layer.msg("请填写子节点Url！");
            return;
        }
       
        $.ajax({
            url: "Menu.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: { Name: name, id: id, Pid: Pid, Url: Url, MenuCode: MenuCode, action: "ZMenuEdit" },
            success: function (json) {
                if (json.result == "CF") {
                    layer.msg("该子节点名称已存在！");
                }
                else if (json.result == "OK") {
                    parent.layer.msg('操作成功!');
                    parent.GetLayersAndRoomsById(Pid);
                    parent.CloseIFrameWindow();
                } else {
                    layer.msg("操作失败！");
                }
            },
            error: function (errMsg) {
                alert("操作失败");
            }
        });


    }


</script>

</html>
