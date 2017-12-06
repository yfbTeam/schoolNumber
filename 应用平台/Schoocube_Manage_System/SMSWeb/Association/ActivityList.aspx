<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="ActivityList.aspx.cs" Inherits="SMSWeb.Association.ActivityList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Stu_css/common.css" rel="stylesheet" />
<link href="../Stu_css/allst.css" rel="stylesheet" />
<link href="../Style/iconfont.css" rel="stylesheet" />
<link rel="stylesheet" href="../Stu_css/list_nr.css"/>
<style type="text/css">    
    .line {line-height:21px}
    .asearch { display: inline-block }
</style>
<div class="writingform">
    <div class="writing_title">
        <h2>
            <span class="title_left fl">最新活动</span>
        </h2>
    </div>
    <div class="writing_form">        
        <div class="zs_beizhu" style="padding-left: 10px">
            <span style="margin: 0px;">社团：<asp:DropDownList CssClass="option" Height="22px" ID="DDL_Associae" runat="server" /></span>
            <span style="margin: 0px;">
                <asp:TextBox ID="Tb_searchTitle" placeholder="请输入关键字" runat="server" Height="21px" CssClass="line" /></span>
            <span>
                <asp:LinkButton runat="server" ID="btnSearch" CssClass="asearch" Text="查询" OnClick="btnSearch_Click" /></span>
        </div>
        <div class="activity">
            <asp:ListView ID="lvActivity" runat="server" OnPagePropertiesChanging="lvActivity_PagePropertiesChanging">
                <EmptyDataTemplate>
                    <table class="W_form">
                        <tr>
                            <td>未找到您搜索的活动</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <ul>
                        <li>
                            <img src='<%# Eval("Activity_Pic") %>' alt=""></li>
                        <li>
                            <h2 style="text-indent: 1em;"><a href='ActivityShow.aspx?itemid=<%# Eval("ID") %>&fromurl=ActivityList.aspx'><%# Eval("Title") %></a></h2>
                        </li>
                        <li><i class="iconfont">&#xe60c;</i><%# Eval("Associae") %></li>
                        <li><i class="iconfont">&#xe604;</i><%# Eval("StartTime") %>至<%# Eval("EndTime") %></li>
                        <li><i class="iconfont">&#xe607;</i><%# Eval("Address") %></li>
                        <li><i class="iconfont">&#xe60b;</i><%# Eval("Count") %>人参加</li>
                    </ul>
                </ItemTemplate>
            </asp:ListView>
        </div>
        <div class="page">
            <asp:DataPager ID="DP_Activity" runat="server" PageSize="10" PagedControlID="lvActivity">
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

</asp:Content>
