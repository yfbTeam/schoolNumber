<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="SMSWeb.UserManager.UserInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stu_css/common.css" rel="stylesheet" />
    <link href="../Stu_css/style.css" rel="stylesheet" />
    <link href="../Stu_css/iconfont.css" rel="stylesheet" />
    <link href="../Stu_css/animate.css" rel="stylesheet" />
    <link href="../Stu_css/layout.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.8.0.js"></script>
    <script src="../Stu_js/layer/layer.js"></script>
    <script src="../Stu_js/layer/OpenLayer.js"></script>
    
    <script type="text/javascript">

        $(function () {
            //var loginNames = $("input[id$=Hid_LoginNames]").val();
            //$(".ckbid").each(function () {
            //    var loginName = $(this).attr("loginName");
            //    if (loginNames.indexOf(loginName + "_") != -1) {
            //        $(this).attr("checked", "checked");
            //    }
            //})
            //$("#ckx_head").click(function () {
            //    var loginNames = $("input[id$=Hid_LoginNames]").val();
            //    $(".ckbid").each(function () {
            //        var loginName = $(this).attr("loginName");
            //        if ($("#ckx_head").attr("checked") == "checked") {
            //            $(this).attr("checked", "checked");

            //            if (loginNames.indexOf(loginName + "_") == -1) {
            //                loginNames = loginNames + loginName + "_";
            //            }
            //        }
            //        else {
            //            $(this).removeAttr("checked");
            //            if (loginNames.indexOf(loginName + "_") != -1) {
            //                loginNames = loginNames.replace(loginName + "_", "");
            //            }

            //        }

            //    });
            //    $("input[id$=Hid_LoginNames]").val(loginNames);
            //});
            //function AddRole() {
            //    var url = FirstUrl + "SitePages/AddRole.aspx";
            //    //openDialog(url, 420, 300, closeCallback);


            //}
            $("#btnEnter").click(function () {

                OL_ShowLayer(2, "新建用户", 520, 500, "AddUser.aspx", function (returnVal) {
                    if (returnVal == "1") {
                        window.location.href = location.href;
                    }
                });
                return false;
            });
            $("#btnCancel").click(function () {
                OL_ShowLayer(2, "导入用户", 580, 480, "ExportUser.aspx", function (returnVal) {
                    if (returnVal == "1") {
                        window.location.href = location.href;
                    }
                });
                return false;
            });
        })
        function Getid(obj) {
            var flag = $(obj).attr("checked");
            var loginNames = $("input[id$=Hid_LoginNames]").val();
            var loginName = $(obj).attr("loginName");
            if (flag == "checked") {
                if (loginNames.indexOf(loginName + "_") == -1) {
                    loginNames = loginNames + loginName + "_";
                }
            }
            else {
                if (loginNames.indexOf(loginName + "_") != -1) {
                    loginNames = loginNames.replace(loginName + "_", "");
                }
            }
            $("input[id$=Hid_LoginNames]").val(loginNames);

        }
        function remove()
        {
            return confirm('你确定要删除该用户吗？');
        }
    </script>
    <style>
        .GetId input {
            border: 0px solid black;
        }

        .searchtit {
            height: 50px;
            line-height: 50px;
            height: 25px;
            line-height: 25px;
        }

            .searchtit input[type='submit'] {
                margin-left: 10px;
                height: 30px;
                line-height: 30px;
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
    <asp:HiddenField ID="Hid_LoginNames" runat="server" />
    <asp:HiddenField ID="Hid_Flag" runat="server" />
    <div class="Mp_content">
        <div class="td" id="first">
            <div class="searchtit">
                <asp:TextBox placeholder="请输入姓名" ID="TB_Search" runat="server" CssClass="searinput">
                
                </asp:TextBox>
                
                <asp:Button ID="Btn_Search" runat="server" OnClick="Btn_Search_Click" Text="搜索" CssClass="sear" />

            </div>
            <div class="tabcontent">
                <asp:ListView ID="LV_UserInfo" runat="server" OnPagePropertiesChanging="LV_UserInfo_PagePropertiesChanging">
                    <EmptyDataTemplate>
                        <div style="text-align: center;">
                            暂时没有数据
                        </div>
                    </EmptyDataTemplate>
                    <LayoutTemplate>
                        <table cellspacing="0" cellpadding="0" class="W_form">
                            <tr class="trth">
                                <%--<th>
                                    <input style="border: 0px solid black" type="checkbox" id="ckx_head" /></th>--%>
                                <th>序号</th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>邮箱</th>
                                <th>操作</th>

                            </tr>
                            <tr id="itemPlaceholder" runat="server"></tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr class="Single">
                            <%--<td>
                                <input class="ckbid" onclick="Getid(this)" style="border: 0px solid black" type="checkbox" flag='' loginname='<%#Eval("Id")%>' /></td>--%>
                            <td><%# Container.DataItemIndex + 1%></td>
                            <td><%#Eval("UserName")%></td>
                            <td><%#Eval("Sex")%></td>
                            <td><%#Eval("Email")%></td>
                            <td>
                                <asp:Button ID="Btn_Del" OnClientClick="return confirm('你确定要删除该用户吗?')" CommandArgument='<%#Eval("Id")%>' runat="server" Text="删除" OnClick="Btn_Del_Click" /></td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr class="Double">
                            <%--<td>
                                <input class="ckbid" onclick="Getid(this)" style="border: 0px solid black" type="checkbox" flag='' loginname='<%#Eval("Id")%>' /></td>--%>
                            <td><%# Container.DataItemIndex + 1%></td>
                            <td><%#Eval("UserName")%></td>
                            <td><%#Eval("Sex")%></td>
                            <td><%#Eval("Email")%></td>
                            <td>
                                <asp:Button ID="Btn_Del" OnClientClick="return confirm('你确定要删除该用户吗?')" CommandArgument='<%#Eval("Id")%>' runat="server" Text="删除" OnClick="Btn_Del_Click" /></td>
                        </tr>
                    </AlternatingItemTemplate>

                </asp:ListView>

            </div>
            <div class="paging">
                <asp:DataPager ID="DP_UserInfo" runat="server" PageSize="10" PagedControlID="LV_UserInfo">
                    <Fields>
                        <asp:NextPreviousPagerField
                            ButtonType="Link" ShowNextPageButton="False" ShowPreviousPageButton="true"
                            ShowFirstPageButton="true" FirstPageText="首页" PreviousPageText="上一页" />

                        <asp:NumericPagerField CurrentPageLabelCssClass="number now" NumericButtonCssClass="number" />

                        <asp:NextPreviousPagerField
                            ButtonType="Link" ShowPreviousPageButton="False" ShowNextPageButton="true"
                            ShowLastPageButton="true" LastPageText="末页" NextPageText="下一页" />

                        <asp:TemplatePagerField>
                            <PagerTemplate>
                                <span class="page">| <%# Container.StartRowIndex / Container.PageSize + 1%> / 
                            <%# (Container.TotalRowCount % Container.MaximumRows) > 0 ? Convert.ToInt16(Container.TotalRowCount / Container.MaximumRows) + 1 : Container.TotalRowCount / Container.MaximumRows%>  页
                            (共<%# Container.TotalRowCount %>项)
                                </span>
                            </PagerTemplate>
                        </asp:TemplatePagerField>
                    </Fields>
                </asp:DataPager>
            </div>
            <div class="t_btn" style="text-align: center; margin-top: 30px;">

                <input type="button" id="btnEnter" class="btn btn_sure" value="添加用户" />
                <input type="button" id="btnCancel" class="btn btn_sure" value="导入用户" />
            </div>
        </div>

    </div>
</asp:Content>
