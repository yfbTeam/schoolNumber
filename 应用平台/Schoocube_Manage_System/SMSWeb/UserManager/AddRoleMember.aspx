<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddRoleMember.aspx.cs" Inherits="SMSWeb.UserManager.AddRoleMember" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
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
            var loginNames = $("input[id$=Hid_UserIds]").val();
            $(".ckbid").each(function () {
                var loginName = $(this).attr("userId");
                if (loginNames.indexOf("_"+loginName + "_") != -1) {
                    $(this).attr("checked", "checked");
                }
            })
            $("#ckx_head").click(function () {
                var loginNames = $("input[id$=Hid_UserIds]").val();
                $(".ckbid").each(function () {
                    var loginName = $(this).attr("userId");
                    if ($("#ckx_head").attr("checked") == "checked") {
                        $(this).attr("checked", "checked");

                        if (loginNames.indexOf("_"+loginName + "_") == -1) {
                            loginNames = loginNames + "_"+loginName + "_";
                        }
                    }
                    else {
                        $(this).removeAttr("checked");
                        if (loginNames.indexOf("_"+loginName + "_") != -1) {
                            loginNames = loginNames.replace("_"+loginName + "_", "");
                        }

                    }

                });
                $("input[id$=Hid_UserIds]").val(loginNames);
            });

            //$("#btnEnter").click(function () {
            //    var loginNames = $("input[id$=Hid_UserIds]").val();
            //    OL_CloseLayerIframe(loginNames);
            //});
            $("#btnCancel").click(function () {
                OL_CloseLayerIframe();
            });
        })
        function btnOk()
        {
            OL_CloseLayerIframe("1");
        }
        function Getid(obj) {
            var flag = $(obj).attr("checked");
            var loginNames = $("input[id$=Hid_UserIds]").val();
            var loginName = $(obj).attr("userId");
            if (flag == "checked") {
                if (loginNames.indexOf("_"+loginName + "_") == -1) {
                    loginNames = loginNames + "_"+loginName + "_";
                }
            }
            else {
                if (loginNames.indexOf("_"+loginName + "_") != -1) {
                    loginNames = loginNames.replace("_"+loginName + "_", "");
                }
            }
            $("input[id$=Hid_UserIds]").val(loginNames);

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
</head>
<body>
    <form id="form1" runat="server">


        <asp:HiddenField ID="Hid_UserIds" runat="server" Value="" />
        <asp:HiddenField ID="Hid_Flag" runat="server" />
        <div class="Mp_content">
            <div class="td" id="first">
                <div class="searchtit">
                    <asp:TextBox placeholder="请输入姓名" ID="TB_Search" runat="server" CssClass="searinput">
                
                    </asp:TextBox>
                    
                    <asp:Button ID="Btn_Search" runat="server" OnClick="Btn_Search_Click" Text="搜索" CssClass="sear" />

                </div>
                <div class="tabcontent">
                    <asp:ListView ID="LV_UserManager" runat="server" OnPagePropertiesChanging="LV_UserManager_PagePropertiesChanging">
                        <EmptyDataTemplate>
                            <div style="text-align: center;">
                                暂时没有数据
                            </div>
                        </EmptyDataTemplate>
                        <LayoutTemplate>
                            <table cellspacing="0" cellpadding="0" class="W_form">
                                <tr class="trth">
                                    <th>
                                        <input style="border: 0px solid black" type="checkbox" id="ckx_head" /></th>
                                    <th>序号</th>
                                    <th>登录名</th>
                                    <th>姓名</th>
                                    <th>性别</th>
                                    <th>邮箱</th>
                                    <%--<th>班级</th>--%>

                                </tr>
                                <tr id="itemPlaceholder" runat="server"></tr>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="Single">
                                <td>
                                    <input class="ckbid" onclick="Getid(this)" style="border: 0px solid black" type="checkbox" flag='' userId='<%#Eval("Id")%>' /></td>
                                <td><%# Container.DataItemIndex + 1%></td>
                                <td><%#Eval("LoginName")%></td>
                                <td><%#Eval("UserName")%></td>
                                <td><%#Eval("Sex")%></td>
                                <td><%#Eval("Email")%></td>
                                <%--<td><%#Eval("ClassName")%></td>--%>
                            </tr>
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                            <tr class="Double">
                                <td>
                                    <input class="ckbid" onclick="Getid(this)" style="border: 0px solid black" type="checkbox" flag='' userId='<%#Eval("Id")%>' /></td>
                                <td><%# Container.DataItemIndex + 1%></td>
                                <td><%#Eval("LoginName")%></td>
                                <td><%#Eval("UserName")%></td>
                                <td><%#Eval("Sex")%></td>
                                <td><%#Eval("Email")%></td>
                                <%--<td><%#Eval("ClassName")%></td>--%>
                            </tr>
                        </AlternatingItemTemplate>

                    </asp:ListView>

                </div>
                <div class="paging">
                    <asp:DataPager ID="DP_UserManager" runat="server" PageSize="10" PagedControlID="LV_UserManager">
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
                    <asp:Button ID="Btn_Ok" OnClick="Btn_Ok_Click" CssClass="btn btn_sure" runat="server" Text="确定" />
                    <%--<asp:Button ID="Btn_Cancel" CssClass="btn btn_cancel" runat="server" Text="取消" />
                    <input type="button" id="btnEnter" class="btn btn_sure" value="确定" />--%>
                    <input type="button" id="btnCancel" class="btn btn_cancel" value="取消" />
                </div>
            </div>

        </div>
    </form>
</body>
</html>
