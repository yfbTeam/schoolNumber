<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/EmptySite.Master" AutoEventWireup="true" CodeBehind="AddAssociaeNews.aspx.cs" Inherits="SMSWeb.Association.AddAssociaeNews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Style/layout.css" rel="stylesheet" />
<link rel="stylesheet" href="../Stu_css/allst.css"/>
<link rel="stylesheet" href="../Stu_css/ico/iconfont.css"/>	
<link href="../Stu_css/StuAssociate.css" rel="stylesheet" type="text/css" />
<script src="../Stu_js/jquery-1.8.0.js"></script>
<link href="../Stu_js/KindUeditor/themes/default/default.css" rel="stylesheet" />
<script src="../Stu_js/KindUeditor/lang/zh_CN.js"></script>
<script src="../Stu_js/KindUeditor/kindeditor-min.js"></script>
<%--<script src="/_layouts/15/Script/uploadFile1.js"></script>--%>
<script type="text/javascript">
    var FirstUrl = window.location.hostname;//window.location.href;
    //FirstUrl = FirstUrl.substring(0, FirstUrl.lastIndexOf("/"));
    //var port = FirstUrl.substring(FirstUrl.indexOf(":"));
    port = "44275";
    FirstUrl = FirstUrl + ":" + port;
    var editor;
    //alert(FirstUrl  + "/AssoHandlers/AssoHandler.ashx?action=Upload_json");
    KindEditor.ready(function (K) {
        editor = K.create('#<%=TB_Content.ClientID%>', {
            width: '500px',
            height: '240px',
            minWidth:'500',
            allowFileManager: false,
            items: [
	            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', "strikethrough",
	            'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
	            'insertunorderedlist', '|', 'undo', 'redo', '|', 'emoticons', 'image', 'link'],
            resizeType: 0,
            uploadJson:  "AssoHandler.ashx?action=Upload_json",
            afterBlur: function () { this.sync(); }
        });
    });
    function Preview(file) { //展示图片
        var prevImg = document.getElementById('Imgshow');
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
</script>
<div class="windowDiv">
    <table class="winTable">
        <tr>
            <th class="mi">标题：</th>
            <td  class="ku">
                <asp:TextBox ID="TB_Title" runat="server"></asp:TextBox>
                <span style="color: red;">*
                            <asp:RequiredFieldValidator ID="RFV_Title" runat="server" ControlToValidate="TB_Title"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
            </td>
           <%-- <td style="width: 145px; padding-right: 30px; text-align: center;">
                        <img id="Imgshow" class="imgAssoci" src="../Stu_images/nopic.png" />
                        <div id="divImg" class="imgAssoci" style="display: none;filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=../Stu_images/nopic.png); "></div>
                        <input type="file" id="fimg_Asso" name="fimg_Asso" runat="server" onchange="Preview(this);" style="width: 120px; display: none;" />
                        <a href="#" onclick="document.getElementById('<%=fimg_Asso.ClientID%>').click();" style="color: #1193f3; display: block;">更换照片</a>
                    </td>--%>
        </tr>
        <tr class="areatr">
            <th class="mi">内容：</th>
            <td colspan="2"  class="ku">
                <table class="innerTable">
                    <tr>
                        <td style="padding: 0px;">
                            <asp:TextBox ID="TB_Content" TextMode="MultiLine" runat="server" Height="230px" class="colwidth content" ></asp:TextBox></td>
                        <td style="width:35px; padding: 0px;"><span style="color: red;">*<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TB_Content"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div class="t_btn">
        <asp:Button ID="Btn_InfoSave" OnClick="Btn_InfoSave_Click" CssClass="btn btn_sure" runat="server" ValidationGroup="ProjectSubmit" Text="提交" />
        <input type="button"  class="btn btn_cancel" value="取消" onclick="parent.closePages();" />
    </div>
</div>
</asp:Content>
