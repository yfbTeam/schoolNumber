<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyApplyLog.aspx.cs" Inherits="SMSWeb.Association.MyApplyLog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="../Stu_css/common.css" />
<link href="../Stu_css/allst.css" rel="stylesheet" />
<script src="../Stu_js/jquery-1.8.2.min.js"></script>
<script src="../Script/popwin.js"></script>
<script type="text/javascript">
    //$(function () {
    //    $(".Gl_tab").find("a").click(function () {
    //        var index = $(this).parent().index();
    //        $(this).parent().addClass("selected").siblings().removeClass("selected");
    //        $(this).parents(".Gl_tab").find(".tc").eq(index).show().siblings().hide();
    //    });
    //});
    function openPage(pageTitle, pageName, pageWidth, pageHeight) {
        var webUrl = _spPageContextInfo.webAbsoluteUrl;
        popWin.showWin(pageWidth, pageHeight, pageTitle, webUrl + pageName);
    }
    function closePages() {
        $("#mask,#maskTop").fadeOut(function () {
            $(this).remove();
        });
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
<asp:ScriptManager ID="ScriptManager1" runat="server" > 
</asp:ScriptManager> 
<div class="writingform">
    <div class="writing_title">
        <h2>
            <span class="title_left fl">我的申请记录</span>
        </h2>
    </div>
    <div class="writing_form">
        <div class="Gl_tab">
            <%--<div class="Gl_tabheader">
                <ul class="tab_tit">
                    <li class="selected">
                        <a href="#">社团申请</a>
                    </li>
                    <li>
                        <a href="#">活动申请</a>
                    </li>
                </ul>
            </div>--%>
            <div class="content">
                <div class="tc">  
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True" RenderMode="Block">
                        <ContentTemplate>
                            <asp:ListView ID="lvAssociae" runat="server" OnPagePropertiesChanging="lvAssociae_PagePropertiesChanging">
                                <EmptyDataTemplate>
                                    <table class="W_form">
                                        <tr class="trth">
                                            <td>暂无我的社团申请！</td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <LayoutTemplate>
                                    <table class="W_form" id="itemPlaceholderContainer">
                                        <tr class="trth">
                                            <th>社团名称
                                            </th>
                                            <th>申请类型
                                            </th>
                                            <th>申请日期
                                            </th>    
                                            <th>审核状态
                                            </th>                                        
                                            <th>操作
                                            </th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server"></tr>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr class="Single">
                                        <td>
                                            <%#Eval("Title")%>
                                        </td>
                                        <td>
                                            <%#Eval("Type")%>
                                        </td>
                                        <td>
                                            <%#Eval("Created")%>
                                        </td>
                                        <td>
                                            <%#Eval("Status")%>
                                        </td>
                                        <td>
                                        <a href="javascript:void(0)"  style="color:#00a1ec;" onclick="openPage('详情','ApplyQuitAuditing.aspx?flag=0&itemid=<%#Eval("ID")%>','560','540');return false">详情</a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:ListView>
                            <div class="page">
                                <asp:DataPager ID="AssociaePager" PageSize="10" runat="server" PagedControlID="lvAssociae">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Link" FirstPageText="首页" PreviousPageText="上一页"
                                            ShowFirstPageButton="true" ShowPreviousPageButton="true" ShowNextPageButton="false" />
                                        <asp:NumericPagerField CurrentPageLabelCssClass="number now" NumericButtonCssClass="number" />
                                        <asp:NextPreviousPagerField ButtonType="Link" NextPageText="下一页" LastPageText="末页"
                                            ShowLastPageButton="true" ShowPreviousPageButton="false" ShowNextPageButton="true" />
                                        <asp:TemplatePagerField>
                                            <PagerTemplate>
                                                <span class="page">| <%#Container.StartRowIndex/Container.PageSize+1%> /
                                   <%#(Container.TotalRowCount%Container.MaximumRows)>0?Container.TotalRowCount/Container.MaximumRows+1:Container.TotalRowCount/Container.MaximumRows %>页
                                   (共<%#Container.TotalRowCount%>项)
                                                </span>
                                            </PagerTemplate>
                                        </asp:TemplatePagerField>
                                    </Fields>
                                </asp:DataPager>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            
            </div>
        </div>
    </div>
</div>
    </div>
    </form>
</body>
</html>
