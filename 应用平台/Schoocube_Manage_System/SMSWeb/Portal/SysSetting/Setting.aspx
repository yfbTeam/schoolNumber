<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Setting.aspx.cs" Inherits="SMSWeb.Portal.SysSetting.Setting" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <style type="text/css">
        .ui-upload-input {
            position: absolute;
            top: 0px;
            right: 0px;
            height: 100%;
            cursor: pointer;
            opacity: 0;
            filter: alpha(opacity:0);
            z-index: 999;
            font-size: 100px;
        }

        .ui-upload-holder {
            position: relative;
            width: 100px;
            height: 27px;
            border: 1px solid silver;
            overflow: hidden;
            border-radius: 3px;
            cursor: pointer;
        }

        .ui-upload-txt {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100px;
            height: 27px;
            line-height: 27px;
            text-align: center;
            background: #0097DD none repeat scroll 0% 0%;
            color: #fff;
            font: 12px "微软雅黑";
            vertical-align: middle;
            padding: 5px 0px;
            cursor: pointer;
        }

        .settingsd {
            padding: 20px;
        }

            .settingsd table tr td {
                border: 1px solid #ccc;
                padding: 10px;
            }

        .shgnchuanbottom {
            width: 102px;
            height: 30px;
            margin: 0 auto;
        }


        .h-ico {
            display: inline-block;
        }

        .imgShow {
            width: 80px;
            height: 100px;
        }

        .course_manage .crumbs {
            border: none;
        }
    </style>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/PortalJs/ajaxfileupload.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/KindUeditor/kindeditor.js"></script>
    <script src="/Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="/Scripts/KindUeditor/lang/zh_CN.js"></script>

    <script id="tr_School" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Title}</td>
            <td>
                <img src="${ImageUrl}" class="imgShow" /></td>
            <td>${SortId}</td>
            <td>
                <a href="javascript:;" onclick="javascript: OpenIFrameWindow('修改数据', 'SettingEdit.aspx?Id=${Id}&MenuId=${MenuId}', '700px', '500px');"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DeleteBanner('${Id}')"><i class="icon icon-road"></i>删除</a>

            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="MenuId" runat="server" />
        <script type="text/javascript">
            var ptitle = getQueryString("ptitle");
            var title = getQueryString("title");
            document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
        </script>
        <div class="settingsd">
            <table>
                <tr>
                    <td>前台页面LOGO</td>
                    <td>
                        <div class="shangchuan">
                            <div class="shgnchuantop" id="imgshow1">
                                <img src="/PortalImages/logo.png" />
                            </div>
                            <div class="shgnchuanbottom">
                                <div class="ui-upload-holder">
                                    <div class="ui-upload-txt">
                                        点击上传
                                    </div>
                                    <input id="fileToUpload1" type="file" size="45" name="fileToUpload1" class="input ui-upload-input bluebutton dianjisc"
                                        uploadattr="before" style="margin-top: 0;" />
                                </div>
                            </div>
                            <div id="divUpload1" class="none">
                                <img id="loading1" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>后台页面LOGO</td>
                    <td>
                        <div class="shangchuan">
                            <div class="shgnchuantop" id="imgshow2">
                                <img src="/PortalImages/logoBefore.png" />
                            </div>
                            <div class="shgnchuanbottom">
                                <div class="ui-upload-holder">
                                    <div class="ui-upload-txt">
                                        点击上传
                                    </div>
                                    <input id="fileToUpload2" type="file" size="45" name="fileToUpload2" class="input ui-upload-input bluebutton dianjisc"
                                        uploadattr="after" style="margin-top: 0;" />
                                </div>

                            </div>
                            <div id="divUpload2" class="none">
                                <img id="loading2" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                            </div>
                        </div>
                    </td>
                </tr>

            </table>
            <div class="newcourse_select clearfix">
                <div class="distributed fr">
                    <a href="javascript:void(0);" onclick="javascript: AddBanner();"><i class="icon icon-plus"></i>添加</a>
                </div>
            </div>
            <div class="onlinetest_item">
                <div class="course_manage bordshadrad">
                    <div class="wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th class="number">序号</th>
                                    <th>标题</th>
                                    <th>图片</th>
                                    <th>排序</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="tb_School"></tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!--分页-->
            <div class="page">
                <span id="pageBar"></span>
            </div>
            <div>
                设置网站通知通告显示条数<input runat="server" id="PageNumber" type="text" /><asp:Button ID="btnChangeNum" runat="server" Text="确定" OnClick="btnChangeNum_Click" OnClientClick="javascript:layer.msg('设置成功！')" />
            </div>

            <div>
                <%--<textarea  name="content" >
                                </textarea>--%>
                <asp:TextBox ID="editor_id" runat="server" TextMode="MultiLine" Style="width: 100%; height: 700px;"></asp:TextBox>
                <asp:Button ID="btnSaveUser" runat="server" Text="保存用户协议" OnClick="btnSaveUser_Click" OnClientClick="javascript:layer.msg('设置成功！')" />
            </div>
            <div>
                <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand" OnItemDataBound="Repeater1_ItemDataBound">
                    <HeaderTemplate>
                        <table>
                            <tbody>
                                <tr>
                                    <th>定时器名称</th>
                                    <th>频率</th>
                                    <th>定时器描述</th>
                                    <th>操作</th>
                                </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:HiddenField  runat="server" ID="hidid" Value='<%#Eval("id") %>' />
                        
                        <asp:Panel ID="plItem" runat="server">
                            <tr style="text-align: center;">
                                <td>
                                    <asp:Label Text='<%# DataBinder.Eval(Container.DataItem, "name") %>' ID="lblname" runat="server"></asp:Label>
                                </td>
                                <td><asp:Label runat="server" ID="lblnum" Text='<%# DataBinder.Eval(Container.DataItem, "num") %>'></asp:Label>
                                    /<asp:Label ID="lbltime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "time") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbldesc" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "tdesc") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:LinkButton runat="server" ID="lbtEdit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id")%>'
                                        CommandName="Edit" Text="编辑" /></td>
                            </tr>
                        </asp:Panel>
                        <asp:Panel ID="plEdit" runat="server">
                            <tr style="text-align: center;">
                                <td><asp:TextBox ID="txtname" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "name") %>'></asp:TextBox>  </td>
                                <td><asp:TextBox ID="txtnum" Text='<%# DataBinder.Eval(Container.DataItem,"num") %>'
                                    runat="server"></asp:TextBox>/<%#DataBinder.Eval(Container.DataItem, "time") %></td>
                                <td>
                                    <asp:TextBox ID="txtdesc" Text='<%#DataBinder.Eval(Container.DataItem,"tdesc") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:LinkButton runat="server" ID="lbtUpdate" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id")%>'
                                        CommandName="Update" Text="更新"></asp:LinkButton>&nbsp;&nbsp;
                    <asp:LinkButton runat="server" ID="lbtCancel" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id")%>'
                        CommandName="Cancel" Text="取消"></asp:LinkButton></td>
                            </tr>
                        </asp:Panel>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>

    </form>
    <script type="text/javascript">
        $(function () {
            KindEditor.ready(function (K) {
                window.editor = K.create('#editor_id', {
                    uploadJson: '/UploadImage.ashx?action=UploadImgForAdvertContent',
                    allowFileManager: false,//true时显示浏览服务器图片功能。
                    allowImageRemote: false,//网络图片
                    resizeType: 0,
                    items: [
                    'source', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', "strikethrough",
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'undo', 'redo', '|', 'link'],
                    afterFocus: function () {
                        self.edit = edit = this; var strIndex = self.edit.html().indexOf("请添加你的描述..."); if (strIndex != -1) { self.edit.html(self.edit.html().replace("请添加你的描述...", "")); }
                    },
                    //失去焦点事件
                    afterBlur: function () { this.sync(); self.edit = edit = this; if (self.edit.isEmpty()) { self.edit.html("请添加你的描述..."); } },
                    afterUpload: function (data) {
                        if (data.result) {
                            //data.url 处理
                        } else {

                        }
                    },
                    afterError: function (str) {
                        //alert('error: ' + str);
                    }
                });

            });



            getData(1, 10);
            $("#fileToUpload1,#fileToUpload2").on("change", function () {
                ajaxFileUpload($(this));
            });
        })

        //logo上传
        function ajaxFileUpload(event) {
            var e = event ? event : (window.event ? window.event : null);
            var uploadId = $(e).attr("id");
            var upattr = $(e).attr("uploadattr");
            if (!/\.(JPEG|jpeg|JPG|jpg|BMP|bmp|PNG|png)$/.test($(e).val())) {
                art.alert("图片类型必须是jpg,png,bmp中的一种！");
                return false;
            }
            var fileTool = '';
            var url = '';
            if (uploadId == "fileToUpload1") {
                fileTool = 'fileToUpload1';
                $("#loading1").ajaxStart(function () {
                    $(this).show();
                }).ajaxComplete(function () {
                    $(this).hide();
                });
            } else if (uploadId == "fileToUpload2") {
                fileTool = 'fileToUpload2';
                $("#loading2").ajaxStart(function () {
                    $(this).show();
                }).ajaxComplete(function () {
                    $(this).hide();
                });
            }
            $.ajaxFileUpload(
                {
                    url: '/Portal/Admin/Upload.ashx',
                    secureuri: false,
                    fileElementId: fileTool,
                    dataType: 'json',
                    data: { action: upattr },
                    success: function (data, status) {
                        debugger;
                        if (data.result) {
                            if (uploadId == "fileToUpload1") {
                                $("#imgshow1>:first-child").attr("src", data.path);
                                $("#fileToUpload1").on("change", function () {
                                    ajaxFileUpload($(this));
                                })
                            }
                            else if (uploadId == "fileToUpload2") {
                                $("#imgshow2>:first-child").attr("src", data.path);
                                $("#fileToUpload2").on("change", function () {
                                    ajaxFileUpload($(this));
                                })
                            }

                        } else {
                            layer.msg(data.desc);
                        }

                    },
                    error: function (data, status, e) {
                        layer.msg(e);
                    }
                }
            )
        }

        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/SchoolStyle.ashx",
                    Func: "GetPageList",
                    MenuId: $("#MenuId").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_School").html('');
                        $("#tr_School").tmpl(json.result.retData.PagedData).appendTo("#tb_School");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_School").html("<tr><td colspan='6'>暂无数据！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function DeleteBanner(delid) {
            layer.msg("确定要删除该Banner?", {
                time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: { PageName: "PortalManage/SchoolStyle.ashx", Func: "UpdateSchoolStyle", Id: delid, IsDelete: 1 },
                       success: function (json) {
                           if (json.result.errNum.toString() == "0") {
                               layer.msg("删除成功");
                               getData(1, 10);

                           }
                           else { layer.msg('删除失败！'); }
                       },
                       error: function (errMsg) {
                           layer.msg('删除失败！');
                       }
                   });
               }
            });
        }

        function AddBanner() {
            OpenIFrameWindow('添加数据', 'SettingEdit.aspx?MenuId=' + $("#MenuId").val(), '700px', '500px')
        }
    </script>
</body>
</html>
