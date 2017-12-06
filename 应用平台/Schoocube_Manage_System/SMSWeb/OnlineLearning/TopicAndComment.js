
/**********************************************讨论及笔记操作开始***********************************************************/
//绑定讨论及笔记取前五条
function GetTopicData(startIndex, pageSize, type, pageid, ispage, ulid, liid, prefix_comm_ul, comm_li, prefix_replaycount) {
    type = arguments[2] || 0;
    pageid = arguments[3] || "pageBar";
    ispage = ispage == false ? false : true;
    ulid = arguments[5] || "ul_topic";
    liid = arguments[6] || "li_topic";
    prefix_comm_ul = arguments[7] || "comment_tp";
    comm_li = arguments[8] || "li_comment";
    prefix_replaycount = arguments[9] || "span_replaycount";
    //初始化序号 
    pageNum = (startIndex - 1) * pageSize + 1;
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TopicHandler.ashx",
            Func: "GetTopicDataPage",
            PageIndex: startIndex,
            pageSize: pageSize,
            Type: type,
            CouseID: UrlDate.itemid,
            ChapterID: $("#ChapterID").val(),
            StuIDCard: $("#HStuIDCard").val(),
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (ulid == "ul_discuss" && json.result.errNum.toString() == "999") {
                $("#CountTopic").html(0);
            } else if (json.result.errNum.toString() == "0") {
                if (ulid == "ul_discuss") {
                    $("#CountTopic").html(json.result.retData.PagedData.length);
                }
                $("#" + ulid).html('');
                $("#" + liid).tmpl(json.result.retData.PagedData).appendTo("#" + ulid);
                if (ispage) {
                    //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                    makePageBar(GetTopicData, document.getElementById(pageid), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
                }
                hoverShowDelete("#" + ulid);
                GetTopic_CommentDataPage("", ulid, type, prefix_comm_ul, comm_li, prefix_replaycount);
                var curEditorArray = DynamicCreateKindEditor(ulid);
                if (ulid == "ul_discuss") {
                    type = "";
                    EditorArray_Discuss = curEditorArray;
                } else if (type == 0) { EditorArray_Topic = curEditorArray; }
                else { EditorArray_Note = curEditorArray; }
            }
            else {
                $("#" + ulid).html(type == 0 ? "<li>暂无讨论！</li>" : "<li class='noteitem'>暂无笔记！</li>");
            }
            if (UrlDate.initchapterid) { //如果是观看视频页面，需要动态计算高度
                reSize();
            }
        },
        error: function (errMsg) {
            $("#" + ulid).html(errMsg);
        }
    });
}

//绑定所有讨论及笔记--不分页
function GetTopicDataNotPage(type,ulid, liid, prefix_comm_ul, comm_li, prefix_replaycount) {
    type = arguments[0] || 0;   
    ulid = arguments[1] || "ul_topic";
    liid = arguments[2] || "li_topic";
    prefix_comm_ul = arguments[3] || "comment_tp";
    comm_li = arguments[4] || "li_comment";
    prefix_replaycount = arguments[5] || "span_replaycount";
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TopicHandler.ashx",
            Func: "GetTopicDataPage",            
            Type: type,
            ispage:false,
            CouseID: UrlDate.itemid,
            ChapterID: $("#ChapterID").val(),
            StuIDCard: $("#HStuIDCard").val(),
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (ulid == "ul_discuss" && json.result.errNum.toString() == "999") {
                $("#CountTopic").html(0);
            } else if (json.result.errNum.toString() == "0") {
                if (ulid == "ul_discuss") {
                    $("#CountTopic").html(json.result.retData.length);
                }
                $("#" + ulid).html('');
                $("#" + liid).tmpl(json.result.retData).appendTo("#" + ulid);                
                hoverShowDelete("#" + ulid);
                GetTopic_CommentDataPage("", ulid, type, prefix_comm_ul, comm_li, prefix_replaycount);
                var curEditorArray = DynamicCreateKindEditor(ulid);
                if (ulid == "ul_discuss") {
                    type = "";
                    EditorArray_Discuss = curEditorArray;
                } else if (type == 0) { EditorArray_Topic = curEditorArray; }
                else { EditorArray_Note = curEditorArray; }
            }
            else {
                $("#" + ulid).html(type == 0 ? "<li>暂无讨论！</li>" : "<li class='noteitem'>暂无笔记！</li>");
            }
            if (UrlDate.initchapterid) { //如果是观看视频页面，需要动态计算高度
                reSize();
            }
        },
        error: function (errMsg) {
            $("#" + ulid).html(errMsg);
        }
    });
}

//绑定所有讨论及笔记的评论--不分页
function GetTopic_CommentDataPage(topicid, pulid, type, prefix_comm_ul, comm_li, prefix_replaycount) {
    pulid = arguments[1] || "ul_topic";
    type = arguments[2] || 0;
    prefix_comm_ul = arguments[3] || "comment_tp";
    comm_li = arguments[4] || "li_comment";
    prefix_replaycount = arguments[5] || "span_replaycount";
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TopicHandler.ashx",
            Func: "GetTopic_CommentDataPage",
            ispage: false,
            Type: type,
            CouseID: UrlDate.itemid,
            //ChapterID: $("#ChapterID").val(),
            Name: type == 0 ? ($("#txt_topicTitle").val() || "").trim() : ($("#txt_noteTitle").val() || "").trim(),
            TopicId: topicid,
            StuIDCard: $("#HStuIDCard").val(),
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                if (topicid != "") {
                    var oneCommulid = "#" + prefix_comm_ul + topicid;
                    $(oneCommulid).html("");
                    $("#" + comm_li).tmpl(json.result.retData).appendTo(oneCommulid);
                    $("#" + prefix_replaycount + topicid).html($(oneCommulid).find("li").length);
                } else {
                    $("#" + pulid).children().each(function () {
                        var commObjid = $(this).find(".commenta").attr('id')
                        var curTopicid = commObjid.replace(prefix_comm_ul, '');
                        $.each(json.result.retData, function (i, data) {
                            if (data.TopicId == curTopicid) {
                                $("#" + comm_li).tmpl(data).appendTo("#" + commObjid);
                            }
                        });
                        var replaycount = $("#" + commObjid).find("li").length;
                        $("#" + prefix_replaycount + curTopicid).html(replaycount);
                    });
                    if (pulid == "ul_discuss") {
                        type = "";
                    }
                    //评论显示
                    $('.comment' + type).click(function () {
                        $(this).parents('li').find('.comment_wrap').toggle();
                    });
                }
            }
        }
    });
}

//添加评论
function AddTopic_Comment(topicid, area_conid, pulid, pliid, type, prefix_comm_ul, comm_li, prefix_replaycount) {
    pulid = arguments[2] || "ul_topic";
    pliid = arguments[3] || "li_topic";
    type = arguments[4] || 0;
    prefix_comm_ul = arguments[5] || "comment_tp";
    comm_li = arguments[6] || "li_comment";
    prefix_replaycount = arguments[7] || "span_replaycount";
    var li_index = $("#" + pliid + "_" + topicid).index();
    var curEditor = pulid == "ul_discuss" ? EditorArray_Discuss[li_index] : (type == 0 ? EditorArray_Topic[li_index] : EditorArray_Note[li_index]);
    var contents = curEditor.html().trim(); //$("#" + area_conid).val().trim();
    if (!contents.length || contents == "请添加你的评论...") {
        layer.msg('请填写评论内容！');
        return;
    }
    contents = encodeURIComponent(contents);
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TopicHandler.ashx",
            Func: "AddTopic_Comment",
            TopicId: topicid,
            Contents: contents,
            UserIdCard: $("#HUserIdCard").val(),
            ClassID: $("#Hid_ClassID").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                GetTopic_CommentDataPage(topicid, pulid, type, prefix_comm_ul, comm_li, prefix_replaycount);
                $("#" + area_conid).val('');
                curEditor.edit.html("请添加你的评论...");
            }
        },
        error: function (errMsg) {

        }
    });
}

//点赞
function ClickGood(topicid, spanid) {
    var goodtype = "1";
    var isgoodclick = $("#" + spanid).attr("isgoodclick");
    if (isgoodclick == "1") {
        goodtype = "0";
    }
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TopicHandler.ashx",
            Func: "ClickGood",
            ItemId: topicid,
            GoodType:goodtype,
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#" + spanid).attr("isgoodclick", goodtype);
                var oldcount = parseInt($("#" + spanid).html());
                var newcount = goodtype == "1" ? (oldcount + 1) : (oldcount-1);
                $("#" + spanid).html(newcount);
                if (newcount == 0) {
                    $("#" + spanid + "_i").css("color", "#999");
                } else {
                    $("#" + spanid + "_i").css("color", "#21A557");
                }
                layer.msg(goodtype=="1"?"点赞成功！":"取消点赞成功！");
            }
        },
        error: function (errMsg) {

        }
    });
}

//改变共享状态
function ChangeShareStatus(topicid, imgid, iscreate) {
    var isshare = $("#" + imgid).attr("isshare");
    if (iscreate == "0") {
        layer.msg("只有本人才能" + (isshare == "0" ? "共享！" : "取消共享！"));
        return;
    }
    isshare = isshare == "0" ? "1" : "0";
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TopicHandler.ashx",
            Func: "ChangeShareStatus",
            ItemId: topicid,
            IsShare: isshare,
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#" + imgid).attr("isshare", isshare);
                $("#" + imgid).attr('src', isshare == "0" ? "/images/share.png" : "/images/share2.png");
                layer.msg(isshare == "0" ? "取消共享成功！" : "共享成功！");
            }
        },
        error: function (errMsg) {

        }
    });
}

//删除讨论或笔记
function DeleteTopic(delid, ispage, type, ulid) {
    ispage = arguments[1] || "false";
    type = arguments[2] || 0;
    ulid = arguments[3] || "ul_topic";    
    layer.msg("确定要删除该"+(type==0?"讨论":"笔记")+"?", {
        time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: {
                           PageName: "/OnlineLearning/TopicHandler.ashx",
                           Func: "DeleteTopic",
                           DelId: delid,
                           UserIdCard: $("#HUserIdCard").val()
                       },
                       success: function (json) {
                           if (json.result.errNum.toString() == "0") {
                               layer.msg("删除成功");
                               if (ispage == "false") {
                                   if (ulid == "ul_discuss") {
                                       GetTopicData(1, 5, 0, " ", false, "ul_discuss", "li_discuss", "comment_discuss", "li_discusscomment", "span_discussreplaycount");
                                   } else {
                                       if (type == 0) {
                                           GetTopicData(1, 5, 0, " ", false);
                                       } else {
                                           GetTopicData(1, 5, 1, " ", false, "ul_note", "li_note", "comment_note", "li_notecomment", "span_notereplaycount");
                                       }
                                   }
                               } else {
                                   if (type == 0) { GetDiscussDataPage(1, 5); } else { GetNoteDataPage(1, 5); }
                               }
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

//删除评论
function DeleteTopic_Comment(delid, topicid, pulid, type, prefix_comm_ul, comm_li, prefix_replaycount) {
    pulid = arguments[2] || "ul_topic";
    type = arguments[3] || 0;
    prefix_comm_ul = arguments[4] || "comment_tp";
    comm_li = arguments[5] || "li_comment";
    prefix_replaycount = arguments[6] || "span_replaycount";
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TopicHandler.ashx",
            Func: "DeleteTopic_Comment",
            DelId: delid,
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                GetTopic_CommentDataPage(topicid, pulid, type, prefix_comm_ul, comm_li, prefix_replaycount);
            }
        },
        error: function (errMsg) {

        }
    });
}

var EditorArray_Discuss, EditorArray_Topic, EditorArray_Note;
//动态创建多个KindEditor编辑器
var K = window.KindEditor;//编辑器全局变量   
function DynamicCreateKindEditor(ulid) {
    var kinditerindex = 0; //编辑器初始索
    $AllArea = $("#" + ulid).find("textarea");
    var kinditerArry = new Array($AllArea.length); //多个编辑器的数组
    $AllArea.each(function (index, item) {
        var objId = $(this).attr("id");
        kinditerArry[kinditerindex] = K.create('#' + objId, {
            width: '100%',
            height: '70px',
            allowFileManager: false,
            items: [
	            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', "strikethrough",
	            'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
	            'insertunorderedlist', '|', 'undo', 'redo', '|', 'emoticons', 'image', 'link'],
            resizeType: 0,
            uploadJson: "/CourseManage/Uploade.ashx?Func=UploadTopic_Comment_Image",
            //得到焦点事件
            afterFocus: function () {
                self.edit = edit = this; var strIndex = self.edit.html().indexOf("请添加你的评论..."); if (strIndex != -1) { self.edit.html(self.edit.html().replace("请添加你的评论...", "")); }
            },
            //失去焦点事件
            afterBlur: function () { this.sync(); self.edit = edit = this; if (self.edit.isEmpty()) { self.edit.html("请添加你的评论..."); } },   //关键  同步KindEditor的值到textarea文本框   解决了多个editor的取值问题
            afterCreate: function () {
                var self = this;
                self.html("请添加你的评论...");
                K.ctrl(document, 13, function () {
                    K('form[name=example]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                    K('form[name=example]')[0].submit();

                });
            }
        });
        kinditerindex++;
    });
    return kinditerArry;
}

//适用于页面中一处使用KindEditor，多处使用的话,索引不好找。
var editor_Single;
function DynamicCreateKindEditor_Single(ulid) {
    var idArray = [];
    $("#" + ulid).find("textarea").each(function (index, item) {
        idArray.push("#" + $(this).attr("id"));
    });
    //创建编辑器后可以用 KindEditor.instances 数组取得已创建的所有KEditor对象。
    KindEditor.ready(function (K) {
        editor_Single = K.create(idArray.join(","), {
            width: '100%',
            height: '70px',
            allowFileManager: false,
            items: [
                'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', "strikethrough",
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'undo', 'redo', '|', 'emoticons', 'image', 'link'],
            resizeType: 0,
            //uploadJson: FirstUrl + "/_layouts/15/Handler/OrganizeStructure.aspx?method=Upload_json",
            afterCreate: function () {
                var self = this;
                K.ctrl(document, 13, function () {
                    self.sync();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                });
            }, afterBlur: function () { this.sync(); }
        });
    });
    //KindEditor.instances;//KEditor数组,取得已创建的所有KEditor对象。
}
/**********************************************讨论及笔记操作结束***********************************************************/

/**********************************************任务操作开始*****************************************************************/
//绑定任务取前五条
function BindCourseTask(startIndex, pageSize, pageid, ispage, ulid, liid) {
    startIndex = arguments[0] || 1;
    pageSize = arguments[1] || 10;
    pageid = arguments[2] || "pageBar_task";
    ispage = ispage == false ? false : true;
    ulid = arguments[4] || "ul_task";
    liid = arguments[5] || "li_task";
    $("#" + ulid).children().remove();
    $.ajax({
        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TaskHandler.ashx",
            Func: "GetTaskDataPage",
            CourceID: UrlDate.itemid,
            ChapterID: $("#ChapterID").val(),
            PageIndex: startIndex,
            pageSize: pageSize,
            StuIDCard: $("#HStuIDCard").val(),
            ClassID: $("#Hid_ClassID").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "999") {
                $("#" + ulid).html('<li>暂无任务！</li>');
            } else if (json.result.errNum.toString() == "0") {
                $("#CountTask").html(json.result.retData.PagedData.length);
                $("#" + ulid).html('');
                $("#" + liid).tmpl(json.result.retData.PagedData).appendTo("#" + ulid);
                if (ispage) {
                    //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                    makePageBar(BindCourseTask, document.getElementById(pageid), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
                }
                hoverShowDelete("#" + ulid);
            }
            else { $("#" + ulid).html("<li class='noteitem'>暂无任务！</li>"); }
        },
        error: function (errMsg) {
            layer.msg('加载失败！');
        }
    });
}

//绑定所有任务--不分页
function BindCourseTaskNotPage(ulid, liid) {
    ulid = arguments[0] || "ul_task";
    liid = arguments[1] || "li_task";
    $("#" + ulid).children().remove();
    $.ajax({
        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TaskHandler.ashx",
            Func: "GetTaskDataPage",
            CourceID: UrlDate.itemid,
            ChapterID: $("#ChapterID").val(),
            ispage:false,
            StuIDCard: $("#HStuIDCard").val(),
            ClassID: $("#Hid_ClassID").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "999") {
                $("#" + ulid).html('<li>暂无任务！</li>');
            } else if (json.result.errNum.toString() == "0") {
                $("#CountTask").html(json.result.retData.length);
                $("#" + ulid).html('');
                $("#" + liid).tmpl(json.result.retData).appendTo("#" + ulid);                
                hoverShowDelete("#" + ulid);
            }
            else { $("#" + ulid).html("<li class='noteitem'>暂无任务！</li>"); }
        },
        error: function (errMsg) {
            layer.msg('加载失败！');
        }
    });
}

//绑定所有任务--分页
function GetTaskDataPage(startIndex, pageSize) {
    if (isPower == 0) {
        return;
    }
    //初始化序号 
    pageNum = (startIndex - 1) * pageSize + 1;
    $.ajax({
        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/TaskHandler.ashx",
            Func: "GetTaskDataPage",
            CourceID: UrlDate.itemid,
            //ChapterID: $("#ChapterID").val(),
            Name: ($("#txt_taskTitle").val() || "").trim(),
            PageIndex: startIndex,
            pageSize: pageSize,
            StuIDCard: $("#HStuIDCard").val(),
            ClassID: $("#Hid_ClassID").val(),
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#ul_task").html('');
                $("#li_task").tmpl(json.result.retData.PagedData).appendTo("#ul_task");
                $("#pageBar_task").show();
                //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                makePageBar(GetTaskDataPage, document.getElementById("pageBar_task"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                hoverShowDelete("#ul_task");
            }
            else { $("#ul_task").html("<li>暂无任务！</li>"); $("#pageBar_task").hide(); }

        },
        error: function (errMsg) {
            $("#ul_task").html(errMsg);
        }
    });
}

var jump_topicid = "";
function JumpToTask(relid, relname, tasktype, chapterID, comcount, RelOtherField, jumptype, roletype) {
    jumptype = arguments[6] || 'self';
    roletype = arguments[7] || 'stu';
    if (tasktype == "学资源") {
        if (roletype == "tea") {
            OpenIFrameWindow('视频预览', 'ShowMove.aspx?ID=' + relid, '600px', '400px');
        } else {
            location.href = '/OnlineLearning/PlayerStudy.aspx?itemid=' + UrlDate.itemid + '&videoid=' + relid
            + '&comchapterid=' + chapterID + '&initchapterid=' + chapterID.split(',')[0] + "&flag=" + UrlDate.flag;
        }
    } else if (tasktype == "试卷") {
        if (user_pagetype == "stu") {
            if (comcount == "0") {
                window.open("/Exam/onlineanswer.aspx?id=" + relid, "_blank");
            }
            else {
                window.open("/Exam/AnsweredExam.aspx?id=" + relid + "&name=" + $("#HUserName").val(), "_blank");
            }
        } else {
            window.open("/Exam/ExamPaperDetail.aspx?id=" + relid, "_blank");
        }
    } else if (tasktype == "讨论") {
        if (jumptype == "noself") {
            location.href = "StuLessonDetail.aspx?itemid=" + UrlDate.itemid + "&nav_index=1&relname=" + relname + "&flag=" + UrlDate.flag;
        } else {
            $("#txt_topicTitle").val(relname);
            jump_topicid = relid;
            $('.coursedetail_nav a').eq(1).click();
        }
    } else if (tasktype == "作业") {
        upworkid = relid;
        $("#txt_workname").val(relname);
        work_knowedgeid = RelOtherField;
        $('.coursedetail_nav a').eq(4).click();
    } else if (tasktype == "调查问卷") {
        //if (user_pagetype == "stu") {
        //    if (comcount == "0") {
        //        window.open("/Exam/QuestionnaireSurvey.aspx?id=" + relid, "_blank");
        //    } else {
        //        window.open("/Exam/AnsweredExam.aspx?id=" + relid, "_blank");
        //    }
        //} else {

        //}        
    }
}

//删除任务
function DeleteTask(delid, ispage) {
    ispage = arguments[1] || "false";
    layer.msg("确定要删除该任务?", {
        time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: {
                           PageName: "/OnlineLearning/TaskHandler.ashx",
                           Func: "DeleteTask",
                           DelId: delid,
                           UserIdCard: $("#HUserIdCard").val()
                       },
                       success: function (json) {
                           if (json.result.errNum.toString() == "0") {
                               layer.msg("删除成功");
                               if (ispage == "false") {
                                   BindExamPaper();
                               } else {
                                   GetTaskDataPage(1, 5);
                               }
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
/**********************************************任务操作结束*****************************************************************/

/**********************************************作业操作开始*****************************************************************/
var catawork_knowedgeid = "0";
//绑定目录选项卡下的作业
function GetWorkData(ulid, liid, uploadifycss, prefix_id) {
    ulid = arguments[0] || "ul_catalogwork";
    liid = arguments[1] || "li_catalogwork";
    uploadifycss = arguments[2] || ".uploadify_catalogwork";
    prefix_id = arguments[3] || "uploadifycata_";
    $("#" + ulid).children().remove();
    $.ajax({
        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/WorkHandler.ashx",
            Func: "GetWorkDataPage",
            CourseID: UrlDate.itemid,
            ChapterID: $("#ChapterID").val(),
            PointID: catawork_knowedgeid,
            ispage: false,
            StuIDCard: $("#HStuIDCard").val(),
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            if (json.result.errNum.toString() == "999") {
                $("#CountWork").html(0);
            } else if (json.result.errNum.toString() == "0") {
                $("#CountWork").html(json.result.retData.length);
                $("#" + ulid).html('');
                $("#" + liid).tmpl(json.result.retData).appendTo("#" + ulid);
                hoverShowDelete("#" +ulid);
                UploadFile(uploadifycss, prefix_id, liid + "_");
                GetCatelogSubmitWorkData();
            }
            else { $("#CountTask").html(0); }
        },
        error: function (errMsg) {
            $("#" + liid).html(errMsg);
        }
    });
}
//绑定目录选项卡下的作业下提交的数据
function GetCatelogSubmitWorkData() {
    $.ajax({
        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/WorkHandler.ashx",
            Func: "GetWorkCorrectRelDataPage",
            CourseID: UrlDate.itemid,
            ChapterID: $("#ChapterID").val(),
            PointID: catawork_knowedgeid,
            WorkId: upworkid,
            ispage: false,
            StuIDCard: $("#HStuIDCard").val(),
            ClassID: $("#Hid_ClassID").val()
        },
        success: function (json) {
            if (upworkid != "") {
                var tb_workrel = "#tb_catelogworkrel_" + upworkid;
                $(tb_workrel).html("");
                var curworkdata = json.result.retData;
                $("#tr_catalogwork").tmpl(curworkdata).appendTo(tb_workrel);                
                upworkid = "";
            } else {
                //加载二级列表             
                $("#ul_catalogwork").children().each(function () {
                    var liid = $(this).attr("id").replace("li_catalogwork_", "");
                    var wwli = $(this).find("[name='tb_SecondList']");
                    if (json.result.errNum.toString() == "0") {
                        $.each(json.result.retData, function (i, data) {
                            if (data.WorkId == liid) {
                                $("#tr_catalogwork").tmpl(data).appendTo(wwli);
                            }
                        });
                    }                    
                    if (wwli.children().length == 0) {
                        wwli.append("<tr><td colspan='100' text-align='center'>" +(user_pagetype == "stu" ? "您还未提交作业": "暂无提交作业的学生") + "</td></tr>");
                    }
                });
                //作业折叠
                $('#ul_catalogwork li').find('.closeshow').click(function () {
                    var thisparent = $(this).parents('.test_lists_right');
                    thisparent.next().stop().slideToggle().end().parent().siblings().find('.homework_none').slideUp().end().find(".closeshow").text("+");
                    var t = $(this).text();
                    $(this).text((t == "+" ? "-" : "+"));
                });
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            var wwli = $(this).find("[name='tb_SecondList']");
            wwli.append("<tr><td colspan='100' text-align='center'>" + (user_pagetype == "stu" ? "您还未提交作业" : "暂无提交作业的学生") + "</td></tr>");
        }
    });
}

//绑定作业
function GetWorkDataPage(startIndex, pageSize) {
    if (isPower == 0) {
        return;
    }
    //初始化序号 
    pageNum = (startIndex - 1) * pageSize + 1;
    $.ajax({
        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/WorkHandler.ashx",
            Func: "GetWorkDataPage",
            CourseID: UrlDate.itemid,
            //ChapterID: $("#ChapterID").val(),
            //PointID: work_knowedgeid,
            WorkId: upworkid,
            Name: $("#txt_workname").val().trim(),
            ChapterName: $("#txt_chaptername").val().trim(),
            PageIndex: startIndex,
            pageSize: pageSize,
            StuIDCard: $("#HStuIDCard").val(),
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (json) {
            upworkid = "";
            if (json.result.errNum.toString() == "0") {
                document.getElementById("ul_tabwork").innerHTML = "";
                $("#li_tabwork").tmpl(json.result.retData.PagedData).appendTo("#ul_tabwork");
                $("#pageBar_work").show();
                //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                makePageBar(GetWorkDataPage, document.getElementById("pageBar_work"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                hoverShowDelete("#ul_tabwork");
                UploadFile(".uploadify_work", "uploadify_", "li_tabwork_");
                GetSubmitWorkData();
            }
            else { $("#ul_tabwork").html("<li style=\"border:none;\">暂无作业！</li>"); $("#pageBar_work").hide(); }
        },
        error: function (errMsg) {
            $("#ul_tabwork").html(errMsg);
        }
    });
}
var studyTheCourseStu = [], studyTheCourseStu_Count = 0, comwork_stu = [];
//绑定作业下提交的数据
function GetSubmitWorkData() {
    $.ajax({
        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/WorkHandler.ashx",
            Func: "GetWorkCorrectRelDataPage",
            CourseID: UrlDate.itemid,
            //ChapterID: $("#ChapterID").val(),
            WorkId: upworkid,
            ispage: false,
            StuIDCard: $("#HStuIDCard").val(),
            ClassID: $("#Hid_ClassID").val()
        },
        success: function (json) {
            if (upworkid != "") {
                var tb_workrel = "#tb_workrel_" + upworkid;
                $(tb_workrel).html("");
                var curworkdata = json.result.retData;
                $("#tr_work").tmpl(curworkdata).appendTo(tb_workrel);
                SetWorkRelCount(upworkid);
            } else {
                //加载二级列表             
                $("#ul_tabwork").children().each(function () {
                    var liid = $(this).attr("id").replace("li_tabwork_", "");
                    var wwli = $(this).find("[name='tb_SecondList']");
                    if (json.result.errNum.toString() == "0") {
                        $.each(json.result.retData, function (i, data) {
                            if (data.WorkId == liid) {
                                $("#tr_work").tmpl(data).appendTo(wwli);
                            }
                        });
                    }                    
                    $("#lbl_nocommit_" + liid).html(studyTheCourseStu_Count - parseInt($("#lbl_commit_" + liid).html()));
                    if (wwli.children().length == 0) {
                        wwli.append("<tr><td colspan='100' text-align='center'>" + (user_pagetype == "stu" ? "您还未提交作业" : "暂无提交作业的学生") + "</td></tr>");
                    }
                });
                //作业折叠
                $('.homework_lists li').find('.closeshow').click(function () {
                    var thisparent = $(this).parents('.homework_mes');
                    thisparent.next().stop().slideToggle().end().parent().siblings().find('.homework_none').slideUp().end().find(".closeshow").text("+");
                    var t = $(this).text();
                    $(this).text((t == "+" ? "-" : "+"));
                });
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            var wwli = $(this).find("[name='tb_SecondList']");
            wwli.append("<tr><td colspan='100' text-align='center'>" + (user_pagetype == "stu" ? "您还未提交作业" : "暂无提交作业的学生") +"</td></tr>");
        }
    });
}
//设置提交/未提交学生人数
function SetWorkRelCount(upworkid) {
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: { PageName: "/OnlineLearning/WorkHandler.ashx", Func: "GetWorkDataPage", WorkId: upworkid, ispage: false },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                var workRelCount = json.result.retData[0].WorkRelCount;
                $("#lbl_commit_" + upworkid).html(workRelCount);
                $("#lbl_nocommit_" + upworkid).html(studyTheCourseStu_Count - workRelCount);
            }
            else {
                $("#lbl_commit_" + upworkid).html(0);
                $("#lbl_nocommit_" + upworkid).html(studyTheCourseStu_Count);
            }
        },
        error: function (errMsg) {
            $("#lbl_commit_" + upworkid).html(0);
            $("#lbl_nocommit_" + upworkid).html(studyTheCourseStu_Count);
        }
    });
    upworkid = "";
}
//上传文件
function UploadFile(uploadifycss, prefix_id, li_work) {
    $(uploadifycss + "[name='uploadify']").each(function () {
        var workid = this.id.replace(prefix_id, "");
        try {
            $('#' + this.id).uploadify('destroy');
        } catch (e) {
        }
        $(this).uploadify({
            'auto': true,                      //是否自动上传
            'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
            'uploader': '/CourseManage/Uploade.ashx',
            'formData': { Func: "UplodeCourse_Work" }, //参数
            //'fileTypeDesc': '',
            //'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
            'buttonText': '<i class="icon icon-upload-alt" style="color:#fff;"></i>提交作业',//按钮文字
            // 'cancelimg': 'uploadify/uploadify-cancel.png',
            'width': 80,
            'height': 20,
            //最大文件数量'uploadLimit':
            'multi': false,//单选            
            'fileSizeLimit': '20MB',//最大文档限制
            'queueSizeLimit': 1,  //队列限制
            'removeCompleted': true, //上传完成自动清空
            'removeTimeout': 0, //清空时间间隔
            //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
            'onInit': function () {
                $("#" + prefix_id + workid + "-queue").hide();//载入时触发，将flash设置到最小
            },
            //'onUploadStart': function (file) {},
            'onUploadSuccess': function (file, data, response) {
                var json = $.parseJSON(data);
                SaveWorkCorrectRel(json.result.retData, workid, li_work);
            }
        });
    });
}
//上传作业
function SaveWorkCorrectRel(workurl, workid, li_work) {
    var $liobj = $("#" + li_work + workid);
    var workrelid = $liobj.attr("workrelid");
    var iscorrect = $liobj.attr("iscorrect");
    if (iscorrect.toString() == "1") {
        layer.msg("作业已被批改,不能更改作业了！");
        return;
    }
    var opertype=workrelid.toString() == "0"?"add":"edit";
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/WorkHandler.ashx",
            Func: workrelid.toString() == "0" ? "AddWorkCorrectRel" : "EditWorkCorrectRel",
            WorkId: workid,
            ItemId: workrelid,
            Attachment: workurl,
            UserIdCard: $("#HUserIdCard").val(),
            ClassID: $("#Hid_ClassID").val()
        },
        success: function (json) {
            var result = json.result;
            if (result.errNum.toString() == "0") {
                $liobj.attr("workrelid", result.retData);
                layer.msg('提交作业成功!');
                if (li_work == "li_tabwork_") {
                    upworkid = workid;
                    GetSubmitWorkData();
                }
                if (opertype == "add") {
                    addSysNotice("待批改作业", $("#HUserName").val() + "提交了作业，请您批改!", "0", $("#HUserIdCard").val(), Teacher_IDCard, "", "/CourseManage/CourseDetail.aspx?itemid=" + UrlDate.itemid + "&nav_index=4&relname=&flag=1&tabconid=" + upworkid, $("#HUserName").val(), Teacher_Name, 0);
                }
            } else {
                layer.msg(result.errMsg);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.msg("操作失败！");
        }
    });
}
//下载作业
function DownLoad(filepath) {
    $.ajax({
        url: "/OnlineLearning/DownLoadHandler.ashx",
        type: "post",
        async: false,
        dataType: "text",
        data: {
            filepath: filepath,
            UserIdCard: $("#HUserIdCard").val()
        },
        success: function (result) {
            if (result == "-1") {
                layer.msg('文件不存在!');
                return;
            }
            location.href = "/OnlineLearning/DownLoadHandler.ashx?filepath=" + filepath + "&UserIdCard=" + $("#HUserIdCard").val() + "&time=" + new Date();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.msg('文件不存在!');
        }
    });
}
//作业批改
function CorrectWorkClick(workid, workrelid) {
    upworkid = workid;
    OpenIFrameWindow('作业批改', '/OnlineLearning/WorkCorrectEdit.aspx?itemid=' + workrelid+"&flag=0", '580px', '360px');
}
function LookCorrectWork(workid, workrelid) {
    OpenIFrameWindow('详情批语', '/OnlineLearning/WorkCorrectEdit.aspx?itemid=' + workrelid+"&flag=1", '580px', '360px');
}
//删除作业
function DeleteWork(delid, ispage) {
    ispage = arguments[1] || "false";
    layer.msg("确定要删除该作业?", {
        time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: {
                           PageName: "/OnlineLearning/WorkHandler.ashx",
                           Func: "DeleteWork",
                           DelId: delid,
                           UserIdCard: $("#HUserIdCard").val()
                       },
                       success: function (json) {
                           if (json.result.errNum.toString() == "0") {
                               layer.msg("删除成功");
                               if (ispage == "false") {
                                   GetWorkData();
                               } else {
                                   GetWorkDataPage(1, 5);
                               }
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
var work_knowedgeid = "";
//绑定工作选项卡下的知识点
function BindWorkKnowledge() {
    if (isPower == 0) {
        return;
    }
    $("#div_workknowedge").html("");
    $.ajax({
        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "Chapator", "CourseID": UrlDate.itemid, Type: 4 },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                var curindex = 0;
                $(json.result.retData).each(function () {
                    var aclass = "";
                    if (curindex == 0 && work_knowedgeid == "") {
                        work_knowedgeid = this.ID;
                    }
                    if (work_knowedgeid == this.ID) {
                        aclass = "class='on'";
                    }
                    var a = "<a href=\"javascript:;\" " + aclass + " knowid='" + this.ID + "'>" + this.Name + "</a>";
                    $("#div_workknowedge").append(a);
                    curindex++;
                });
                GetWorkDataPage(1, 5);
                $("#div_workknowedge a").on("click", function () {
                    work_knowedgeid = $(this).attr("knowid");
                    $(this).addClass("on").siblings().removeClass("on");
                    GetWorkDataPage(1, 5);
                });
            }
            else {
                work_knowedgeid = "";
                $("#div_workknowedge").html("<a href=\"javascript:;\">暂无知识点！</a>");
                $("#ul_tabwork").html("<li style=\"border:none;\">暂无作业！</li>");
            }
        },
        error: function (errMsg) {
            layer.msg(errMsg);
        }
    });
}

function LookWorkStatistics(workid, workname) {
    window.open("/OnlineLearning/Course_WorkStatistics.aspx?workid=" + workid + "&coursetype=" + $(".course_type").attr("typevalue") + "&workname=" + encodeURIComponent(workname) + "&courseid=" + UrlDate.itemid);
}

function GetStuWorkCompleteInfo(workid) {
    $('#ul_stuContent').html('');
    $('.learned_title').html("未完成作业的学生");
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/WorkHandler.ashx",
            Func: "GetStuWorkCompleteInfo",
            CourseID: UrlDate.itemid,
            WorkId: workid,
            CourseType: $(".course_type").attr("typevalue")
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                var gradeArray = [], classArray = [];
                $(json.result.retData).each(function () {
                    if (gradeArray.indexOf(this.GradeID) == -1) {
                        gradeArray.push(this.GradeID);
                        if (gradeArray.length == 1) {
                            $("#ul_stuContent").append("<li><span>" + this.GradeName + "<i class='icon  icon-angle-down'></i></span><ul style='display: block;' id=\"ul_workgrade_" + this.GradeID + "\"></ul></li>");
                        } else {
                            $("#ul_stuContent").append("<li><span>" + this.GradeName + "<i class='icon  icon-angle-up'></i></span><ul id=\"ul_workgrade_" + this.GradeID + "\"></ul></li>");
                        }
                    }
                    if (classArray.indexOf(this.ClassID) == -1) {
                        classArray.push(this.ClassID);
                        if (classArray.length == 1) {
                            $("#ul_workgrade_" + this.GradeID).append("<li><span class='active'>" + this.ClassName + "<i class='icon  icon-angle-down'></i></span><ul id=\"ul_workclass_" + this.ClassID + "\" class='learned_students_lists clearfix' style='display: block;'></ul></li>");
                        } else {
                            $("#ul_workgrade_" + this.GradeID).append("<li><span>" + this.ClassName + "<i class='icon  icon-angle-up'></i></span><ul id=\"ul_workclass_" + this.ClassID + "\" class='learned_students_lists clearfix'></ul></li>");
                        }
                    }
                    $("#ul_workclass_" + this.ClassID).append("<li><div class='learned_students_img'><img src=\"" + this.PhotoURL + "\" alt='' onerror=\"javascript:this.src='/images/discuss_img_01.jpg'\"/></div><p class='learned_students_name'>" + this.Name + "</p></li>");
                });
                GradeOrClassExpand("#ul_stuContent");
            }
            else {
                $('#ul_stuContent').html("<li><span>无未完成作业的学生!</span></li>");
            }
            layer.open({
                type: 1,
                shade: false,
                title: false, //不显示标题
                area:['532px','auto'],
                content: $('#div_stuContent'), //捕获的元素
                cancel: function (index) {
                    layer.close(index);
                }
            });
        },
        error: function (errMsg) {
            layer.msg(errMsg);
        }
    });
}

function GradeOrClassExpand(obj) {
    obj = arguments[0] || ".class_select";
    //年级班级筛选
    $(obj).find('li:has(ul)').children('span').click(function () {
        $('.class_select').find('li:has(ul)').children('span').removeClass('active');
        $(this).addClass('active');
        var $icon = $(this).children('.icon');
        var $next = $(this).next('ul');
        if ($next.is(':hidden')) {
            $next.stop().slideDown();
            $icon.addClass('icon-angle-down').removeClass('icon-angle-up');
            if ($(this).parent('li').siblings('li').children('ul').is(':visible')) {
                $(this).parent("li").siblings("li").find("ul").slideUp();
            }
        } else {
            $next.slideUp();
            $icon.addClass('icon-angle-up').removeClass('icon-angle-down');
        }
    });
}
/**********************************************作业操作结束*****************************************************************/
function CutFileName(path, len) {
    len = arguments[1] || 30;
    filename = path.substr(path.lastIndexOf('/') + 1);
    filename = filename.length > len ? filename.substr(0, len - 2) + "..." : filename;
    return filename;
}
function hoverShowDelete(obj) {
    $(obj+' li').hover(function () {
        $(this).find('.caozuo_none').show().css('display','inline-block');
    }, function () {
        $(this).find('.caozuo_none').hide();
    })
}
//加入收藏
function AddToFavorites(courseid, coursename) {
    var favhref=window.location.href;
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "PortalManage/AdminManager.ashx",
            func: "AddFavorites",
            IDCard: $("#HUserIdCard").val(),
            href: favhref,
            Name: coursename + "——课程详情页",
            Type: 1,
            RelationID:courseid
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                layer.msg("收藏成功！");
                ReloadLessonDetail();
            } else {
                layer.msg(json.result.errMsg);
            }
        },
        error: function (errMsg) {
            layer.msg('收藏失败！');
        }
    });
}

//移除收藏
function DelFavorites(delid) {  
    layer.msg("确定要移除收藏?", {
        time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: {
                           PageName: "/PortalManage/AdminManager.ashx",
                           Func: "DelFavorites",
                           ID: delid
                       },
                       success: function (json) {
                           if (json.result.errNum.toString() == "0") {
                               layer.msg("移除收藏成功");
                               ReloadLessonDetail();
                           }
                           else { layer.msg('移除收藏失败！'); }
                       },
                       error: function (errMsg) {
                           layer.msg('移除收藏失败！');
                       }
                   });
               }
    });
}
function ReloadLessonDetail() {
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "/OnlineLearning/MyLessonsHandler.ashx",
            Func: "GetMyLessonsDataPage",
            ispage: false,
            CourseID: UrlDate.itemid,
            StuNo: $("#HUserIdCard").val(),
            ClassID: $("#Hid_ClassID").val(),
            OperSymbol: ">"
        },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $("#ul_mylessons").html('');
                $("#li_mylessons").tmpl(json.result.retData).appendTo("#ul_mylessons");
                Star();
            }
        }
    });
}
//加入浏览器收藏夹
//function AddFavorite(title, url) {
//    url = encodeURI(url);
//    try {
//        window.external.addFavorite(url, title);
//    }
//    catch (e) {
//        try {
//            window.sidebar.addPanel(title, url, "");
//        }
//        catch (e) {
//            try {
//                window.external.AddToFavoritesBar(url, title); //IE8                 
//            }
//            catch (e) {
//                alert("抱歉，您所使用的浏览器无法完成此操作。\n\n加入收藏失败，请进入新网站后使用Ctrl+D手动收藏");
//            }
//        }
//    }
//}
