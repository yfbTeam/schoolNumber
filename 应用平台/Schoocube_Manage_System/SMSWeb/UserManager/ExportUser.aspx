<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.Master" AutoEventWireup="true" CodeBehind="ExportUser.aspx.cs" Inherits="SMSWeb.UserManager.ExportUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stu_css/iconfont.css" rel="stylesheet" />
    <link href="../Stu_css/layout.css" rel="stylesheet" />

    <script src="../Scripts/jquery-1.8.0.js"></script>

    <script src="../Stu_js/layer/layer.js"></script>
    <script src="../Stu_js/layer/OpenLayer.js"></script>

    <script type="text/javascript">

        function closeFrame(returnVal) {
            OL_CloseLayerIframe(returnVal);
        }
        function RemoveCurrent(fileName, trId) {
            $("#" + trId).hide();
            var nowfile = $("input[id$=Hid_fileName]").val();
            $("input[id$=Hid_fileName]").val(nowfile + '#' + fileName);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="listdv">
        <table>
            <tr>
                <th>资源文件：</th>
                <td>
                    <asp:FileUpload ID="Up_Upload" runat="server" />
                </td>
            </tr>
            <tr>
                <th>说明：</th>
                <td>
                    <ul>
                        <li>导入的用户数据文件必须是Excel文件（.xls和.xlsx）！</li>
                        <li>导入的用户数据的字段及排列顺序必须和模板文件中的一致！<a href="User.xls">[点此下载模板文件]</a></li>
                        <li>模板文件中的红色字体为必填项，必须填写才能导入成功！</li>
                        <li>导入时间跟用户数据多少成正比,请耐心等待！</li>
                    </ul>
                </td>
            </tr>


            <tr class="btntr">
                <th></th>
                <td>
                    <asp:Button ID="Btn_Export" OnClick="Btn_Export_Click" CssClass="save" runat="server" ValidationGroup="ProjectSubmit" Text="导入" />

                    <input type="button" class="cancel" value="取消" onclick="closeFrame('0');" />
                </td>
            </tr>

        </table>
        <div style="text-align:center;">
            <asp:Literal ID="Lit_Result" runat="server"></asp:Literal></div>
    </div>
</asp:Content>
