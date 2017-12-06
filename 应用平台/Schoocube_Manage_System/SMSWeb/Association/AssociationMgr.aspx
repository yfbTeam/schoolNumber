<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="AssociationMgr.aspx.cs" Inherits="SMSWeb.Association.AssociationMgr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <link rel="stylesheet" href="../Stu_css/common.css" />
<link rel="stylesheet" href="../Stu_css/allst.css"/>
<link rel="stylesheet" href="../Stu_css/iconfont.css" />
<link rel="stylesheet" href="../Stu_css/list_nr.css"/>
<script src="../Stu_js/jquery-1.8.2.min.js"></script>
<script src="../Stu_js/popwin.js"></script>
<script src="../Stu_js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    function openPage(pageTitle, pageName, pageWidth, pageHeight) {
        var webUrl ="";
        popWin.showWin(pageWidth, pageHeight, pageTitle, webUrl + pageName);
    }
    function closePages() {
        $("#mask,#maskTop").fadeOut(function () {
            $(this).remove();
        });
    }
</script>
<style type="text/css">
    .btnmgr{ cursor:pointer; }
    .line {
        line-height:17px;
    }
</style>
<asp:ScriptManager ID="ScriptManager1" runat="server" > 
</asp:ScriptManager> 
<div class="writingform">
    <div class="writing_title">
        <h2>
            <span class="title_left fl">全部社团</span>
        </h2>
    </div>
    <div class="writing_form">
        <!-- 全部社团 -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True" RenderMode="Block">
            <ContentTemplate>
                <div class="zs_beizhu" style="clear:both;">
                <span style="margin-left: 20px; float: left;"><%--开放报名时间：<input type="text" class="Wdate" readonly="readonly" runat="server" id="dtStartDate" name="dtStartDate" onclick="WdatePicker();" style="width: 97px;line-height:18px;" />至<input type="text" class="Wdate" readonly="readonly" runat="server" id="dtEndDate" name="dtEndDate" onclick="    WdatePicker();" style="width: 97px;line-height:18px;" />
                    <asp:LinkButton runat="server" CssClass="btnmgr" OnClick="Sign_Click" Text="确定" />--%>
                     <a class="btnmgr" onclick="openPage('报名设置','AddAssociaeSet.aspx','530','310');return false;">报名设置</a>
                    <a class="btnmgr" onclick="openPage('发布通知','AddAssociaeNews.aspx?itemid=0','800','550');return false;">发布通知</a>
                </span>
                <span style="margin-right: 25px; float: right;">
                    <a class="btnmgr" onclick="openPage('创建社团','AddAssociaeMgr.aspx','650','310');return false;">创建社团</a>
                    <a class="btnmgr" onclick="openPage('社团类型','AddAssociaeType.aspx','530','250');return false;">社团类型</a>
                   
                </span>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="allst_list">
            <ul style="border: none; width: 100%;overflow:hidden;">
                <asp:ListView ID="LV_TermList" runat="server" OnPagePropertiesChanging="LV_TermList_PagePropertiesChanging">
                    <EmptyDataTemplate>
                        <span style="margin: auto">暂无社团，正在等待创建！</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <li>
                            <img src='<%# Eval("Attachment") %>'>
                            <h3><%# Eval("Title") %></h3>
                            <div>
                                <p><a href='AssociationShow.aspx?itemid=<%# Eval("ID") %>'>社团详情</a></p>
                                <span><a href="javascript:void(0)" onclick="openPage('编辑社团信息','AddAssociaeMgr.aspx?itemid=<%# Eval("ID") %>','650','310');return false;"><i class="iconfont">&#xe60a;</i></a></span>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:ListView>
            </ul>
            <div class="page">
                <asp:DataPager ID="DPTeacher" runat="server" PageSize="10" PagedControlID="LV_TermList">
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
        </div>
    </div>
</div>
</asp:Content>
