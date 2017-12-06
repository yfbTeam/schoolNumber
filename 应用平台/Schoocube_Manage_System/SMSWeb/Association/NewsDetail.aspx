﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="NewsDetail.aspx.cs" Inherits="SMSWeb.Association.NewsDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Stu_css/animate.css" rel="stylesheet" />
<link rel="stylesheet" href="../Stu_css/ico/iconfont.css"/>
<link href="../Stu_css/sg/sg.css" rel="stylesheet" />
<link href="../Stu_css/discuss.css" rel="stylesheet" />
<link href="../Stu_css/layout.css" rel="stylesheet" />
<link href="../Stu_css/style.css" rel="stylesheet" />
<link href="../Stu_css/StuAssociate.css" rel="stylesheet" />
<link href="../Stu_js/KindUeditor/themes/default/default.css" rel="stylesheet" />
<script src="../Stu_js/jquery-1.8.0.js"></script>
<script src="../Stu_js/uploadFile.js"></script>
<script type="text/javascript">
    function setValue() {
        var nowfile = $("#dv_content").text().trim();
        if (nowfile.length > 100) {
            alert("您发表的字数过长");
            return false;
        } if (nowfile.length == 0) {
            return false;
        }
        $("input[id$=Hid_content]").val(nowfile);
    }
    function setSecValue(event) {
        var preval = $(Event).prev().text();
        $(Event).next().val(preval);
    }
</script>
<div class="PE_wrap">
<div class="top_TPcon">
<ul>
        <li style="line-height:28px;">
            <div class="music_news" style="width:90%;margin:auto;margin-top:25px;">
                <%--<asp:Image runat="server" CssClass="img_news" ID="Img_News" ImageUrl="../Stu_images/nopic.png"/>--%>
                <div class="music_nr">
                    <h2>
                        <asp:Literal ID="Lit_Title" runat="server" Text="--" /></h2>
                    <div>
                        <span><i class="iconfont">&#xe60b;</i><asp:Literal ID="Lit_Associae" runat="server" Text="--" /></span>
                        <span><i class="iconfont">&#xe60c;</i><asp:Literal ID="Lit_CreateUser" runat="server" Text="--" /></span>
                        <span><i class="iconfont">&#xe604;</i><asp:Literal ID="Lit_CreateTime" runat="server" Text="--" /></span>
                    </div>
                    <%--<p id="P_Content" runat="server"></p>--%>
                    <asp:Literal ID="Lit_Content" runat="server"></asp:Literal>
                </div>
            </div>
        </li>
</ul>
</div>
<!--timeline start-->
<!--<div class="timeline">
    <div class="t_send">
        <div class="t_header">
            <asp:Image runat="server" ID="Img_CurrentPic" Width="50" Height="50" ImageUrl="../Stu_images/studentdefault.jpg" />
            <span class="name">
                <asp:Literal ID="Lit_CurrentName" runat="server"></asp:Literal></span>
        </div>
        <div class="t_icon"></div>
        <div class="t_box">
            <p class="t_title">记录内容：</p>
            <div id="dv_content" class="t_msg" contenteditable="true"></div>
            <asp:HiddenField ID="Hid_content" runat="server" />
            <div class="t_face">                
                <asp:LinkButton OnClick="LB_Publish_Click" CssClass="t_send_btn" ID="LB_Publish" runat="server" OnClientClick="setValue();">发表</asp:LinkButton>
                <%--<a href="#" class="t_send_btn">发 表</a>
            </div>
        </div>
    </div>--%>
   <%-- <asp:ListView ID="LV_FirstReply" runat="server" OnItemCommand="LV_FirstReply_ItemCommand" OnItemDataBound="LV_FirstReply_ItemDataBound" OnPagePropertiesChanging="LV_FirstReply_PagePropertiesChanging">        
        <LayoutTemplate>
            <div id="itemPlaceholder" runat="server"></div>
        </LayoutTemplate>
        <ItemTemplate>
            <div class="t_all">
                <div class='t_list animated bounceIn'>
                    <div class='l_header'>
                        <%--<img src='<%#Eval("PictUrl") %>' alt='' width='50' height='50' /><span class="name"><%#Eval("Author") %></span>--%>
                    </div>
                    <div class='l_icon'></div>
                    <div class='l_msg'>
                        <div class="firstcon">
                            <%--<div class="l_msgcon"><%#Eval("Content") %></div>--%>
                            <div class="co_con">
                                <div class="co_right fr">
                                    <span class="Reply" style="cursor:pointer;">回复(<asp:Literal ID="Lit_Count" runat="server"></asp:Literal>)</span>	|
                                <span class="Comment"><a href="#">评论(<i class="con_num">2</i>)</a></span>|
                                <span class="Praise">
                                    <%--<asp:LinkButton ID="LB_Zan" runat="server" CommandName="Zan" CommandArgument='<%# Eval("ID") %>'><img src="../TeacherImages/zan.png" width="18" /><i class="con_num"><%#Eval("GoodCount") %></i></asp:LinkButton>
                                    </span>|
                                <span class="date"><%#Eval("Created") %></span>--%>
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="secondcon" style="display: none;">
                            <div class='s_icon'></div>
                            <div class="clear"></div>
                            <div class="s_con">
                                <div class="Publish">
                                    <%--<asp:HiddenField ID="Hid_ItemId" runat="server" Value='<%# Eval("ID") %>' />
                                              <div><asp:TextBox ID="TB_SecondVal" runat="server" Width="80%"></asp:TextBox></div>
                                    <asp:LinkButton CssClass="t_send_btn fr" ID="LB_Second" OnClientClick="setSecValue(this);" runat="server" CommandName="Publish" CommandArgument='<%# Eval("ID") %>'>回复</asp:LinkButton>--%>
                                    <%--<asp:HiddenField ID="Hid_SecondVal" runat="server" />--%>
                                </div>
                                <div class="clear"></div>
                                <asp:ListView ID="LV_SecondReply" runat="server">
                                    <LayoutTemplate>
                                        <div id="itemPlaceholder" runat="server"></div>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div class="third">
                                            <div class="tcon_left fl">
                                                <%--<img src='<%#Eval("PictUrl") %>' alt='' width='40' height='40' /><span class="name"><%#Eval("Author") %></span>
                                            </div>
                                            <div class="tcon_right fr">
                                                <p class="third_con"><%#Eval("Content") %></p>
                                                <p class="third_c">
                                                    <span class="times fl"><%#Eval("Created") %></span>--%>
                                                </p>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:ListView>
    <div class="page">
            <%--<asp:DataPager ID="DPProject" runat="server" PageSize="15" PagedControlID="LV_FirstReply">
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
        </div>--%>
    <div class="clear"></div>
</div>
</div>
<script src="../Stu_js/jquery-1.8.0.js"></script>
<script src="../Stu_js/tz_slider.js"></script>
<script src="../Stu_js/tz_util.js"></script>
<script>
    $(function () {
        $(".Reply").click(function () {
            $(this).parent().parent().parent().next().next().slideToggle();
        });
    })
</script>
</asp:Content>
