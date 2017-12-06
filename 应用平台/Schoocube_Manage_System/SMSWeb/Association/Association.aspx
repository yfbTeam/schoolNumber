<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="Association.aspx.cs" Inherits="SMSWeb.Association.Association" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="Stu_css/common.css" />
    <link href="../Stu_css/allst.css" rel="stylesheet" />
    <link href="../Stu_css/layout.css" rel="stylesheet" />
    <link href="../Stu_css/ico/iconfont.css" rel="stylesheet" />
    <link href="../Stu_css/list_nr.css" rel="stylesheet" />
    <script src="../Stu_js/jquery-1.8.2.min.js"></script>
    <script src="../Stu_js/popwin.js"></script>
    <script type="text/javascript">
        $(function () {
            TabChange(".rflf .st_nav", 'active', '.rflf', '.td');
            TabChange(".Gl_tab", 'selected', '.Gl_tab', '.tc2');
        })
        function TabChange(navcss, selectedcss, parcls, childcls) { //选项卡切换方法，navcss选项卡父级，selectedcss选中样式，parcls内容的父级样式，childcls内容样式
            $(navcss).find("a").click(function () {
                var index = $(this).parent().index();
                $(this).parent().addClass(selectedcss).siblings().removeClass(selectedcss);//为单击的选项卡添加选中样式，同时与当前选项卡同级的其他选项卡移除选中样式
                $(this).parents(parcls).find(childcls).eq(index).show().siblings().hide();//找到与选中选项卡相同索引的内容，使其展示，同时设置其他同级内容隐藏。
            });
        }
        function openPage(pageTitle, pageName, pageWidth, pageHeight) {
            var webUrl = "";
            popWin.showWin(pageWidth, pageHeight, pageTitle, webUrl + pageName);
        }
        function closePages() {
            $("#mask,#maskTop").fadeOut(function () {
                $(this).remove();
            });
        }
    </script>
    <style type="text/css">
        .expand_style td div i {
            width: 30px;
            height: 30px;
            background: inherit;
            color: #069ae0;
            font-style: normal;
            cursor: pointer;
            position: absolute;
            top: 35px;
            right: 0;
        }
    </style>
        <div>

            <div class="Term_wrap" style="padding: 0px">
                <div class="rflf" style="width: 100%">
                    <div class="st_nav" style="width: 100%">
                        <ul style="width: 100%;">
                            <li class="active"><a href="#" class="first">全部社团</a></li>
                            <li><a href="#" class="second">我的社团</a></li>
                            <li><a href="#" class="third">社团活动</a></li>
                            <li><a href="#" class="four">社团申请</a></li>
                        </ul>
                    </div>
                    <div style="width: 100%">
                        <div class="td" id="first">
                            <div class="tabcontent">
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
                                                    <div>
                                                        <p><a href='AssociationShow.aspx?itemid=<%# Eval("ID") %>'>社团详情</a></p>
                                                       <%-- <span><a class="iconfont" href="javascript:void(0)" onclick="openPage('申请入团','ApplyAssociae.aspx?itemid=<%# Eval("ID") %>','650','460');return false;">+</a><span>--%>
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
                        <div class="td" id="second" style="display: none;">
                            <div class="tabcontent">
                                <div class="allst_list">
                                    <ul style="border: none; width: 100%;">
                                        <asp:ListView ID="SB_TermList" runat="server">
                                            <EmptyDataTemplate>
                                                <table class="W_form">
                                                    <tr>
                                                        <td>您暂未加入社团。</td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>
                                            <ItemTemplate>
                                                <li>
                                                    <img src='<%# Eval("Attachment") %>'>
                                                    <h3><%# Eval("Title") %></h3>
                                                    <div class="fz">
                                                        <p><a href='AssociationShow.aspx?itemid=<%# Eval("ID") %>'>社团详情</a></p>
                                                        <%--<span><a class="iconfont" href="#">+</a><span>--%>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </ul>
                                </div>
                                <div class="page">
                                    <asp:DataPager ID="SBDPTeacher" runat="server" PageSize="8" PagedControlID="SB_TermList">
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
                            <%# (Container.TotalRowCount % Container.MaximumRows) > 0 ? Convert.ToInt32(Container.TotalRowCount / Container.MaximumRows) + 1 : Container.TotalRowCount / Container.MaximumRows%>  页
                            (共<%# Container.TotalRowCount %>项)
                                                    </span>
                                                </PagerTemplate>
                                            </asp:TemplatePagerField>
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </div>
                        </div>
                        <div class="td" id="third" style="display: none;">
                            <div class="Gl_tab">
                                <%--<div class="Gl_tabheader">
                    <ul class="tab_tit">
                        <li class="selected">
                            <a href="#">全部活动<span class="num_1" id="spActiveCount" name="spActiveCount" runat="server"></span></a>
                        </li>
                        <li id="li_unAduit" runat="server">
                            <a href="#">待审核<span class="num_1" id="spUnAuditCount" name="spUnAuditCount" runat="server"></span></a>
                        </li>
                    </ul>
                </div>--%>
                                <div class="content">
                                    <div class="tc2" id="selectList">
                                        <asp:ListView ID="lvAllActivity" runat="server" OnPagePropertiesChanging="lvAllActivity_PagePropertiesChanging">
                                            <EmptyDataTemplate>
                                                <table class="W_form">
                                                    <tr class="trth">
                                                        <td colspan="3" style="text-align: center">暂无活动！
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>
                                            <LayoutTemplate>
                                                <table class="W_form expand_style" id="itemPlaceholderContainer">
                                                    <tr class="trth">
                                                        <th>活动名称
                                                        </th>
                                                        <th>所属社团
                                                        </th>
                                                        <th style="width: 294px;">参加人
                                                        </th>
                                                        <th style="width: 294px;">未参加人
                                                        </th>
                                                    </tr>
                                                    <tr id="itemPlaceholder" runat="server"></tr>
                                                </table>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr class="Single">
                                                    <td>
                                                        <a href='ActivityShow.aspx?itemid=<%# Eval("ID") %>&fromurl=Association.aspx'><%#Eval("Title")%></a>
                                                    </td>
                                                    <td>
                                                        <%#Eval("AssoName")%>
                                                    </td>
                                                    <td>
                                                        <%#Eval("inMembers")%>
                                                    </td>
                                                    <td style="overflow: hidden;">
                                                        <%#Eval("noMembers")%>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>
                                        <div class="page">
                                            <asp:DataPager ID="ActivityPager" PageSize="10" runat="server" PagedControlID="lvAllActivity">
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
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="td" style="display: none;">
                            <div class="Gl_tab">
                                <div class="Gl_tabheader">
                                    <ul class="tab_tit">
                                        <li class="selected">
                                            <a href="#">待审核</a>
                                        </li>
                                        <li id="li_unAduit">
                                            <a href="#">审核拒绝</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="content">
                                    <div class="tc2" id="div_unAudit">
                                        <asp:ListView ID="TempListView" runat="server" OnPagePropertiesChanging="TempListView_PagePropertiesChanging">
                                            <EmptyDataTemplate>
                                                <table class="W_form">
                                                    <tr class="trth">
                                                        <td style="text-align: center">暂无待审核的入退团申请</td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>
                                            <LayoutTemplate>
                                                <table id="itemPlaceholderContainer" class="W_form">
                                                    <tr class="trth">
                                                        <th class="theleft">社团名称</th>
                                                        <th>申请类型</th>
                                                        <th>申请人</th>
                                                        <th>性别</th>
                                                        <th>班级</th>
                                                        <th>申请日期</th>
                                                        <th>操作</th>
                                                    </tr>
                                                    <tr id="itemPlaceholder" runat="server"></tr>
                                                </table>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr class="Single">
                                                    <td class="theleft"><%#Eval("Title")%></td>
                                                    <td><%#Eval("Type")%></td>
                                                    <td><%#Eval("Name")%></td>
                                                    <td><%#Eval("Sex")%></td>
                                                    <td><%#Eval("Class")%></td>
                                                    <td><%#Eval("Created")%></td>
                                                    <td>
                                                        <a href="javascript:void(0)" class="btnrefuse" onclick="openPage('审核社团申请','ApplyQuitAuditing.aspx?flag=1&itemid=<%#Eval("ID")%>','560','540');return false">审核</a>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <tr class="Double">
                                                    <td class="theleft"><%#Eval("Title")%></td>
                                                    <td><%#Eval("Type")%></td>
                                                    <td><%#Eval("Name")%></td>
                                                    <td><%#Eval("Sex")%></td>
                                                    <td><%#Eval("Class")%></td>
                                                    <td><%#Eval("Created")%></td>
                                                    <td>
                                                        <a href="javascript:void(0)" style="color: #00a1ec;" onclick="openPage('审核社团申请','ApplyQuitAuditing.aspx?flag=1&itemid=<%#Eval("ID")%>','560','540');return false">审核</a>
                                                    </td>
                                                </tr>
                                            </AlternatingItemTemplate>
                                        </asp:ListView>
                                        <div class="page">
                                            <asp:DataPager ID="DPApply" runat="server" PageSize="10" PagedControlID="TempListView">
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
                                    <div class="tc2" id="div_Refuse" style="display: none;">
                                        <asp:ListView ID="LV_RefuseApply" runat="server" OnPagePropertiesChanging="LV_RefuseApply_PagePropertiesChanging">
                                            <EmptyDataTemplate>
                                                <table class="W_form">
                                                    <tr>
                                                        <td colspan="3">暂无拒绝的申请</td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>
                                            <LayoutTemplate>
                                                <table id="itemPlaceholderContainer" class="W_form">
                                                    <tr class="trth">
                                                        <th class="theleft">社团名称</th>
                                                        <th>申请类型</th>
                                                        <th>申请人</th>
                                                        <th>性别</th>
                                                        <th>班级</th>
                                                        <th>申请日期</th>
                                                        <th>操作</th>
                                                    </tr>
                                                    <tr id="itemPlaceholder" runat="server"></tr>
                                                </table>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr class="Single">
                                                    <td class="theleft"><%#Eval("Title") %></td>
                                                    <td><%#Eval("Type") %></td>
                                                    <td><%#Eval("Name") %></td>
                                                    <td><%#Eval("Sex") %></td>
                                                    <td><%#Eval("Class") %></td>
                                                    <td><%#Eval("Created") %></td>
                                                    <td>
                                                        <a href="javascript:void(0)" style="color: #00a1ec;" onclick="openPage('详情','ApplyQuitAuditing.aspx?flag=0&itemid=<%#Eval("ID")%>','560','540');return false">详情</a>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <tr class="Double">
                                                    <td class="theleft"><%#Eval("Title") %></td>
                                                    <td><%#Eval("Type") %></td>
                                                    <td><%#Eval("Name") %></td>
                                                    <td><%#Eval("Sex") %></td>
                                                    <td><%#Eval("Class") %></td>
                                                    <td><%#Eval("Created") %></td>
                                                    <td>
                                                        <a href="javascript:void(0)" style="color: #00a1ec;" onclick="openPage('详情','ApplyQuitAuditing.aspx?flag=0&itemid=<%#Eval("ID")%>','560','540');return false">详情</a>
                                                    </td>
                                                </tr>
                                            </AlternatingItemTemplate>
                                        </asp:ListView>
                                        <div class="page">
                                            <asp:DataPager ID="DP_RefuseApply" runat="server" PageSize="10" PagedControlID="LV_RefuseApply">
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
