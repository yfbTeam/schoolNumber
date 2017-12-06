<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/Empty.Master" AutoEventWireup="true" CodeBehind="EditRole.aspx.cs" Inherits="SMSWeb.UserManager.EditRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stu_css/common.css" rel="stylesheet" />
    <link href="../Stu_css/style.css" rel="stylesheet" />
    <link href="../Stu_css/iconfont.css" rel="stylesheet" />
    <link href="../Stu_css/animate.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.8.0.js"></script>
    <link href="../Scripts/Jquery.easyui/themes/metro/easyui.css" rel="stylesheet" />
    <link href="../Scripts/Jquery.easyui/themes/icon.css" rel="stylesheet" />

    <script src="../Scripts/Jquery.easyui/jquery.min.js"></script>
    <script src="../Scripts/Jquery.easyui/jquery.easyui.min.js"></script>

    <script src="../Stu_js/layer/layer.js"></script>
    <script src="../Stu_js/layer/OpenLayer.js"></script>

    <script type="text/javascript">
        //$(function () {
        //    //$('#PositionTree').tree('collapseAll');
        //    //var jsonData = $("input[id$=Hid_Json]").val();
        //    //$("#PositionTree").val(jsonData);
        //    //OL_CloserLayerAlert('新建角色成功!');
        //})
        function btnOk() {
            OL_CloseLayerIframe("1");
        }
        function onSave() {
            var nodes = $('#PositionTree').tree('getChecked');
            var s = '';
            for (var i = 0; i < nodes.length; i++) {
                if (s != '') s += ',';
                s += nodes[i].id;
            }
            document.getElementById("<%=this.PositionName.ClientID %>").value = s;

        }
    </script>
    <style type="text/css">
        .t_btn input {
            padding-top: 0px;
        }

        .btn {
            border-radius: 3px;
            border: none;
            width: 80px;
            height: 35px;
            margin-right: 20px;
            font-size: 14px;
            font-family: "微软雅黑";
            cursor: pointer;
        }

        .btn_sure {
            color: #fff;
            background: #0da6ec;
        }

            .btn_sure:hover {
                background: #0072c6;
                outline: none;
            }

        .btn_cancel {
            background: #fafafa;
            border: 1px solid #d5d5d5;
        }

            .btn_cancel:hover {
                background: #e7e7e7;
                outline: none;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div>
        <form id="form1" enctype="multipart/form-data">
            <div class="MenuDiv">
                <asp:HiddenField ID="PositionName" runat="server" />
                <asp:HiddenField ID="Hid_Json" runat="server" />
                <table class="tbEdit">

                    <tr>
                        <td class="mi">角色名称：
                        </td>
                        <td class="ku">

                            <asp:TextBox ID="TB_RoleName" runat="server"></asp:TextBox>
                            <asp:Label ID="Lab_RoleName" Visible="false" runat="server" Text="Label"></asp:Label>
                            <span style="color: red;">
                                <asp:Literal ID="Lit_xing" Text="*" runat="server"></asp:Literal>
                                <asp:RequiredFieldValidator ID="RFV_RoleName" runat="server" ControlToValidate="TB_RoleName"
                                    ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">角色权限：
                        </td>
                        <td class="ku">

                            <img id="loading" src="../images/load.gif" style="display: none;" alt="加载" />
                            <ul id="PositionTree" class="easyui-tree"></ul>
                        </td>
                    </tr>
                    <tr>

                        <td class="mi"></td>
                        <td class="ku t_btn">
                            <asp:Button ID="btnAdd" ValidationGroup="ProjectSubmit" OnClientClick="onSave();" CssClass="btn btn_sure" runat="server" OnClick="btnAdd_Click" Text="提交" />
                        </td>
                    </tr>

                </table>

            </div>
        </form>
    </div>

    <script type="text/javascript">
        //加载树

        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }


        $(document).ready(function () {
            $("#loading").show();

            var itemid = getQueryString("itemid");
            if (itemid == null) {
                FirstUrl = "GetRole.ashx";
            }
            else {
                FirstUrl = "GetRole.ashx?itemid=" + itemid;
            }


            $("#PositionTree").tree({
                checkbox: true,
                method: 'POST',
                animate: true,
                lines: true,
                url: FirstUrl,
                onLoadSuccess: function (node, data) {
                    $("#loading").hide();
                    $('#PositionTree').tree('collapseAll');
                }
            });

        })
    </script>

</asp:Content>
