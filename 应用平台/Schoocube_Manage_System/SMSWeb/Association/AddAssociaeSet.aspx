<%@ Page Title="" Language="C#" MasterPageFile="~/EmptySite.Master" AutoEventWireup="true" CodeBehind="AddAssociaeSet.aspx.cs" Inherits="SMSWeb.Association.AddAssociaeSet" %>
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
<script src="../Stu_js/My97DatePicker/WdatePicker.js"></script>


    <div class="windowDiv">
        <div>
         <table class="winTable">
                <tr>
                    <td class="mi">社团报名允许多选：</td>
                    <td class="ku">
                        <asp:CheckBox ID="ckIsOnly" runat="server" />
                        
                    </td>
                </tr>
                <tr>
                    <td class="mi">开放报名时间：</td>
                    <td class="ku">
                       <input type="text" class="Wdate" readonly="readonly" runat="server" id="dtStartDate" name="dtStartDate" onclick="WdatePicker();" style="width: 97px;line-height:18px;" />
                   
                    </td>
                </tr>
                <tr>
                    <td class="mi">至：</td>
                    <td class="ku">
                       <input type="text" class="Wdate" readonly="readonly" runat="server" id="dtEndDate" name="dtEndDate" onclick="    WdatePicker();" style="width: 97px;line-height:18px;" />
                    </td>
                </tr>
              
            </table>
    </div> <div class="t_btn">
         <%--<asp:Button ID="Button1" CssClass="btn btn_sure" runat="server" OnClick="Btn_InfoSave_Click" ValidationGroup="ProjectSubmit" Text="保存并发布公告" />--%>
        <asp:Button ID="Btn_InfoSave" CssClass="btn btn_sure" runat="server" OnClick="Btn_InfoSave_Click" ValidationGroup="ProjectSubmit" Text="确定" />
        <input type="button" class="btn btn_cancel" value="取消" onclick="parent.closePages();" />
    </div></div>
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
