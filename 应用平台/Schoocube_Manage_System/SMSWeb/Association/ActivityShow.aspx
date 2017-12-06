<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="ActivityShow.aspx.cs" Inherits="SMSWeb.Association.ActivityShow" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


       <link rel="stylesheet" href="../Stu_css/allst_content.css"/>
<link rel="stylesheet" href="../Stu_css/ico/iconfont.css"/>
<link href="../Stu_css/layout.css" rel="stylesheet" />
<link href="../Stu_css/list_nr.css" rel="stylesheet" />
<script src="../Stu_js/jquery-1.8.0.js"></script>
<script type="text/javascript">
    //$(document).ready(function () {
    //    var FirstUrl = window.location.href;
    //    var index = FirstUrl.indexOf("fromurl=");
    //    if (index > 0) {
    //        var fromurl = FirstUrl.substring(index + 8);
    //        $("#fh").attr("href", fromurl);
    //    }
    //});    
</script>

    <div>
 
<div class="Term_wrap">
<div class="stxq_index">
			<div class="hd_cjxq">
				<img src="../Stu_images/nopic.png" alt="" runat="server" id="img_Pic"/>
				<ul>
					<li><h2><asp:Literal ID="Lit_Title" runat="server" Text="--" /></h2></li>
					<li><i class="iconfont">&#xe604;</i><asp:Literal ID="Lit_Date" runat="server" Text="--" /></li>
					<li><i class="iconfont">&#xe607;</i><asp:Literal ID="Lit_Address" runat="server" Text="--" /></li>
					<li><i class="iconfont">&#xe60b;</i><asp:Literal ID="Lit_Count" runat="server" Text="0" />人参加</li>
					<li><span><asp:LinkButton runat="server" ID="Join" Text="参加" OnClick="Join_Click"/></span></li>
				</ul>
			</div>
			<dl>
				<dt><i class="iconfont">&#xe60c;</i>参加的人</dt>
				<dd>
                    <asp:ListView ID="LV_TermList" runat="server">
                        <EmptyDataTemplate>
                            <table class="W_form">
                                <tr>
                                    <td>暂无人参加,赶紧参加吧</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <div>
                                <img src='<%# Eval("U_Pic") %>'>
                                <h2><%# Eval("Name") %></h2>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
				</dd>
			</dl>
			<dl>
				<dt><p></p>活动内容</dt>
				<dd>
					<p><asp:Literal ID="Lit_Content" runat="server" /></p>
				</dd>
			</dl>
            <dl>
                <dt><p></p>活动资料</dt>
                <dd>
                    <p><asp:Literal ID="Lit_Attachment" runat="server" /></p>
                </dd>
            </dl>
		</div>
    <div class="sj_tijiao">
            <a id="fh" style="background:#fafafa;border:1px solid #d5d5d5;color:#363636" onclick="history.go(-1);">返回</a>
        </div>
    </div>

    </div>
</asp:Content>
