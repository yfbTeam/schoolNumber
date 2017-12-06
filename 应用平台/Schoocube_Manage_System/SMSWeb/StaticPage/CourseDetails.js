var WebServiceUrl = "http://192.168.1.101";
var WebPostUrl = "[WebPostUrl]";
/*------------------------CourseMenu.js---------------------------*/
var UrlDate = new GetUrlDate();

function CourceMenu() {
    var Pid = UrlDate.ParentID;
    if (Pid != undefined) {

        //$.ajax({
        //    type: "Post",
        //    url: "http://192.168.1.101:8085/SystemSettings/CommonInfo.ashx",
        //    data: { Func: "GetLeftNavigationMenu", useridcard: $("#HUserIdCard").val(), Pid: UrlDate.ParentID, PageName: UrlDate.PageName },
        //    dataType: "json",
        //    async: false,
        //    success: function (json) {
        //        if (json.result.errNum.toString() == "0") {
        //            var CurrentClass = "";
        //            var location = WebPostUrl;
        //            $(json.result.retData).each(function () {
        //                if (this.IsOwner > 0) {

        //                    if (location.toString().indexOf(this.Url) > 0) {
        //                        CurrentClass = " class='active'";
        //                        $("#HPId").val(this.Id);
        //                        //ButtonList(this.Id);
        //                    }
        //                    else {
        //                        CurrentClass = "";
        //                    }
        //                    var li = "<li" + CurrentClass + "><a href=\"" + this.Url + "?ParentID=" + UrlDate.ParentID + "&PageName=" + this.Url + "\">" + this.Name + "</a></li> ";
        //                    $("#CourceMenu").append(li);
        //                }
        //            });
        //        }
        //    },
        //    error: function (errMsg) {
        //        layer.msg('操作失败！');
        //    }
        //});
    }
}

function ButtonList(pid) {
    //$.ajax({
    //    type: "Post",
    //    url: "http://192.168.1.101:8085/SystemSettings/CommonInfo.ashx",
    //    data: { Func: "GetLeftNavigationMenu", useridcard: $("#HUserIdCard").val(), Pid: pid },
    //    dataType: "json",
    //    success: function (json) {
    //        if (json.result.errNum.toString() == "0") {
    //            var ButtonCode = "";
    //            var location = WebPostUrl;
    //            $(json.result.retData).each(function () {
    //                if (this.IsOwner == "0") {
    //                    if (this.MenuCode.toString() != "") {
    //                        $("." + this.MenuCode).parent().remove();
    //                    }
    //                }
    //            });
    //            // layer.msg(json);
    //        }
    //    },
    //    error: function (errMsg) {
    //        layer.msg('操作失败！');
    //    }
    //});
}

/******************common.js*********************/
function DateTimeConvert(date, format, iseval) {
    iseval = iseval == false ? false : true;
    if (iseval) {
        date = date.replace(/(^\s*)|(\s*$)/g, "");
        if (date == "") {
            return "";
        }
        if (date.indexOf("Date") != -1) {
            date = eval(date.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
        } else {
            date = new Date(Date.parse(date));
        }
    }
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString();
    var twoMonth = month.length == 1 ? "0" + month : month; //月份为1位数时，前面加0
    var day = (date.getDate()).toString();
    var twoDay = day.length == 1 ? "0" + day : day; //天数为1位数时，前面加0
    var hour = (date.getHours()).toString();
    var twoHour = hour.length == 1 ? "0" + hour : hour; //小时数为1位数时，前面加0
    var minute = (date.getMinutes()).toString();
    var twoMinute = minute.length == 1 ? "0" + minute : minute; //分钟数为1位数时，前面加0
    var second = (date.getSeconds()).toString();
    var twoSecond = second.length == 1 ? "0" + second : second; //秒数为1位数时，前面加0
    var dateTime;
    if (format == "yyyy-MM-dd HH:mm:ss") {
        dateTime = year + "-" + twoMonth + "-" + twoDay + " " + twoHour + ":" + twoMinute + ":" + twoSecond;
    } else if (format == "yyyy-MM-dd HH:mm") {
        dateTime = year + "-" + twoMonth + "-" + twoDay + " " + twoHour + ":" + twoMinute;
    } else if (format == "年月日") {
        dateTime = year + "年" + month + "月" + day + "日";
    } else if (format == "yyyy-MM") {
        dateTime = year + "-" + twoMonth
    } else if (format == "MM-dd") {
        dateTime = twoMonth + "-" + twoDay
    }
    else if (format == "dd") {
        dateTime = twoDay;
    }
    else {
        dateTime = year + "-" + twoMonth + "-" + twoDay
    }
    return dateTime;
}

function DataState(IsDelete) {
    if (IsDelete == 0) {
        return "正常";
    } else if (IsDelete == 1) {
        return "删除";
    } else if (IsDelete == 2) {
        return "归档";
    }
}
//图片划过放大
function hoverEnlarge(obj) {
    obj.hover(function () {
        $(this).addClass('hover').css({ 'transition': ' all 0.6s 0.3s' });
    }, function () {
        $(this).removeClass('hover');
    })
}
//获取URL参数
function GetUrlDate() {
    var name, value;
    var str = WebPostUrl; //取得整个地址栏
    var num = str.indexOf("?")
    str = str.substr(num + 1); //取得所有参数   stringvar.substr(start [, length ]

    var arr = str.split("&"); //各个参数放到数组里
    for (var i = 0; i < arr.length; i++) {
        num = arr[i].indexOf("=");
        if (num > 0) {
            name = arr[i].substring(0, num);
            value = arr[i].substr(num + 1);
            this[name] = value;
        }
    }
}

/**改变启用禁用状态**/
/**obj当前超链接对象，itemid 选中行的主键，status 启用禁用的值，tablename 表名**/
function ChangeUseStatus(obj, itemid, status, tablename) {
    if (itemid != null && itemid != "") {
        jQuery.ajax({
            url: WebServiceUrl + "/Common/CommonFunction.asmx/ChangeUseStatus?jsoncallback=?",//random" + Math.random(),//方法所在页面和方法名
            type: "POST",
            data: { itemid: itemid, Status: status, tablename: tablename },
            success: function (json) {
                if (json.result != "0") {
                    //if (status == 0) {
                    //    $(obj).next().attr("class", "Disable");
                    //} else {
                    //    $(obj).prev().attr("class", "Disable");
                    //}
                    //$(obj).attr("class", "Enable");
                    getData(1);
                } else {
                    layer.msg("操作失败！");
                }
            },
            error: function (request) {
                layer.msg("操作失败");
            }
        });
    }
}

//js 获取地址栏参数
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]);
    return null;
}
/*************************************IFrame弹框方法***********************************************************/
var curWinindex;
function OpenIFrameWindow(title, url, width, height) {
    //iframe层
    var index = layer.open({
        type: 2,
        title: title,
        shadeClose: false,
        shade: 0.2,
        area: [width, height],
        content: url //iframe的url
    });
    curWinindex = index;
}
function CloseIFrameWindow() {
    layer.close(curWinindex);
}
function layerMsg(title) { //msg信息框
    layer.msg(title, {
        time: 0 //不自动关闭
        , btn: ['确定']
        , yes: function (index) {
            layer.close(index);
        }
    });
}

function Chapator() {
    $("#menu_side").html("");
    knowStatus = "hide";
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "Chapator", "CourseID": UrlDate.itemid },
        success: function (json) {
            //jsonChapator = json;
            BindChapator("0", "0", json);
            $("#menu_side").html(chapterDiv);
            DisplayKnowledge();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.msg(errorThrown);
        }
    });
    if (chapterDiv.length == 0) {
        layer.msg("无目录数据");
    }
    //   getData(1, 10);
}


function SortMenu(ID, Type) {
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "SortMenu", ID: ID, Type: Type },
        success: function (json) {
            var curindex = 0;
            if (json.result.errNum.toString() == "0") {
                layer.msg("修改成功！");
                chapterDiv = "";
                Chapator();
                MenuSide();
            }
            else {
                layer.msg(json.result.errMsg);
            }
        },
        error: function (errMsg) {
            layer.msg(errMsg);
        }
    });
}

function getData(startIndex, pageSize) {
    //初始化序号
    pageNum = (startIndex - 1) * pageSize + 1;
    //name = name || '';
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, ID: UrlDate.itemid },
        success: OnSuccess,
        error: OnError
    });
}

//绑定知识点
function BindKnowledge() {
    $("#KnowleagPoint").html("");
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "Chapator", "CourseID": UrlDate.itemid, Type: 4, Pid: $("#ChapterID").val() },
        success: function (json) {
            var curindex = 0;
            if (json.result.errNum.toString() == "0") {
                $(json.result.retData).each(function () {
                    var aclass = "";
                    if (curindex == 0) {
                        catawork_knowedgeid = this.ID;
                        aclass = "class='on'";
                    }
                    var a = "<a href=\"javascript:;\" " + aclass + " knowid='" + this.ID + "'>" + this.Name + "</a>";
                    $("#KnowleagPoint").append(a);
                    curindex++;
                })
            }
            else {
                catawork_knowedgeid = "0";
                $("#KnowleagPoint").html("<a href=\"javascript:;\">暂无知识点！</a>");
            }
            GetWorkData();
            $("#KnowleagPoint a").on("click", function () {
                catawork_knowedgeid = $(this).attr("knowid");
                $(this).addClass("on").siblings().removeClass("on");
                GetWorkData();
            });
        },
        error: function (errMsg) {
            layer.msg(errMsg);
        }
    });
}

function EditMenuName(em, id, e) {
    var name = $("#txt" + id).val();
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "reMenuName", ID: id, "NewName": name },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                layer.msg("重命名成功");
                chapterDiv = "";
                Chapator();
                MenuSide();
            }
            else { layer.msg('重命名失败！'); }
        },
        error: function (errMsg) {
            layer.msg('重命名失败！');
            $(em).parent().parent().children("span").html(oldname);
        }
    });
    stopEvent();
}

//添加导航
function AddNewMenu(id, e, type) {
    var CourseID = UrlDate.itemid;
    var FileName = $("#Menu" + id + "").val();

    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "AddNewMenu", CourseID: CourseID, FileName: FileName, Pid: id, type: type, IdCard: $("#HUserIdCard").val() },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                layer.msg("导航添加成功");
                chapterDiv = "";
                i = 0;
                j = 0;
                Chapator();
                BindKnowledge();
                MenuSide();
            }
            else {
                layer.msg(json.result.errMsg);
            }
        },
        error: function (errMsg) {
            layer.msg('导航添加失败！');
        }
    });
    stopEvent();
}

function DelMenu(id, e) {

    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "DelMenu", ID: id },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                layer.msg("导航删除成功");
                chapterDiv = "";
                Chapator();
                MenuSide();
            }
            else {
                layer.msg(json.result.errMsg);
            }
        },
        error: function (errMsg) {
            layer.msg('导航删除失败！');
        }
    });
    stopEvent();
}

//微课资源
function BindWeikeResource() {
    var ChapterID = $("#ChapterID").val();

    $("#weike").children().remove();
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "CourseManage/CouseResource.ashx", "Func": "GetResourceList", CourceID: UrlDate.itemid, IsVideo: 1, ChapterID: ChapterID },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#CountVideo").html(json.result.retData.length);
                $(json.result.retData).each(function () {
                    var li = " <li><div class=\"course_detail_img\"><img src=\"" + this.VidoeImag + "\" onerror=\"javascript:this.src='/images/viedo_default.jpg'\"/></div><p class=\"course_detail_name\">" +
                       this.Name + "</p><div class=\"course_detail_bg none\"><i class=\"icon icon-trash\" onclick=\"Delvideo(" + this.ID
                       + ")\" style=\"position:absolute;right:4px;top:4px;width:16px;height:16px;color:#fff;\"></i><a onclick=\"Show('" + this.ID + "');\" class='icon-play-circle' style='font-size:50px;'></a></div></li>";
                    $("#weike").append(li);
                })
            }
            else {
                //layer.msg(json.result.errMsg);
                $("#CountVideo").html("0");
            }
            $('.course_detail_lists li').hover(function () {
                $(this).find('.course_detail_bg').fadeIn();
            }, function () {
                $(this).find('.course_detail_bg').fadeOut();
            })
        },
        error: function (errMsg) {
            layer.msg('导航删除失败！');
        }
    });
}

//普通资源
function BindPutongResource() {
    var ChapterID = $("#ChapterID").val();

    $("#Resource").children().remove();
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "CourseManage/CouseResource.ashx", "Func": "GetResourceList", CourceID: UrlDate.itemid, IsVideo: 0, ChapterID: ChapterID },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#CountResource").html(json.result.retData.length);
                $(json.result.retData).each(function () {

                    var li = " <li class=\"clearfix\"><i class=\"ico-" + this.postfix.toString().substring(1) + "-min h-ico\"></i><p class=\"repository_name fl\" style='margin-left:15px;'>" +
        this.Name + this.postfix + "</p><div class=\"repository_download none\" onclick=\"DownLoad('" + this.FileUrl + "');\"> <i class=\"icon icon-download-alt\"></i></div><span class=\"repository_date fr\">" +
        this.CreateTime + "</span></li>";
                    $("#Resource").append(li);
                })
            }
            else {
                //layer.msg(json.result.errMsg);
                $("#CountResource").html("0");
            }
            $('.repository_lists>li').hover(function () {
                $(this).find('.repository_download').show();
            }, function () {
                $(this).find('.repository_download').hide();
            });
        },
        error: function (errMsg) {
            layer.msg(errMsg);
        }
    });
}

//任务
function BindExamPaper() {
    var ChapterID = $("#ChapterID").val();
    $("#Task").children().remove();
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { "PageName": "/OnlineLearning/TaskHandler.ashx", "Func": "GetTaskDataPage", CourceID: UrlDate.itemid, ChapterID: ChapterID, UserIdCard: $("#HUserIdCard").val() },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#CountTask").html(json.result.retData.PagedData.length);
                $(json.result.retData.PagedData).each(function () {
                    var li = "<li class=\"clearfix\"><div class=\"discuss_img fl\"><img src=\"/images/exam_img.png\" />" +
                        "</div><div class=\"test_description fl\" style=\"cursor:pointer;margin-left:10px;width:400px;\"><h2 onclick=\"LookTaskStatistics('" + this.ID + "','" + this.Name + "');\"><a href=\"javascript:;\">" + this.Name
                        + "</a><span class=\"test_type\">" + this.TaskType + "</span></h2><div class=\"notecnt\" style=\"cursor:pointer;color:#555555;font-size:14px;\" onclick=\"JumpToTask('" + this.RelationID + "','" + this.RelName + "','" + this.TaskType + "','" + this.ChapterID + "','" + this.ComCount + "','" + this.RelOtherField + "','self','tea');\">" +
                "任务：" + this.RelName + "( 权重：" + this.Weight + "&emsp; 学生范围：" + this.ClassStrName + ")</div>" + " <div class='clearfix mt5'><div class=\"clearfix fl caozuo_none\">"
                    + (this.IsCreate.toString() == "1" ? "<div class=\"fl\" style=\"color: #0b70bc\" onclick=\"DeleteTask('" + this.ID + "','false');\"><i class=\"icon icon-trash\" style=\"color: #0b70bc; display: inline-block;\"></i>删除 </div>" : " ") + "</div></div></div>" +
                        "  <div class=\"test_lists_right fr clearfix\"><div class=\"public_name fl\">发布人：" + this.CreateName + "</div><div class=\"dates_a dates_b fr pr\">"
                         + "<div class=\"seedeletion none\"><span class=\"preview pr\"><i class=\"icon icon-eye-open\"></i><em class=\"icon_tips\">预览</em></span>" +
                    "</div><div class=\"data\">发布时间：" + DateTimeConvert(this.CreateTime) + "</div></div></div></li>";
                    $("#Task").append(li);
                });
                hoverShowDelete("#Task");
            }
            else {
                //layer.msg(json.result.errMsg);
                $("#CountTask").html("0");
            }

        },
        error: function (errMsg) {
            layer.msg('导航删除失败！');
        }
    });
}

function GetDiscussDataPage(startIndex, pageSize) {
    if (isPower == 0) {
        return;
    }
    //初始化序号
    pageNum = (startIndex - 1) * pageSize + 1;
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: {
            "PageName": "OnlineLearning/TopicHandler.ashx",
            Func: "GetTopicDataPage",
            PageIndex: startIndex,
            pageSize: pageSize,
            Type: 0,
            CouseID: UrlDate.itemid,
            //ChapterID: $("#ChapterID").val(),
            TopicId: jump_topicid,
            Name: $("#txt_topicTitle").val().trim(),
            StuIDCard: $("#HStuIDCard").val(),
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#ul_topic").html('');
                $("#li_topic").tmpl(json.result.retData.PagedData).appendTo("#ul_topic");
                $("#pageBar").show();
                //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                makePageBar(GetDiscussDataPage, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                GetTopic_CommentDataPage(jump_topicid, "ul_topic", 0, "comment_tp", "li_comment", "span_replaycount");
                EditorArray_Topic = DynamicCreateKindEditor("ul_topic");
                hoverShowDelete("#ul_topic");
            }
            else {
                $("#ul_topic").html("<li>暂无讨论！</li>");
                $("#pageBar").hide();
            }
            jump_topicid = "";
        },
        error: function (errMsg) {
            $("#ul_topic").html(errMsg);
        }
    });
}

function GetNoteDataPage(startIndex, pageSize) {
    if (isPower == 0) {
        return;
    }
    //初始化序号
    pageNum = (startIndex - 1) * pageSize + 1;
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: {
            "PageName": "OnlineLearning/TopicHandler.ashx",
            Func: "GetTopicDataPage",
            PageIndex: startIndex,
            pageSize: pageSize,
            Type: 1,
            CouseID: UrlDate.itemid,
            //ChapterID: $("#ChapterID").val(),
            Name: $("#txt_noteTitle").val().trim(),
            StuIDCard: $("#HStuIDCard").val(),
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#ul_note").html('');
                $("#li_note").tmpl(json.result.retData.PagedData).appendTo("#ul_note");
                $("#pageBar_note").show();
                //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                makePageBar(GetNoteDataPage, document.getElementById("pageBar_note"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                GetTopic_CommentDataPage("", "ul_note", 1, "comment_note", "li_notecomment", "span_notereplaycount");
                EditorArray_Note = DynamicCreateKindEditor("ul_note");
                hoverShowDelete("#ul_note");
            }
            else {
                $("#ul_note").html("<li>暂无笔记！</li>");
                $("#pageBar_note").hide();
            }
        },
        error: function (errMsg) {
            $("#ul_note").html(errMsg);
        }
    });
}

function StudyTheCourseStu(coursetype) {
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: { PageName: "/OnlineLearning/MyLessonsHandler.ashx", "Func": "StudyTheCourseStu", CourseID: UrlDate.itemid, CourceType: coursetype },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                studyTheCourseStu = json.result.retData;
                studyTheCourseStu_Count = json.result.retData.length;
                if (UrlDate.nav_index) {
                    $('.coursedetail_nav a').eq(UrlDate.nav_index).click();
                }
            }
        }
    });
}

function GetEvalueDataPage(startIndex, pageSize) {

    //初始化序号
    pageNum = (startIndex - 1) * pageSize + 1;
    $.ajax({
        url: WebServiceUrl+"/StaticCommon.ashx",
        type: "post",
        async: false,
        dataType: "jsonp",
        jsonp: "jsoncallback",
        data: {
            "PageName": "/CourseManage/CourceManage.ashx",
            Func: "Course_EvalueList",
            PageIndex: startIndex,
            pageSize: pageSize,
            CourseID: UrlDate.itemid,
            "Ispage": true
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#ul_Evalue").html('');
                $("#li_Evalue").tmpl(json.result.retData.PagedData).appendTo("#ul_Evalue");
                $("#pageBar_Evalue").show();
                //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                makePageBar(GetEvalueDataPage, document.getElementById("pageBar_Evalue"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
            }
            else {
                $("#ul_Evalue").html("<li>暂无评论！</li>");
                $("#pageBar_Evalue").hide();
            }
            Star();
        },
        error: function (errMsg) {
            $("#ul_Evalue").html(errMsg);
        }
    });
}

