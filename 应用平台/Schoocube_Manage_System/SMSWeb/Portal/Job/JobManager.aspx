<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JobManager.aspx.cs" Inherits="SMSWeb.Portal.Job.JobManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="//PortalCss/reset.css" rel="stylesheet" />
    <link href="//PortalCss/layout.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="//css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="//css/common.css" />
    <link rel="stylesheet" type="text/css" href="//css/repository.css" />
    <link rel="stylesheet" type="text/css" href="//css/onlinetest.css" />
    <link href="//Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <style type="text/css">
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle;
        }
    </style>
    <script src="//Scripts/jquery-1.11.2.min.js"></script>
    <script src="//Scripts/layer/layer.js"></script>
    <script src="//PortalJs/layout.js"></script>
    <script src="//Scripts/Common.js"></script>
    <script src="//Scripts/jquery.tmpl.js"></script>
    <script src="//Scripts/PageBar.js"></script>
    <script src="//Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="//Scripts/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script src="//Scripts/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <script src="//Scripts/zTree/js/jquery.ztree.exedit-3.5.js"></script>
    <script id="tr_course" type="text/x-jquery-tmpl">

        <tr>
            <td>{{if CourseStr.indexOf("," + ID + ",") > -1 }}
               &nbsp;
                 {{else}}
                 <input type="checkbox" name="cbkmessage" value="${ID}" onclick="checkItem(this)" />
                {{/if}}
            </td>
            <td>${pageIndex()}</td>
            <td>${Name}</td>
            <td>{{if ImageUrl==""}}
                    <img src="/PortalImages/defaultimg.jpg" alt="" width="65" height="65" />
                {{else}}
                     <img src="${ImageUrl}" alt="" width="65" height="65" />
                {{/if}}</td>
            <td>{{if IsCharge==1}}收费
            {{else}}免费
                  {{/if}}
            </td>
            <td>${CoursePrice}</td>
            <td>${GradeName}</td>
            <td>{{if CourseStr.indexOf("," + ID + ",") >-1 }}
                  <a href="javascript:EditCourse(${ID},'del');"><i class="icon icon-road"></i>删除</a>
                {{else}}
               <a href="javascript:EditCourse(${ID},'add');"><i class="icon icon-road"></i>添加</a>
                {{/if}}
                 
            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server" style="position: relative;">
        <asp:HiddenField ID="hId" runat="server" />
        <input type="hidden" id="hgsv" />
        <div class="ztreea_left fl" style="width: 220px; position: absolute; left: 0; top: 0;">
            <h1>菜单管理</h1>
            <ul id="treeRerouce" class="ztree"></ul>
        </div>
        <div class=" ztreea_right" style="padding-left: 220px;">
            <div class="onlinetest_item">
                <div class="course_manage bordshadrad">
                    <div class="newcourse_select clearfix">
                        <div class="distributed fr">
                            <a href="javascript:MoreEditCourse('add');">批量添加</a>
                          <%--  <a href="javascript:MoreEditCourse('del');">批量删除</a>--%>
                        </div>
                    </div>
                    <div class="wrap">
                        <table class="PL_form">
                            <thead>
                                <tr>
                                    <th>
                                        <input type="checkbox" name="cbkAllmessage" class="Check_box" onclick="checkItem(this);" /></th>
                                    <th class="number">序号</th>
                                    <th>标题</th>
                                    <th>图片信息</th>
                                    <th>收费类型</th>
                                    <th>收费金额</th>
                                    <th>年级</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="tb_course">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!--分页-->
            <div class="page">
                <span id="pageBar"></span>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            initCourse();
            initGrade();
        })
        var AllArrys = [];
        var PeriodArrys = [];
        var CourseStr = "";
        var saveCourseIdstr = "";
        var setting = {
            data: {
                key: {
                    title: "t"
                },
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeClick: beforeClick,
                onClick: onClick
            }
        };

        function beforeClick(treeId, treeNode, clickFlag) {

        }
        function onClick(event, treeId, treeNode, clickFlag) {
            var node = treeNode;
            if (node != null && node.gsv != null) {
                $("#hgsv").val(node.gsv);
                QueryCourse(1, 30);
            }
        }

        function initCourse(isQueryAll) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/JobHandler.ashx",
                    Func: "GetCourseListByJobIds",
                    JobIDs: $("#hId").val(),
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        var CourseArrys = [];
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                CourseArrys.push(items[i].ID);
                            }
                            saveCourseIdstr = CourseArrys.toString();
                            CourseStr = "," + saveCourseIdstr + ",";
                            if (isQueryAll == null) QueryCourse(1, 10, saveCourseIdstr);
                            else QueryCourse(1, 10);
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function initGrade() {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "GetGrade" },
                success: function (json) {
                    var grades = json.result.retData;
                    if (grades != null && grades.length > 0) {
                        for (var i = 0; i < grades.length; i++) {
                            var obj = new Object();
                            obj.gid = grades[i].Id;
                            obj.pid = grades[i].PeriodID;
                            PeriodArrys.push(obj);
                        }
                        BindPeriod();
                    }
                }
            })
        }


        function QueryCourse(startIndex, pageSize,ids) {
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/JobHandler.ashx",
                    Func: "GetPageCourseList",
                    CatagoryID: $("#hgsv").val(),
                    inIDs:ids,
                    isPage: true,
                    PageIndex: startIndex,
                    PageSize: pageSize,
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData.PagedData;
                        $("#tb_course").html('');
                        if (items != null && items.length > 0) {
                            $("#tr_course").tmpl(items).appendTo("#tb_course");
                            makePageBar(QueryCourse, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 30, json.result.retData.RowCount);
                        } else {
                            $("#tb_course").html('<tr><td colspan="8">暂无数据！</td></tr>');
                        }
                    } else {
                        $("#tb_course").html('<tr><td colspan="8">暂无数据！</td></tr>');
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
        //学年
        function BindPeriod() {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "Period" },
                success: function (json) {
                    var ItemsGrade = json.GradeOfSubject.retData;
                    var arryGrade = [];
                    for (var i = 0; i < ItemsGrade.length; i++) {
                        if (i == 0) {
                            var obj = new Object();
                            obj.id = ItemsGrade[i].GradeID;
                            obj.name = ItemsGrade[i].GradeName;
                            obj.pid = 0;
                            obj.gradeId = ItemsGrade[i].GradeID;
                            for (var j = 0; j < PeriodArrys.length; j++) {
                                if (PeriodArrys[j].gid == ItemsGrade[i].GradeID) {
                                    obj.gsv = PeriodArrys[j].pid;
                                    break;
                                }
                            }
                            if (obj.gsv == null) {
                                obj.gsv = "null";
                            }
                            AllArrys.push(obj);
                            arryGrade.push(obj);
                        } else {
                            if (ItemsGrade[i].GradeName != ItemsGrade[i - 1].GradeName) {
                                var obj = new Object();
                                obj.id = ItemsGrade[i].GradeID;
                                obj.name = ItemsGrade[i].GradeName;
                                obj.gradeId = ItemsGrade[i].GradeID;
                                for (var j = 0; j < PeriodArrys.length; j++) {
                                    if (PeriodArrys[j].gid == ItemsGrade[i].GradeID) {
                                        obj.gsv = PeriodArrys[j].pid;
                                        break;
                                    }
                                }
                                if (obj.gsv == null) {
                                    obj.gsv = "null";
                                }
                                obj.pId = 0;
                                AllArrys.push(obj);
                                arryGrade.push(obj);
                            }
                        }
                    }

                    var ItemsSubject = json.GradeOfSubject.retData;
                    var arrySubject = [];
                    for (var i = 0; i < arryGrade.length; i++) {
                        var gid = arryGrade[i].id;
                        for (var j = 0; j < ItemsSubject.length; j++) {
                            if (gid == ItemsSubject[j].GradeID) {
                                var obj = new Object();
                                obj.id = RndNum(3);
                                obj.name = ItemsSubject[j].SubjectName;
                                obj.subjectId = ItemsSubject[j].Id;
                                obj.gsv = arryGrade[i].gsv + "|" + ItemsSubject[j].SubjectID;
                                obj.pId = gid;
                                arrySubject.push(obj);
                                AllArrys.push(obj);
                            }
                        }
                    }

                    var ItemsTVersion = json.TextbookVersion.retData;
                    var arryTVersion = [];
                    for (var i = 0; i < arrySubject.length; i++) {
                        var sid = arrySubject[i].id;
                        for (var j = 0; j < ItemsTVersion.length; j++) {
                            var obj = new Object();
                            obj.id = RndNum(5);
                            obj.name = ItemsTVersion[j].Name;
                            obj.versionId = ItemsTVersion[j].Id;
                            obj.gsv = arrySubject[i].gsv + "|" + ItemsTVersion[j].Id;
                            obj.pId = sid;
                            arryTVersion.push(obj);
                            AllArrys.push(obj);
                        }
                    }

                    var itemsTextbook = json.Textbook.retData;
                    var saveArry = AllArrys;

                    for (var j = 0; j < itemsTextbook.length; j++) {
                        var new_pid = itemsTextbook[j].PeriodID;
                        var new_sid = itemsTextbook[j].SubjectID;
                        var new_vid = itemsTextbook[j].VersionID;
                        var vvv = new_pid + "|" + new_sid + "|" + new_vid;
                        for (var i = 0; i < saveArry.length; i++) {
                            var gsv = saveArry[i].gsv;
                            if (gsv == vvv) {
                                var obj = new Object();
                                obj.id = RndNum(7);
                                obj.name = itemsTextbook[j].Name;
                                obj.bookId = itemsTextbook[j].Id;
                                obj.pId = saveArry[i].id;
                                obj.gsv = gsv + "|" + itemsTextbook[j].Id;
                                AllArrys.push(obj);
                            }
                        }

                    }

                    $.fn.zTree.init($("#treeRerouce"), setting, AllArrys);
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

        function RndNum(n) {
            var rnd = "";
            for (var i = 0; i < n; i++)
                rnd += Math.floor((Math.random() * 10 + 1));
            return rnd;
        }

        function checkItem(obj) {
            var checkArry = $(".PL_form").find("input[type='checkbox']");
            checkAll(checkArry);
        }

        function checkAll(oInput) {
            var isCheckAll = function () {
                for (var i = 1, n = 0; i < oInput.length; i++) {
                    oInput[i].checked && n++
                }
                oInput[0].checked = n == oInput.length - 1;
            };
            //全选
            oInput[0].onchange = function () {
                for (var i = 1; i < oInput.length; i++) {
                    oInput[i].checked = this.checked
                }
                isCheckAll()
            };
            //根据复选个数更新全选框状态
            for (var i = 1; i < oInput.length; i++) {
                oInput[i].onchange = function () {
                    isCheckAll()
                }
            }
        }

        function EditCourse(cid,operation)
        {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/JobHandler.ashx",
                    Func: "EditCourseForJob",
                    CourseID: cid,
                    JobID: $("#hId").val(),
                    Operation: operation
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg("操作成功！");
                        initCourse(true);
                        parent.getData(1, 10);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function MoreEditCourse(operation) {
            var cids = "";
            $("input[name='cbkmessage']").each(function () {
                if ($(this).is(':checked')) {
                    var vals = $(this).val();
                    cids += vals + ",";
                }
            });
            if (cids != "") {
                cids = cids.substring(0, cids.length - 1);
            } else {
                layer.msg("请选择课程！");
                return false;
            }

            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/JobHandler.ashx",
                    Func: "MoreEditCourseForJob",
                    CourseIds: cids,
                    JobID: $("#hId").val(),
                    Operation: operation
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg("操作成功！");
                        initCourse(true);
                        parent.getData(1, 10);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</body>
</html>
