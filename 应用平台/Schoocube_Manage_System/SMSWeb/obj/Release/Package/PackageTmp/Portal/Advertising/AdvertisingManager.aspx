<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdvertisingManager.aspx.cs" Inherits="SMSWeb.Portal.Advertising.AdvertisingManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../../css/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../../js/menu_top.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <script id="tr_Advert" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>
                {{if Type==0}}联系我们
                {{else Type==1}}网站简介
                {{else Type==2}}友情链接
                {{else Type==3}}学校简介
                {{else Type==4}}校长寄语
                {{else Type==6}}学校历史
                {{else Type==7}}招生信息
                {{else Type==8}}就业分配
                {{else Type==9}}教学环境
                {{else Type==10}}校园文化
                {{else Type==11}}鉴定培训
                {{else Type==12}}友情链接
                {{else Type==13}}网上报名
                {{else Type==14}}学校特色
                {{else Type==15}}荣誉资质
                {{else Type==16}}明星学员
                {{else Type==17}}联系学校
                {{else}}暂无
                {{/if}}
            </td>
            <td>${Creator}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
            <td>
                <a href="javascript:;" onclick="javascript: OpenIFrameWindow('修改广告', 'AdvertisingEdit.aspx?Id=${Id}', '700px', '65%');"><i class="icon icon-edit" style="color:#fff;"></i>修改</a>
               <%-- <a href="javascript:;" onclick="DeleteAdvert('${Id}')"><i class="icon icon-road"></i>删除</a>--%>
            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <div class="newcourse_select clearfix">
                     <div class="clearfix fl course_select">
                        <label for="">选择类型：</label>
                        <select name="" class="select" id="selType" onchange="getData(1, 10)">
                            <option value="">请选择类型</option>
                            <option value="0">联系我们</option>
                            <option value="1">网站简介</option>
                            <option value="2">友情链接</option>
                            <option value="3">学校简介</option>
                            <option value="4">校长寄语</option>
                            <option value="6">学校历史</option>
                            <option value="7">招生信息</option>
                            <option value="8">就业分配</option>
                            <option value="9">教学环境</option>
                            <option value="10">校园文化</option>
                            <option value="11">鉴定培训</option>
                            <option value="12">友情链接</option>
                            <option value="13">网上报名</option>
                        </select>
                    </div>
                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('添加广告','AdvertisingEdit.aspx', '700px', '65%');"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>类型</th>
                                <th>创建时间</th>
                                <th>创建人</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="tb_Advert"></tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            getData(1, 10);
        });
        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdvertisingHandler.ashx",
                    Func: "GetPageList",
                    type: $("#selType").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_Advert").html('');
                        $("#tr_Advert").tmpl(json.result.retData.PagedData).appendTo("#tb_Advert");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_Advert").html("<tr><td colspan='5'>暂无系统通知！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function DeleteAdvert(delid) {
            layer.msg("确定要删除该通知?", {
                time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: { PageName: "PortalManage/AdvertisingHandler.ashx", Func: "UpdateAdvertising", Id: delid, IsDelete: 1 },
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

    </script>
</body>
</html>
