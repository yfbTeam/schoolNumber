<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuEdit.aspx.cs" Inherits="SMSWeb.Menu.MenuEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="JS/jquery.tmpl.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <style>
        .course_form_img .uploadify-button {
            font-size: 14px;
            color: #fff;
            border: none;
            background: #19c857;
        }

        .course_form_div {
            margin-left: 120px;
        }

        .course_form_img .change_picture {
            width: 110px;
        }
    </style>
</head>
<body style="background: #fff;">
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="hid_MenuCode" value="" runat="server" />
        <input type="hidden" id="hid_id" value="" runat="server" />
        <input type="hidden" id="hid_Name" value="" runat="server" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix pr">
                    <div class="course_form_div">
                        <label for="">父节点名称：</label>
                        <input type="text" placeholder="父节点名称" class="text" id="txt_Name" />
                        <i class="stars"></i>
                    </div>
                </div>
                <div class="clearfix">
                    <div class="course_form_div" style="height: 145px;">
                        <div class="course_form_img" style="position: relative;">
                            <img id="img_Pic" alt="" src="" />
                            <div class="change_picture">
                                <input type="file" id="uploadify" name="uploadify" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix">
                    <div class="clearfix">

                        <div class="course_form_select clearfix" style="text-align: center; margin-top: 20px;">
                            <a class="course_btn confirm_btn" onclick="AddCource()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript">
    $(function () {
        
        $("#txt_Name").val($("#hid_Name").val());
        Img();

    });



    function Img() {

        $("#uploadify").uploadify({
            'auto': true,                      //是否自动上传
            'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
            'uploader': '/CourseManage/Uploade.ashx',
            'formData': { Func: "SetImage" }, //参数
            //'fileTypeDesc': '',
            'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
            'buttonText': '选择图片',//按钮文字
            // 'cancelimg': 'uploadify/uploadify-cancel.png',
            'width': 110,
            'height': 30,
            //最大文件数量'uploadLimit':
            'multi': false,//单选            
            'fileSizeLimit': '20MB',//最大文档限制
            'queueSizeLimit': 1,  //队列限制
            'removeCompleted': true, //上传完成自动清空
            'removeTimeout': 0, //清空时间间隔
            //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
            'onUploadSuccess': function (file, data, response) {
                var json = $.parseJSON(data);
                $("#img_Pic").attr("src", json.result.retData);
                //EditMenuCode(json.result.id, json.result.retData)
                $("#hid_MenuCode").val(json.result.retData)
            },


        });
    }

    //function EditMenuCode(id, MenuCode) {
    //    $.ajax({
    //        type: "Post",
    //        url: "/SystemSettings/CommonInfo.ashx",
    //        data: { Func: "EditMenuCode", MenuID: id, MenuCode: MenuCode },
    //        dataType: "json",
    //        success: function (json) {
    //            var result = json.result;
    //            if (result.errNum == 0) {
    //                GetLeftNavigationMenu();
    //            } else {
    //                alert("操作失败");
    //            }
    //        },
    //        error: function (errMsg) {
    //            alert("操作失败");
    //        }
    //    });
    //}


    function AddCource() {
        var name = $("#txt_Name").val().trim();
        var MenuCode = $("#hid_MenuCode").val();
        if (!name.length) {
            layer.msg("请填写父节点名称！");
            return;
        }
        $.ajax({
            url: "Menu.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: { Name: name, id: $("#hid_id").val(), MenuCode: MenuCode, action: "Set_FMenuInfo" },
            success: function (json) {
                if (json.result == "CF") {
                    layer.msg("该父节点名称已存在！");
                }
                else if (json.result == "OK") {
                    parent.layer.msg('操作成功!');
                    parent.BindBuilding();
                    parent.CloseIFrameWindow();
                } else {
                    layer.msg("操作失败！");
                }
            },
            error: function (errMsg) {
                alert("操作失败");
            }
        });

    }
</script>


</html>
