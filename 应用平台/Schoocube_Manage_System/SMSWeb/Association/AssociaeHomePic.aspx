﻿<%@ Page Title="" Language="C#" MasterPageFile="~/EmptySite.Master" AutoEventWireup="true" CodeBehind="AssociaeHomePic.aspx.cs" Inherits="SMSWeb.Association.AssociaeHomePic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/Stu_css/common.css" rel="stylesheet" />
<link href="/Stu_css/StuAssociate.css" rel="stylesheet" type="text/css"/>
<script src="/Stu_js/jquery-1.8.0.js"></script>
<script type="text/javascript">
    $(function () {
        $("input:radio[name='arrange']").click(function () {
            $(".homeshowimg").css("background-repeat", this.id.replace("ra", ""));
        });
        $("input:radio[name='align']").click(function () {
            $(".homeshowimg").css("background-position-y", this.id.replace("ra", ""));
        });
    })
    function Preview(file) { //展示图片        
        var prevImg = document.getElementById('<%=Imgshow.ClientID%>');
        if (file.files && file.files[0]) {
            var reader = new FileReader();
            reader.onload = function (evt) {
                prevImg.src = evt.target.result;
            }
            reader.readAsDataURL(file.files[0]);
        }
        else {
            prevImg.style.display = "none";
            var divImg = document.getElementById('divImg');
            divImg.style.display = "block";
            divImg.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = file.value;
        }
    }
    function UploadfileClick() {
        document.getElementById('<%=fimg_Asso.ClientID%>').click();
    }
</script>
    <div class="windowDiv">
    <table style="border-bottom: 1px solid #eaeaea;width:100%;">
        <tr>
            <td colspan="2">          
                <img id="Imgshow" runat="server" src="/_layouts/15/Stu_images/homepic.jpeg"  class="homeshowimg"/> 
                <div id="divImg" class="homeshowimg" style="display: none;filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=/_layouts/15/Stu_images/nopic.png); "></div>
            </td>
        </tr>
        <tr>
            <td style="text-align:center;">支持5M以内的JPG、GIF、PNG格式</td>
            <td style="padding-left:15px;">排列：<input type="radio" name="arrange" id="rarepeat-x"/>横向平铺
                <input type="radio" name="arrange" id="rarepeat-y"/>纵向平铺</td>
        </tr>
        <tr>
            <td style="text-align:center;">
                <input type="file" id="fimg_Asso" name="fimg_Asso" runat="server" onchange="Preview(this)" style="width:120px;display:none;"/>                                           
                <input type="button" class="btn btn_cancel" value="上传" onclick="UploadfileClick();" />
            </td>
            <td style="padding-left:15px;">对齐：<input type="radio" id="ratop" name="align"/>居上
                <input type="radio" name="align" id="racenter"/>居中<input type="radio" name="align" id="rabottom"/>居下</td>
        </tr>
    </table>
    <div class="t_btn">
    <asp:Button ID="btnAdd" CssClass="btn btn_sure" runat="server" Text="保存设置" OnClick="btnAdd_Click" />
    <input type="button" class="btn btn_cancel" value="取消保存" onclick="parent.closePages();" />
</div>
</div>
</asp:Content>
