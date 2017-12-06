<%@ Page Title="" Language="C#" MasterPageFile="~/EmptySite.Master" AutoEventWireup="true" CodeBehind="AddAssociaeMgr.aspx.cs" Inherits="SMSWeb.Association.AddAssociaeMgr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Stu_css/common.css" rel="stylesheet" />
<link href="../Stu_css/StuAssociate.css" rel="stylesheet" type="text/css" />
<link href="../Stu_css/choosen/prism.css" rel="stylesheet" />
<link href="../Stu_css/choosen/chosen.css" rel="stylesheet" />
<style type="text/css">
    .chosen-results {
        height: 80px;
    }
</style>
<script src="../Stu_js/jquery-1.8.2.min.js"></script>
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
    <div style="width:584px;margin:auto;">
        <div style="float: left;">
            <table class="winTable">
                <tr>
                    <td class="mi">社团名称：</td>
                    <td class="ku">
                        <asp:TextBox ID="TB_Title" runat="server" Width="230px"></asp:TextBox>
                        <span style="color: red;">*
                            <asp:RequiredFieldValidator ID="RFV_Title" runat="server" ControlToValidate="TB_Title"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">社团类型：</td>
                    <td class="ku">
                        <asp:DropDownList ID="DDL_Type0" runat="server" CssClass="droplist"></asp:DropDownList>
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">社 团 长：</td>
                    <td class="ku" style="width: 320px;">
                        <asp:DropDownList ID="DDL_Type" runat="server" Width="73px" AutoPostBack="true" OnSelectedIndexChanged="DDL_Type_SelectedIndexChanged" />
                        <asp:DropDownList ID="DDL_Leader" runat="server" class="chosen-select" data-placeholder="选择社团长" Width="175px" /><span style="color: red;">*
                     <asp:RequiredFieldValidator ID="RFV_Leader" runat="server" ControlToValidate="DDL_Leader"
                         ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="winTable" style="width: 145px; text-align: center;float: right;">
            <asp:Image ID="img_Pic" CssClass="imgAssoci" runat="server" ImageUrl="../Stu_images/nopic.png" />
            <div id="divImg" class="imgAssoci" style="display: none; filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=../Stu_images/nopic.png);"></div>
            <input type="file" id="fimg_Asso" name="fimg_Asso" runat="server" onchange="Preview(this);" style="display: none;" />
            <a href="#" onclick="$('#<%=fimg_Asso.ClientID%>').click();" style="color: #1193f3; display: block;">社团图片</a>
        </div>
        <div style="clear: both;"></div>
    </div>
    <div class="t_btn">
        <asp:Button ID="Btn_InfoSave" CssClass="btn btn_sure" runat="server" OnClick="Btn_InfoSave_Click" ValidationGroup="ProjectSubmit" Text="确定" />
        <asp:Button ID="Btn_Delete" CssClass="btn btn_cancel" runat="server" OnClick="Btn_Delete_Click" Text="删除" />
        <input type="button" class="btn btn_cancel" value="取消" onclick="parent.closePages();" />
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
</script>

</asp:Content>
