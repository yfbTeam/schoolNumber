<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="AssociaeSign.aspx.cs" Inherits="SMSWeb.Association.AssociaeSign" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Stu_css/common.css" rel="stylesheet" />
<link href="../Stu_css/allst.css" rel="stylesheet" />
<link rel="stylesheet" href="../Stu_css/list_nr.css"/>
<div class="writingform">
    <div class="writing_title">
        <h2>
            <span class="title_left fl">全部社团</span>
        </h2>
    </div>
    <div class="writing_form">
        <div class="allst_list">
            <ul style="border: none; width: 100%;">
                <asp:ListView ID="LV_TermList" runat="server" OnPagePropertiesChanging="LV_TermList_PagePropertiesChanging">
                    <EmptyDataTemplate>
                        <span style="margin: auto">暂无社团，等待管理教师创建。。。</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <li>
                            <img src='<%# Eval("Attachment") %>'>
                            <h3><%# Eval("Title") %></h3>
                            <div onclick="location.href='AssociationShow.aspx?itemid=<%# Eval("ID") %>'">
                                <p><a>社团详情</a></p>
                                <%--<span><a class="iconfont" href="javascript:void(0)" onclick="openPage('申请入团','/SitePages/ApplyAssociae.aspx?itemid=<%# Eval("ID") %>','650','460');return false;">+</a><span>--%>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:ListView>
            </ul>
        </div>
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
</asp:Content>
