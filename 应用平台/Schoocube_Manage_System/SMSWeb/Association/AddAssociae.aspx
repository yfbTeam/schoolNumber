<%@ Page Title="" Language="C#" MasterPageFile="~/EmptySite.Master" AutoEventWireup="true" CodeBehind="AddAssociae.aspx.cs" Inherits="SMSWeb.Association.AddAssociae" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <script src="../Stu_js/jquery-1.8.0.js"></script>
<link href="../Stu_css/common.css" rel="stylesheet" />
<link href="../Stu_css/layout.css" rel="stylesheet" />
<link href="../Stu_css/StuAssociate.css" rel="stylesheet" type="text/css" />
<link href="../Stu_css/choosen/prism.css" rel="stylesheet" />
<link href="../Stu_css/choosen/chosen.css" rel="stylesheet" />
<script src="../Stu_js/uploadFile1.js"></script>
<style type="text/css">    
    td{
        vertical-align:middle;
    }
    .chosen-search {
        display:none;
    }
    /*.chosen-rtl .chosen-drop {
        left: -9000px;
    }
    .specspan div a span{
        color:black !important;
    }
    .specspan span{
        color:black !important;
    }*/
</style>
    <div>

<asp:ScriptManager ID="ScriptManager1" runat="server" > 
</asp:ScriptManager> 
<script type="text/javascript">
    function Preview(file) { //展示图片        
        var prevImg = document.getElementById("<%=img_Pic.ClientID%>");
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
            <td class="mi">社团名称：</td>
            <td class="ku">
                <asp:TextBox ID="TB_Title" runat="server"></asp:TextBox>
                <span style="color: red;">*
                            <asp:RequiredFieldValidator ID="RFV_Title" runat="server" ControlToValidate="TB_Title"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
            </td>
            <td rowspan="3" style="width: 145px; padding-right: 20px; text-align: center;">
                <asp:Image ID="img_Pic"  CssClass="imgAssoci" runat="server" ImageUrl="../Stu_images/nopic.png" />
                 <div id="divImg" class="imgAssoci" style="display: none;filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=../Stu_images/nopic.png); "></div>
                <input type="file" id="fimg_Asso" name="fimg_Asso" runat="server" onchange="Preview(this);" style="width: 120px; display: none;" />
                <a href="#" onclick="$('#<%=fimg_Asso.ClientID%>').click();" style="color: #1193f3;display:block;">社团图片</a>
            </td>
        </tr>
        <tr>
            <td class="mi">社团口号：</td>
            <td class="ku">
                <asp:TextBox ID="TB_Slogans" runat="server"></asp:TextBox>
                <span style="color: red;">*
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TB_Slogans"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
            </td>
        </tr>
        <tr>
            <td class="mi">社团类型：</td>
            <td class="ku">
                <asp:DropDownList ID="DDL_Type" runat="server" CssClass="droplist"></asp:DropDownList>
                <span style="color: red;">*
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DDL_Type"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
            </td>
        </tr>
        <tr>
            <td class="mi">副 团 长：</td>
            <td class="ku" style="width:320px;">
                <asp:DropDownList ID="DDL_SecLeader" runat="server"  class="chosen-select" data-placeholder="选择副团长"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="mi">社团介绍：</td>
            <td colspan="2" class="ku">
                <table class="innerTable">
                    <tr>
                        <td style="padding: 0px;">
                            <asp:TextBox ID="TB_Content" TextMode="MultiLine"  class="unvaliwidth" runat="server"></asp:TextBox></td>
                        <td style="width:35px; padding: 0px;"><span style="color: red;">*<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TB_Content"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div class="t_btn">
        <asp:Button ID="Btn_InfoSave" CssClass="btn btn_sure" runat="server" OnClientClick="insertvalue();" OnClick="Btn_InfoSave_Click" ValidationGroup="ProjectSubmit" Text="确定" />
        <input type="button" class="btn btn_cancel" value="取消" onclick="parent.closePages();" />
    </div>
</div>

    </div>
    <script src="../Stu_js/choosen/chosen.jquery.js"></script>
<script src="../Stu_js/choosen/prism.js"></script>
<script type="text/javascript">
    var config = {
        '.chosen-select': {},
        '.chosen-select-deselect': { allow_single_deselect: true },
        '.chosen-select-no-single': { disable_search_threshold: 6 },
        '.chosen-select-no-results': { no_results_text: '未找到结果!' },
        '.chosen-select-width': { width: "95%" }
    }
    for (var selector in config) {
        $(selector).chosen(config[selector]);
    }
    function insertvalue() {
        var leader = $("select[id$='DDL_Leader']").val();
        var secleader = $("select[id$='DDL_SecLeader']").val();
        if (leader == secleader) {
            $("span[id$='RFV_SecLeader']").text("社团长和副团长不能为一人");
            return false;
        }
    }
</script>
</asp:Content>
