<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="SMSWeb.CourseManage.CourseDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>我的课程</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>

    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>

    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/KindUeditor/kindeditor-min.js"></script>
    <script src="/Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="/Scripts/KindUeditor/lang/zh_CN.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../OnlineLearning/TopicAndComment.js"></script>
    <script src="../CourseMenu.js"></script>
    <style>
        .test_lists li .test_lists_right .seedeletion span.closeshow {
            width: 24px;
            height: 24px;
            display: inline-block;
            border-radius: 50%;
            border: 2px solid #A1C8E6;
            line-height: 24px;
            text-align: center;
            cursor: pointer;
            font-size: 16px;
            color: #0A73C0;
            margin-left: 10px;
        }

        .test_lists li .homework_none {
            width: 100%;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script src="../js/menu_top.js"></script>
    <script id="tr_Cource" type="text/x-jquery-tmpl">

        <li class="clearfix">
            <div class="mycourse_img fl">
                {{if ImageUrl==""}}
                <img src="../images/course_default.jpg" />
                {{else}}
									<img src="${ImageUrl}" alt="" />
                {{/if}}
            </div>
            <div class="fr mycourse_mes">
                <h1 class="mycourse_name">${Name}</h1>
                <h2 class="clearfix">
                    <div class="fl lecturer">
                        主讲老师：
										<span>${LecturerName} </span>
                    </div>
                    <div class="fl course_type" typevalue="${CourceType}">
                        课程类别：{{if CourceType==1}}
										<span>必修课</span>
                        {{else}}
										<span>选修课</span>
                        {{/if}}
                    </div>
                    <div class="fl class_venue">
                        上课场地：
										 <span>${StudyPlace}</span>
                    </div>
                    <div class="fl people_number">
                        选课人数上限：
										 <span>${StuMaxCount}</span>
                    </div>
                </h2>
                <div class="course_desc">
                    ${CourseIntro}               
                </div>
                <div class="course_price btnprice_colorfree">
                    ￥${Price}
                </div>
                <%--<a href="#" class="course_btn btnprice_bgenter">立即报名
                </a>--%>
            </div>
        </li>

    </script>
    <script type="text/x-jquery-tmpl" id="li_Evalue">

        <li class="noteitem">
            <div class="notedit">
                <a class="img">
                    <img src="${PhotoURL}">
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <div class="assess note_user fl" id="${Evalue}" style="height: 24px;left:0;top:26px; ">
                            <span id="1"></span>
                            <span id="2"></span>
                            <span id="3"></span>
                            <span id="4"></span>
                            <span id="5"></span>
                        </div>
                        <%--<span class="note_user fl">${Evalue}

                        </span>--%>

                    </div>
                    <div class="notecnt" style="margin-top:25px;">
                        ${EvalueCountent}
                    </div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">
                            ${DateTimeConvert(CreateTime,'yyyy-MM-dd HH:mm')}
                        </div>

                    </div>

                </div>
            </div>
        </li>

    </script>
    <%--目录选项卡下的讨论列表的绑定--%>
    <script id="li_discuss" type="text/x-jquery-tmpl">
        <li class="clearfix" id="li_discuss_${Id}">
            <%--<div class="discuss_img fl">
                <img src="/images/test_img.png" />
            </div>--%>
            <div class="discuss_description fl">
                <h2>
                    <a href="javascript:;">${Name}</a>
                    <%--<span class="test_type">老师参与</span>--%>
                    <span class="discuss_date fr">${CreateTime_Format}</span>
                </h2>
                <h1 class="clearfix">
                    <span class="movie fl">{{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                    </span>                    
                </h1>
                <h1 class="clearfix">
                     <div class="clearfix fl caozuo_none">
                         {{if IsCreate==1}}
                        <div class="fl" style="color: #0b70bc" onclick="DeleteTopic(${Id},'false',0,'ul_discuss');">
                            <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>删除                                                                
                        </div>
                        {{/if}}                                               
                    </div>
                    <div class="discuss-wrap fr">
                        <div class="fl comment">
                            <i class="icon icon-comment-alt"></i>
                            (<span id="span_discussreplaycount${Id}">0</span>)
                        </div>
                        <%--<div class="fl heart">
                            <i class="icon  icon-heart"></i>
                            <span>(1)</span>
                        </div>--%>
                        <div class="fl thumbs" onclick="ClickGood('${Id}','span_discussgoodcount${Id}');">
                            <i id="span_discussgoodcount${Id}_i" class="icon icon-thumbs-up" {{if GoodCount!=0}}style="color: #21A557;"{{/if}}></i>
                            <span>(<span id="span_discussgoodcount${Id}" isgoodclick="${IsGoodClick}">${GoodCount}</span>)</span>
                        </div>
                    </div>
                </h1>
            </div>
            <div style="clear: both;"></div>
            <div class="comment_wrap clearfix none">
                <ul class="commenta" id="comment_discuss${Id}"></ul>
                <div class="add_commentwrap">
                    <div class="add_comment">
                        <textarea id="commarea_discus${Id}" name="" rows="" cols="" placeholder="请添加你的评论..."></textarea>
                    </div>
                </div>
                <div class="editopt clearfix">
                    <a href="javascript:;" class="fr" onclick="javascript:AddTopic_Comment('${Id}','commarea_discus${Id}','ul_discuss','li_discuss',0,'comment_discuss','li_discusscomment','span_discussreplaycount');">评论</a>
                </div>
            </div>
        </li>
    </script>
    <script id="li_discusscomment" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="imga fl">
                <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'" />
            </div>
            <div class="comment_contentwrap">
                <div class="comment_content">
                    <div class="comment_opt">
                        <span class="comment_name">${CreateName}</span>
                        <span class="comment_time">${CreateTime_Format}</span>
                        {{if IsCreate==1}}
                        <!--删除-->
                        <span class="del fr" onclick="DeleteTopic_Comment('${Id}','${TopicId}','ul_discuss',0,'comment_discuss','li_discusscomment','span_discussreplaycount');"><i class="icon  icon-trash"></i></span>
                        {{/if}} 
                    </div>
                    <div class="comment_desc">{{html Contents}}</div>
                </div>

            </div>
        </li>
    </script>

    <%--讨论列表的绑定--%>
    <script id="li_topic" type="text/x-jquery-tmpl">
        <li class="noteitem" id="li_topic_${Id}">
            <div class="notedit">
                <a href="javascript:;" class="img">
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'" />
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">{{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                        </span>
                    </div>
                    <div class="notecnt">${Name}</div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">${CreateTime_Format}</div>
                    </div>
                    <div class="edit_delete mt5 clearfix">
                        <div class="clearfix fl caozuo_none">
                            {{if IsCreate==1}}
                            <div class="fl" style="color: #0b70bc" onclick="DeleteTopic(${Id},'true');">
                                <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>删除                                                                
                            </div>
                            {{/if}}                            
                        </div>
                        <div class="note_oper fr clearfix">
                            <div class="fl comment0">
                                <i class="icon icon-comment-alt"></i>
                                <span>(<span id="span_replaycount${Id}">0</span>)</span>
                            </div>
                            <%--<div class="fl heart">
                                <i class="icon  icon-heart"></i>
                                <span>(1)</span>
                            </div>--%>
                            <div class="fl thumbs" onclick="ClickGood('${Id}','span_goodcount${Id}');">
                                <i id="span_goodcount${Id}_i" class="icon icon-thumbs-up" {{if GoodCount!=0}}style="color: #21A557;"{{/if}}></i>
                                <span>(<span id="span_goodcount${Id}" isgoodclick="${IsGoodClick}">${GoodCount}</span>)</span>
                            </div>
                        </div>
                    </div>
                    <div class="comment_wrap none">
                        <ul class="commenta" id='comment_tp${Id}'></ul>
                        <div class="add_commentwrap">
                            <div class="add_comment">
                                <textarea id="commarea_${Id}" name="" rows="" cols="" placeholder="请添加你的评论..."></textarea>
                            </div>
                        </div>
                        <div class="editopt clearfix">
                            <a href="javascript:;" class="fr" onclick="javascript:AddTopic_Comment('${Id}','commarea_${Id}');">评论</a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </script>
    <script id="li_comment" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="imga fl">
                <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'" />
            </div>
            <div class="comment_contentwrap">
                <div class="comment_content">
                    <div class="comment_opt">
                        <span class="comment_name">${CreateName}</span>
                        <span class="comment_time">${CreateTime_Format}</span>
                        {{if IsCreate==1}}
                        <!--删除-->
                        <span class="del fr" onclick="DeleteTopic_Comment('${Id}','${TopicId}');"><i class="icon  icon-trash"></i></span>
                        {{/if}}  
                    </div>
                    <div class="comment_desc">{{html Contents}}</div>
                </div>
            </div>
        </li>
    </script>

    <%--笔记列表的绑定--%>
    <script id="li_note" type="text/x-jquery-tmpl">
        <li class="noteitem" id="li_note_${Id}">
            <div class="notedit">
                <a href="javascript:;" class="img">
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'" />
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">{{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                        </span>
                    </div>
                    <div class="notecnt">${Name}</div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">${CreateTime_Format}</div>
                        
                    </div>
                    <div class="edit_delete mt5 clearfix">
                        <div class="clearfix fl caozuo_none">
                            {{if IsCreate==1}}
                            <div class="fl" style="color: #0b70bc" onclick="DeleteTopic(${Id},'true',1,'ul_note');">
                                <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>删除                                                                
                            </div>
                            {{/if}}                             
                        </div>
                        <div class="note_oper fr clearfix">
                            <div class="fl share" onclick="ChangeShareStatus('${Id}','img_share_${Id}','${IsCreate}');">
                                <i class="icon">
                                    <img id="img_share_${Id}" isshare="${IsShare}" src="${IsShare==0?'/images/share.png':'/images/share2.png'}" alt="" style="width: 100%" /></i>
                            </div>
                            <div class="fl comment1">
                                <i class="icon icon-comment-alt"></i>
                                <span>(<span id="span_notereplaycount${Id}">0</span>)</span>
                            </div>
                            <%--<div class="fl heart">
                                <i class="icon  icon-heart"></i>
                                <span>(1)</span>
                            </div>--%>
                            <div class="fl thumbs" onclick="ClickGood('${Id}','span_notegoodcount${Id}');">
                                <i id="span_notegoodcount${Id}_i" class="icon icon-thumbs-up" {{if GoodCount!=0}}style="color: #21A557;"{{/if}}></i>
                                <span>(<span id="span_notegoodcount${Id}" isgoodclick="${IsGoodClick}">${GoodCount}</span>)</span>
                            </div>
                        </div>
                    </div>
                    <!--回复信息隐藏-->
                    <div class="comment_wrap none">
                        <ul class="commenta" id='comment_note${Id}'></ul>
                        <div class="add_commentwrap">
                            <div class="add_comment">
                                <textarea id="commarea_note${Id}" name="" rows="" cols="" placeholder="请添加你的评论..."></textarea>
                            </div>
                        </div>
                        <div class="editopt clearfix">
                            <a href="javascript:;" class="fr" onclick="javascript:AddTopic_Comment('${Id}','commarea_note${Id}','ul_note','li_note',1,'comment_note','li_notecomment','span_notereplaycount');">评论</a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </script>
    <script id="li_notecomment" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="imga fl">
                <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'" />
            </div>
            <div class="comment_contentwrap">
                <div class="comment_content">
                    <div class="comment_opt">
                        <span class="comment_name">${CreateName}</span>
                        <span class="comment_time">${CreateTime_Format}</span>
                        {{if IsCreate==1}}
                        <!--删除-->
                        <span class="del fr" onclick="DeleteTopic_Comment('${Id}','${TopicId}','ul_note',1,'comment_note','li_notecomment','span_notereplaycount');"><i class="icon  icon-trash"></i></span>
                        {{/if}}  
                    </div>
                    <div class="comment_desc">{{html Contents}}</div>
                </div>

            </div>
        </li>
    </script>
    <%--任务列表的绑定--%>
    <script id="li_task" type="text/x-jquery-tmpl">
        <li class="noteitem">
            <div class="notedit">
                <a href="javascript:;" class="img">
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'" />
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">{{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                        </span>
                    </div>
                    <div class="notecnt" style="cursor: pointer;" onclick="LookTaskStatistics(${ID},'${Name}');">${Name}<span class="test_type ml10" style="padding: 0px 4px;">${TaskType}</span></div>
                    <div class="notecnt" style="cursor: pointer;" onclick="JumpToTask(${RelationID},'${RelName}','${TaskType}','${ChapterID}','${ComCount}','${RelOtherField}','self','tea');">
                        任务：${RelName}                   
                    ( 权重：${Weight} &emsp; 学生范围：${ClassStrName})                     
                    </div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">起止时间：${DateTimeConvert(StartTime,"yyyy-MM-dd HH:mm")}~${DateTimeConvert(EndTime,"yyyy-MM-dd HH:mm")}</div>
                        <div class="note_oper fr clearfix">
                            <%--<div class="fl">
                            <i class="icon icon-thumbs-up"></i>
                            <span>(1)</span>
                        </div>
                        <div class="fl comment3">
                            <i class="icon icon-comment-alt"></i>
                            <span>(1)</span>
                        </div>
                        <div class="fl">
                            <i class="icon  icon-heart"></i>
                            <span>(1)</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon-share"></i>
                            <span>(1)</span>
                        </div>--%>
                        </div>
                    </div>
                     <div class="edit_delete mt5 clearfix">
                        <div class="clearfix fl caozuo_none">
                            {{if IsCreate==1}}
                            <div class="fl" style="color: #0b70bc" onclick="DeleteTask(${ID},'true');">
                               <i class="icon icon-trash" style="color:#0b70bc;display:inline-block;"></i>删除                                                             
                            </div>
                            {{/if}} 
                        </div>
                    </div>
                    <div class="comment_wrap none">
                        <%--<ul class="commenta">
                        <li class="clearfix">
                            <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/>
                            <div class="comment_contentwrap">
                                <div class="comment_content">
                                    <div class="comment_opt">
                                        <span class="comment_name">你好</span>
                                        <span class="comment_time">4月4号
                                        </span>
                                    </div>
                                    <div class="comment_desc">
                                        kjhj
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="clearfix">
                            <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/>
                            <div class="comment_contentwrap">
                                <div class="comment_content">
                                    <div class="comment_opt">
                                        <span class="comment_name">你好</span>
                                        <span class="comment_time">4月4号
                                        </span>
                                    </div>
                                    <div class="comment_desc">
                                        kjhj
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>--%>
                        <div class="add_commentwrap">
                            <div class="add_comment">
                                <textarea name="" rows="" cols="">请添加你的评论...</textarea>
                            </div>
                        </div>
                        <div class="editopt clearfix">
                            <a href="javascript:;" class="fr">评论
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </script>
    <%--目录选项卡下的作业列表的绑定--%>
    <script id="li_catalogwork" type="text/x-jquery-tmpl">
        <li id="li_catalogwork_${Id}" class="clearfix">
            <div class="test_description fl">
                <h2><a href="javascript:;">${Name}</a></h2>
                <p>
                    <span>发布人：${CreateName}</span>
                    <span>发布时间：${DateTimeConvert(CreateTime,"yyyy-MM-dd HH:mm")}</span>
                </p>
               <div class="edit_delete mt5 clearfix">
                    <div class="clearfix fl caozuo_none">
                        {{if IsCreate==1}}
                           {{if WorkRelCount==0}}
                            <div class="fl mr10" style="color: #0b70bc;" onclick="EditWork(${Id},'${ChapterID}','${PointID}');">                                
                                <i class="icon icon-edit" style="color: #0b70bc; display: inline-block;"></i>编辑                                 
                            </div>
                            {{/if}}
                            <div class="fl" style="color: #0b70bc" onclick="DeleteWork(${Id});">
                                <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>删除                                                             
                            </div>
                        {{/if}} 
                    </div>
                </div>
            </div>
            <div class="test_lists_right fr clearfix">
                <div class="dates_a  pr" style="width: 220px">
                    <div class="seedeletion" style="margin-top: 0;">
                        <a href="javascript:;" class="homework fl" onclick="DownLoad('${Attachment}');"><i class="icon icon-download-alt" style="color: #fff;"></i>下载布置的作业</a>
                        <span class="closeshow fl">+</span>
                    </div>
                    <div class="data ">
                        提交截止时间：{{if IsCanCorrect==0}}<label style="color: red;">${EndTime_Format}</label>
                        {{else}}${EndTime_Format}{{/if}}
                    </div>
                </div>
            </div>
           
            <div class="homework_none none mt10 clearfix">
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>姓名</th>
                                <th>年级</th>
                                <th>班级</th>
                                <th>提交时间</th>
                                <th>作业</th>
                                <th>是否批改</th>
                                <th>分数</th>
                                <th>成绩等级</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody name="tb_SecondList" id="tb_catelogworkrel_${Id}"></tbody>
                    </table>
                </div>
            </div>
        </li>
    </script>
    <%--目录选项卡下的作业列表二级信息的绑定--%>
    <script id="tr_catalogwork" type="text/x-jquery-tmpl">
        <tr>
            <td>${CreateName}</td>
            <td>${GradeName}</td>
            <td>${ClassName}</td>
            <td>${DateTimeConvert(EidtTime,"yyyy-MM-dd HH:mm")}</td>
            <td><a onclick="DownLoad('${Attachment}');">${CutFileName(Attachment,20)}</a></td>
            <td>{{if CorrectUID==''}}<span style="color: red;">否</span>{{else}}<span>是</span>{{/if}}</td>
            <td>${Score}</td>
            <td>${StoreLevel}</td>
            <td>
                <i class="icon icon-download-alt" onclick="DownLoad('${Attachment}');" style="color: #0b70bc;"></i>
                <i class="icon" onclick="CorrectWorkClick('${WorkId}',${Id});">
                    <img src="/images/shenpi.png" alt="" /></i>
            </td>
        </tr>
    </script>

    <%--作业列表的绑定--%>
    <script id="li_tabwork" type="text/x-jquery-tmpl">
        <li id="li_tabwork_${Id}">
            <div class="homework_mes clearfix">
                <div class="homework_mes_left fl">
                    <h2><a href="javascript:;" style="cursor: pointer;" onclick="LookWorkStatistics('${Id}','${Name}');">${Name}</a><span class="submit "><label id="lbl_commit_${Id}">${WorkRelCount}</label>人已提交</span><span class="nosubmit " style="cursor: pointer;" onclick="GetStuWorkCompleteInfo('${Id}');"><label id="lbl_nocommit_${Id}">0</label>人未提交</span>
                        {{if IsCreate==1}}
                        <div class="clearfix  dislb caozuo_none pr" style="font-size: 14px;">
                            {{if WorkRelCount==0}}
                            <div class="dislb mr10" style="color: #0b70bc" onclick="EditWork(${Id},'${ChapterID}','${PointID}');">                                
                                <i class="icon icon-edit" style="color: #0b70bc; display: inline-block;"></i>编辑                                 
                            </div>
                            {{/if}}
                            <div class="dislb" style="color: #0b70bc;" onclick="DeleteWork(${Id},'true');">
                                <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>
                                删除
                            </div>
                        </div>
                        {{/if}}                            
                    </h2>
                    <p>
                        <span>发布人：${CreateName}</span>
                        <span>发布时间：${DateTimeConvert(CreateTime,"yyyy-MM-dd HH:mm")}</span>
                        <span>提交截止时间：{{if IsCanCorrect==0}}<label style="color: red;">${EndTime_Format}</label>
                            {{else}}${EndTime_Format}{{/if}} </span>
                    </p>
                    
                </div>
                <div class="homework_mes_right fr" style="text-align: right;">
                    <div class="homework_mes_a">
                        <a href="javascript:;" class="homework " onclick="DownLoad('${Attachment}');"><i class="icon icon-download-alt"></i>下载布置的作业</a>
                        <span class="closeshow">+</span>
                    </div>
                    <div class="data">
                        {{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName} > ${KnowLedgeName}
                    </div>
                </div>
            </div>
            <div class="homework_none none">
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>姓名</th>
                                <th>年级</th>
                                <th>班级</th>
                                <th>提交时间</th>
                                <th>作业</th>
                                <th>是否批改</th>
                                <th>分数</th>
                                <th>成绩等级</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody name="tb_SecondList" id="tb_workrel_${Id}"></tbody>
                    </table>
                </div>
                <!--分页-->
                <%--<div class="page">
                    <a href="javascript:;">1</a>
                    <a href="javascript:;">2</a>
                    <a href="javascript:;">3</a>
                    <a href="javascript:;">4</a>
                    <a href="javascript:;">5</a>
                    <a href="javascript:;" class="on">6</a>
                    <a href="javascript:;">7</a>
                    <a href="javascript:;">8</a>
                    <a href="javascript:;">9</a>
                    <a href="javascript:;">10</a>
                    <a href="javascript:;" class="next">下一页</a>
                    <a href="javascript:;" class="end">尾页</a>
                </div>--%>
            </div>
        </li>
    </script>
    <%--作业列表二级信息的绑定--%>
    <script id="tr_work" type="text/x-jquery-tmpl">
        <tr>
            <td>${CreateName}</td>
            <td>${GradeName}</td>
            <td>${ClassName}</td>
            <td>${DateTimeConvert(EidtTime,"yyyy-MM-dd HH:mm")}</td>
            <td><a onclick="DownLoad('${Attachment}');">${CutFileName(Attachment)}</a></td>
            <td>{{if CorrectUID==''}}<span style="color: red;">否</span>{{else}}<span>是</span>{{/if}}</td>
            <td>${Score}</td>
            <td>${StoreLevel}</td>
            <td>
                <i class="icon icon-download-alt" onclick="DownLoad('${Attachment}');" style="color: #0b70bc;"></i>
                <i class="icon" onclick="CorrectWorkClick('${WorkId}',${Id});">
                    <img src="/images/shenpi.png" alt="" /></i>
            </td>
        </tr>
    </script>
    <style type="text/css">
        .note_oper .heart .icon, .discuss-wrap .heart .icon {
            color: #D84A27;
        }

        .homeworkb {
            display: block;
            float: left;
            width: 84px;
            height: 24px;
            padding: 0px;
        }

            .homeworkb .uploadify {
                left: 2px;
                top: 2px;
            }

            .homeworkb .uploadify-button {
                border: none;
                color: #fff;
                font-weight: normal;
                background: #1775BD;
                font-size: 14px;
            }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <input type="hidden" id="ChapterID" value="" />
        <input type="hidden" id="HStuIDCard" value="" runat="server" />
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HClassID" runat="server" />
        <input type="hidden" id="Hid_ClassID" value="" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../HZ_Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/coursesystem.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                        <%--<li currentclass="active"><a href="CourseIndex.aspx">课程首页</a></li>
                        <li currentclass="active"><a href="CourceManage.aspx">课程管理</a></li>
                        <li class="active"><a href="MyCourceManage.aspx">我的课程</a></li>
                        <li currentclass="active"><a href="Course_SelManag.aspx">选课管理</a></li>--%>
                    </ul>
                </nav>
                <div class="search_account fr clearfix">
                    <ul class="account_area fl">
                        <li>
                            <a href="javascript:;" class="dropdown-toggle">
                                <i class="icon icon-envelope"></i>
                                <span class="badge">3</span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=PhotoURL %>" />
                                </div>
                                <h2><%=Name %></h2>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr ">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="myexam bordshadrad">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on">我的课程</a>
                    </div>

                </div>
                <!--面包屑-->
                <div class="crumbs">
                    <a id="Mycource">我的课程</a>
                    <span>></span>
                    <a href="#" id="CourceName"></a>
                </div>
                <div class="mycourse">
                    <ul class="mycourse_lists" id="tb_MyCource">
                    </ul>
                </div>
                <!---->
                <div class="coursedetail_nav">
                    <a href="javascript:;" class="on">目录</a>
                    <a href="javascript:;" onclick="GetDiscussDataPage(1, 5);">讨论</a>
                    <a href="javascript:;" onclick="GetNoteDataPage(1, 5);">笔记</a>
                    <a href="javascript:;" onclick="GetTaskDataPage(1, 5);">任务</a>
                    <a href="javascript:;" onclick="GetWorkDataPage(1,5);">作业</a>
                    <a href="javascript:;" onclick="GetEvalueDataPage(1,5);">评价</a>

                </div>
                <div class="shadow">
                </div>
            </div>
        </div>
        <div class="width coursedetail_wrap mb10 bordshadrad">
            <div class="coursedetail clearfix pr" style="display: block;">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <div class="coursedetail_items fl">
                    <div class="detail_items_title" style="cursor: pointer;" onclick="addLeftMenu(0,0,this,'menu_side')">
                        课程目录(+)
                    </div>
                    <ul class="item_sides" id="menu_side">
                    </ul>
                </div>

                <div class="coursedetail_right fr">
                    <%--<div class="stytem_select clearfix">
                        <div class="search_exam fl pr">
                            <input type="text" name="" id="" value="" placeholder="请输入课程名称" />
                            <i class="icon  icon-search"></i>
                        </div>
                    </div>
                    <%--<p class="course_title" style="display: none">设想上课睡觉睡觉</p>--%>
                    <div class="knowledge_points" id="div_knowcontent">
                        <h1 class="knowledge_title">知识点</h1>
                        <div class="points clearfix" id="KnowleagPoint">
                        </div>
                    </div>
                    <h1 class="course_detail clearfix">
                        <div class="fl on">
                            <i class="icon icon_course"></i>
                            <span>微课（<em id="CountVideo">0</em>）</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon_resource"></i>
                            <span>资源（<em id="CountResource">0</em>）</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon_discuss"></i>
                            <span>讨论（<em id="CountTopic">0</em>）</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon_test"></i>
                            <span>任务（<em id="CountTask">0</em>）</span>
                        </div>
                        <div class="fl">
                            <i class="icon">
                                <img src="../images/homework1.png" /></i>
                            <span>作业（<em id="CountWork">0</em>）</span>
                        </div>

                    </h1>
                    <div class="course_detail_listswrap">
                        <div>
                            <div class="stytem_select_right fr">
                                <a onclick="SelResource(1)" style="cursor: pointer;"><i class="icon icon-plus"></i>选择微课</a>
                                <a href="javascript:;" onclick="AddWeike(1)" style="cursor: pointer;"><i class="icon icon-plus"></i>上传微课</a>
                            </div>
                            <div class="clear">
                            </div>
                            <ul class="course_detail_lists clearfix" id="weike">
                            </ul>
                        </div>
                        <div class="none">
                            <div class="stytem_select_right fr">
                                <a onclick="SelResource(0)" style="cursor: pointer;"><i class="icon icon-plus"></i>选择资源</a>
                                <div onclick="$('#uploadify').click();" style="border-radius: 2px; background: #1472b9; top: 67px; width: 90px; height: 30px; text-align: center; right: 130px; color: rgb(255, 255, 255); font-size: 12px; display: block; position: absolute; z-index: 2; cursor: pointer;" class="un_reposity">

                                    <input name="uploadify" id="uploadify" style="display: none;" type="file" multiple="multiple">
                                </div>
                                <style>
                                    .un_reposity .uploadify-button {
                                        border: none;
                                        background: #1472b9;
                                        font-size: 14px;
                                        color: #fff;
                                        height: 30px;
                                        border-radius: 2px;
                                    }
                                </style>
                            </div>
                            <div class="clear"></div>
                            <ul class="repository_lists" id="Resource">
                            </ul>

                        </div>
                        <div class="none">
                            <ul class="discuss_lists" id="ul_discuss">
                            </ul>
                        </div>
                        <div class="none">
                            <div class="stytem_select_right fr">
                                <a href="javascript:void(0);" onclick="AddTask();" style="cursor: pointer;"><i class="icon icon-plus"></i>新增任务</a>
                            </div>
                            <div class="clear"></div>
                            <ul class="test_lists exam_lists testing" id="Task">
                            </ul>
                        </div>
                        <div class="none">
                            <div class="stytem_select_right fr">
                                <a href="javascript:void(0);" id="a_AddWork" onclick="AddWork();" style="cursor: pointer;"><i class="icon icon-plus"></i>发布作业</a>
                            </div>
                            <div class="clear"></div>
                            <ul class="test_lists exam_lists testing clearfix" id="ul_catalogwork"></ul>
                        </div>

                    </div>
                </div>
            </div>
            <div class="coursedetail clearfix pr none">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--讨论-->
                <div class="discuss_wrap">
                    <div class="note_title">
                        <span class="fl">讨论区</span><div class="search_exam fl ml10 pr">
                            <input type="text" name="txt_topicTitle" id="txt_topicTitle" value="" onblur="GetDiscussDataPage(1, 5);" placeholder="请输入讨论标题" />
                            <i class="icon  icon-search" style="top: 16px;"></i>
                        </div>
                    </div>
                    <%--<div class="filtercri_wrap">
                        <div class="filtercri">
                            <a href="javascript:;" class="on">全部笔记</a>
                            <a href="javascript:;">课程笔记</a>
                            <a href="javascript:;">课时1</a>
                            <a href="javascript:;">课时2</a>
                            <a href="javascript:;">课时3</a>
                            <a href="javascript:;">课时4</a>
                            <a href="javascript:;">课时5</a>
                            <a href="javascript:;">课时1</a>
                            <a href="javascript:;">课时2</a>
                            <a href="javascript:;">课时3</a>
                            <a href="javascript:;">课时4</a>
                            <a href="javascript:;">课时5</a>
                            <a href="javascript:;">课时1</a>
                            <a href="javascript:;">课时2</a>
                            <a href="javascript:;">课时3</a>
                            <a href="javascript:;">课时4</a>
                            <a href="javascript:;">课时5</a>
                            <a href="javascript:;">课时1</a>
                            <a href="javascript:;">课时2</a>
                            <a href="javascript:;">课时3</a>
                            <a href="javascript:;">课时4</a>
                            <a href="javascript:;">课时5</a>
                        </div>
                        <span class="more_periods">展开更多课时
                        </span>
                    </div>--%>
                    <div class="discuss_listswrap">
                        <ul id="ul_topic">
                            <li>暂无讨论！</li>
                        </ul>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="coursedetail clearfix pr none">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--笔记-->
                <div class="note_wrap">
                    <div class="note_title">
                        <span class="fl">笔记</span><div class="search_exam fl ml10 pr">
                            <input type="text" name="txt_noteTitle" id="txt_noteTitle" value="" onblur="GetNoteDataPage(1, 5);" placeholder="请输入笔记标题" />
                            <i class="icon  icon-search" style="top: 16px;"></i>
                        </div>
                    </div>
                    <div class="discuss_listswrap">
                        <ul id="ul_note">
                            <li>暂无笔记！</li>
                        </ul>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar_note"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="coursedetail clearfix pr none">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--任务-->
                <div class="work_wrap">
                    <div class="note_title">
                        <span class="fl">任务</span><div class="search_exam fl ml10 pr">
                            <input type="text" name="txt_taskTitle" id="txt_taskTitle" value="" onblur="GetTaskDataPage(1, 5);" placeholder="请输入任务标题" />
                            <i class="icon  icon-search" style="top: 16px;"></i>
                        </div>
                    </div>
                    <%--<div class="filtercri_wrap">

                        <span class="more_periods">展开更多课时
                        </span>
                    </div>--%>
                    <div class="discuss_listswrap">
                        <ul id="ul_task">
                            <li>暂无任务！</li>
                        </ul>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar_task"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="coursedetail clearfix pr coursedetaila">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--作业-->
                <div>
                    <div class="stytem_select clearfix">
                        <div class="search_exam fl pr">
                            <input type="text" name="txt_workname" id="txt_workname" value="" onblur="GetWorkDataPage(1,5);" placeholder="请输入作业标题" />
                            <i class="icon  icon-search"></i>
                            <input type="text" name="txt_chaptername" id="txt_chaptername" value="" onblur="GetWorkDataPage(1,5);" placeholder="请输入目录名称" />
                            <i class="icon  icon-search"></i>
                        </div>
                    </div>
                    <div class="knowledge_points none">
                        <h1 class="knowledge_title">知识点</h1>
                        <div class="points clearfix" id="div_workknowedge"><a href="javascript:;">暂无知识点！</a></div>
                    </div>
                    <h1 class="course_detail clearfix">
                        <div class="fl">
                            <i class="icon">
                                <img src="../images/homework.png" alt="" /></i>
                            <span style="color: #1775bd">作业</span>
                        </div>
                    </h1>
                    <ul class="homework_lists" id="ul_tabwork">
                        <li style="border: none;">暂无作业！</li>
                    </ul>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar_work"></span>
                    </div>
                </div>
            </div>
            <div class="coursedetail clearfix pr none">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--讨论-->
                <div class="discuss_wrap">
                    <div class="note_title">
                        <span class="fl">评论列表</span><div class="search_exam fl ml10 pr">
                            <%-- <input type="text" name="txt_topicTitle" id="txt_topicTitle" value="" onblur="GetDiscussDataPage(1, 5);" placeholder="请输入讨论标题" />
                            <i class="icon  icon-search" style="top: 16px;"></i>--%>
                        </div>
                    </div>

                    <div class="discuss_listswrap">
                        <ul id="ul_Evalue">
                            <li>暂无评价！</li>
                        </ul>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar_Evalue"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_stuContent" class="course_learned fr bordshadrad pr" style="display: none; width: 500px;">
            <p class="learned_title"></p>
            <div class="class_selectwrap">
                <ul class="class_select" id="ul_stuContent"></ul>
            </div>
        </div>
    </form>
    <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/system.js"></script>

    <script>
        var UrlDate = new GetUrlDate();
        var upworkid = UrlDate.tabconid || "";
        //choose($('.select'));
        //作业折叠
        $('.homework_lists li').find('.closeshow').click(function () {
            var thisparent = $(this).parents('.homework_mes');
            thisparent.next().stop().slideToggle().end().parent().siblings().find('.homework_none').slideUp().end().find(".closeshow").text("+");
            var t = $(this).text();
            $(this).text((t == "+" ? "-" : "+"));
        })
        $('#ul_catalogwork li').find('.closeshow').click(function () {
            var thisparent = $(this).parents('.test_lists_right ');
            thisparent.next().stop().slideToggle().end().parent().siblings().find('.homework_none').slideUp().end().find(".closeshow").text("+");
            var t = $(this).text();
            $(this).text((t == "+" ? "-" : "+"));
        })
        //讨论 笔记目录切换
        $('.coursedetail_nav a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            $('.coursedetail_wrap>div').eq(n).show().siblings().hide();
        })
        //微课 资源 tab切换
        $('.course_detail>div').click(function () {
            $(this).addClass('on').siblings().removeClass();
            var n = $(this).index();
            $('.course_detail_listswrap>div').eq(n).show().siblings().hide();
        })

        $(function () {
            if (UrlDate.PageName == "/CourseManage/CourseIndex.aspx") {
                $("#Mycource").html("课程首页");
            }
            else { $("#Mycource").html("我的课程"); }
            $("#Mycource").attr("href", UrlDate.PageName + "?ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName);            
            CourceMenu();
            getData(1, 10);
            BindWeikeResource();
            BindPutongResource();
            BindTopic();
            Chapator();
            BindExamPaper();
            //$("#menu_side").html(chapterDiv);
            MenuSide();
        })
        function MenuSide() {  //折叠菜单
            $("#div_knowcontent").hide();

            $('#menu_side').find('li:has(ul)').children('div').click(function () {
                ClearActiveClass();
                $(this).parent('li').addClass('active');//.siblings().removeClass('active');
                var $next = $(this).next('ul');
                $next.slideDown();
                if ($(this).parent('li').siblings('li').children('ul').is(':visible')) {
                    $(this).parent("li").siblings("li").find("ul").slideUp();
                }
                var CrentClass = $(this).attr("class");
                var id1 = "";
                var id2 = "";
                var id3 = "";
                var ChapterID = "";
                if (CrentClass == "item_chapter") {
                    id1 = $(this).attr("id").toString().substring(3);
                    ChapterID = id1;
                    knowStatus = "hide";
                }
                else if (CrentClass == "item_knot") {
                    id1 = $(this).parent().parent().prev("div").attr("id").toString().substring(3);
                    id2 = $(this).attr("id").toString().substring(3);
                    ChapterID = id1 + "|" + id2;
                    knowStatus = "hide";
                }
                else {
                    id1 = $(this).parent().parent().parent().parent().prev("div").attr("id").toString().substring(3);
                    id2 = $(this).parent().parent().prev("div").attr("id").toString().substring(3);
                    id3 = $(this).attr("id").toString().substring(3);
                    ChapterID = id1 + "|" + id2 + "|" + id3;
                    knowStatus = "show";
                }
                $("#ChapterID").val(ChapterID);
                DisplayKnowledge();
                BindWeikeResource();
                BindPutongResource();
                BindTopic();
                BindExamPaper();
            })

            knotContentHover($('.item_knot'));
            knotContentHover($('.item_content'));
            knotContentHover($('.item_chapter'));
        }
        function knotContentHover(obj) {
            obj.hover(function () {
                $(this).children('div').show();
            }, function () {
                $(this).children('div').hide();
            });
        }
        function DisplayKnowledge() {
            if (knowStatus == "hide") {
                $("#div_knowcontent").hide();
                $("#a_AddWork").hide();
                catawork_knowedgeid = "";
                GetWorkData();
            } else {
                $("#div_knowcontent").show();
                $("#a_AddWork").show();
                BindKnowledge();
            }
        }
        //取消左侧导航选中事件
        function ClearActiveClass() {
            $("#menu_side li").removeClass("active");
            $("#menu_side li ul li").removeClass("active");
            $("#menu_side  li ul li ul l").removeClass("active");
        }
        var isPower = 1;
        //获取数据
        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            //name = name || '';
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, ID: UrlDate.itemid },
                success: OnSuccess,
                error: OnError
            });
        }
        function OnSuccess(json) {
            if (json.result.errNum.toString() == "0") {
                $(".nocourse_wrap").css("display", "none");
                $(".mycourse").css("display", "");

                $("#tb_MyCource").html('');
                $("#tr_Cource").tmpl(json.result.retData.PagedData).appendTo("#tb_MyCource");
                $("#CourceName").html($(".mycourse_name").html());
                ////加入访问率分析代码////
                var items = json.result.retData.PagedData;
                if (items != null && items.length > 0) {
                    addMonnitor(0, items[0].ID, items[0].Name, 0, $("#HUserName").val(), $("#HUserIdCard").val());
                }
                ///////
                StudyTheCourseStu($(".course_type").attr("typevalue"));

            }
            else {
                $("#tb_MyCource").html('<li style="text-align:center">您无权限访问该课程！</li>');
                isPower = 0;
            }
            hoverEnlarge($('.mycourse_lists li .mycourse_img img'));
        }
        function OnError(XMLHttpRequest, textStatus, errorThrown) {
            $("#tb_MyCource").html('<li style="text-align:center">' + json.result.errMsg.toString() + '</li>');
            isPower = 0;
        }
        //绑定知识点
        function BindKnowledge() {
            $("#KnowleagPoint").html("");
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
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
        // 绑定章节数据
        var chapterDiv = "";
        var i = 0
        var j = 0;
        //var jsonChapator;
        var knowStatus = "hide";
        function Chapator() {
            $("#menu_side").html("");
            knowStatus = "hide";
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "Chapator", "CourseID": UrlDate.itemid },
                success: function (json) {
                    //jsonChapator = json;
                    BindChapator("0", "0", json);
                    $("#menu_side").html(chapterDiv);
                    DisplayKnowledge();
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
            if (chapterDiv.length == 0) {
                layer.msg("无目录数据");
            }
            //   getData(1, 10);
        }
        function BindChapator(pid, perPid, json) {
            var Itemclass = "item_content"
            if (perPid == "0" && pid != "0") {
                Itemclass = "item_knot";
            }
            if (perPid == "0" && pid == "0") {
                Itemclass = "item_chapter";
            }
            if (json.result.errNum.toString() == "0") {
                if (pid != "0" && perPid == "0" && i == 1) {
                    chapterDiv += "<ul style='display:block'>";
                }
                if (pid != "0" && perPid == "0" && i > 1) {
                    chapterDiv += "<ul style='display:none'>";
                }
                if (pid != "0" && perPid > 0 && j == 1) {
                    chapterDiv += "<ul style='display:block'>";
                }
                if (pid != "0" && perPid > 0 && j > 1) {
                    chapterDiv += "<ul style='display:none'>";
                }
                $(json.result.retData).each(function () {
                    var Type = 0;
                    var divid = "div" + this.ID;
                    if (Itemclass == "item_content") {
                        Type = 4;
                    }
                    var caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick='addLeftMenu(" +
                        this.ID + "," + pid + ", this,\"" + divid + "\"," + Type + ")'>添加</a><a href=\"javascript:void(0)\" onclick=\"EditMenu(this," +
                        this.ID + ",'" + this.Name + "')\">编辑</a>" + "<a href=\"javascript:void(0)\" onclick=\"DelMenu(" + this.ID + ")\">删除</a></div>";
                    //if (Itemclass == "item_content") {
                    //    caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick=\"EditMenu(this," + this.ID + ",'" + this.Name +
                    //        "')\">编辑</a>" + "<a href=\"javascript:void(0)\" onclick=\"DelMenu(" + this.ID + ")\">删除</a></div>";
                    //}

                    if (pid == "0" && this.Pid == pid) {
                        if (i == 0) {
                            $("#ChapterID").val(this.ID);

                            chapterDiv += "<li class='active'>";
                        }
                        else { chapterDiv += "<li>"; }
                        chapterDiv += "<div class=\"item_chapter\" id='" + divid + "'><span>" + this.Name +
                            "</span>" + caozuo + "<i class=\"icon  icon-angle-down\"></i></div>";
                        i++;
                        BindChapator(this.ID, this.Pid, json);
                        chapterDiv += "</li>";
                    }
                    if (pid != "0" && this.Pid == pid) {
                        chapterDiv += "<li><div class=\"" + Itemclass + "\" id='" + divid + "'><span>" + this.Name + "</span>" + caozuo + "</div>"
                        j++;
                        BindChapator(this.ID, this.Pid, json);
                        chapterDiv += "</li>"
                    }
                })
                if (pid != "0") {
                    chapterDiv += "</ul>";
                }
            }
            else {
                //layer.msg(json.result.errMsg);
            }
        }
        function addLeftMenu(id, pid, em, divid, Type) {
            var type = 3;
            var className = "item_content";
            if (pid == 0) {
                if (id == 0) {
                    type = 1;
                    className = "item_chapter";
                }
                else {
                    type = 2;
                    className = "item_knot";
                }
            }
            var length = 0;
            if (Type == 4) {
                length = $("#KnowleagPoint input").length;
                type = 4;
            }
            else {
                length = $('#menu_side input').length
            }
            if (length == 0) {

                var v = "<input type='text' value='' style='float:left;line-height:10px; width:100px; margin-top:8px;' id=\"Menu" + id
                   + "\"/> <i class=\"iconfont tishi true_t\" style=\"margin: 2px; color: #87c352; float:left;\" onclick=\"AddNewMenu('" + id
                   + "',''," + type + ")\">√</i> <i class=\"iconfont tishi fault_t\" style=\"margin: 2px; color: #ff6d72; float:left; \" onclick=\"DelCurrentAddMenu(this)\">×</i>";
                if (Type == 4) {
                    $(".points").prepend("<span id='span0'>" + v + "</span>");
                }
                else {
                    var html = "<li id='li0'><div  class=\"" + className + "\"> <span>" + v + "</span></div></li>";
                    if (id > 0) {
                        $("#" + divid).next("ul").prepend(html);
                    }
                    else {
                        $("#" + divid).prepend(html);
                    }
                }
            }
            else {
                alert(length);
                alert("有未完成操作");
                $('#menu_side input').focus();
            }
            stopEvent();
        }
        function DelCurrentAddMenu(e) {
            $("#li0").remove();
            $("#span0").remove();

            stopEvent();
        }
        function EditMenu(em, id, name, e) {
            var title = $(em).parent().parent().children("span").html();
            if (name == title) {
                var v = "<input type='text' value='" + title + "' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + id +
        "\"/> <i class=\"icon icon-ok tishi true_t\" style=\"margin: 0px 0px 0px 6px; color: #87c352; float: left;cursor:pointer;\" onclick=\"EditMenuName(this,'" + id + "')\"></i> <i class=\"icon icon-remove tishi fault_t\" style=\"margin: 0px 0px 0px 6px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"EditNameQ(this,'" + name +
        "')\"></i>";
            }
            $(em).parent().parent().children("span").html(v);
            stopEvent();
            //$(em).parents("li").find(".docu_name").removeAttr("onclick");
            // 取消事件冒泡
            var e = arguments.callee.caller.arguments[0] || event; // 若省略此句，下面的e改为event，IE运行可以，但是其他浏览器就不兼容
            if (e && e.stopPropagation) {
                // this code is for Mozilla and Opera
                e.stopPropagation();
            } else if (window.event) {
                // this code is for IE
                window.event.cancelBubble = true;
            }

        }
        function EditMenuName(em, id, e) {
            var name = $("#txt" + id).val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
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
        //取消修改文件名称
        function EditNameQ(em, name, e) {
            $(em).parents(".item_chapter").children("span").html(name);
            stopEvent();
        }
        //添加导航
        function AddNewMenu(id, e, type) {
            var CourseID = UrlDate.itemid;
            var FileName = $("#Menu" + id + "").val();

            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
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
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
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

    </script>
    <script>
        function Show(id) {
            OpenIFrameWindow('视频预览', 'ShowMove.aspx?ID=' + id, '600px', '400px');
        }
        //微课资源
        function BindWeikeResource() {
            var ChapterID = $("#ChapterID").val();

            $("#weike").children().remove();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
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
        //删除微课资源
        function Delvideo(id) {
            if (confirm("确定要删除资源吗？")) {
                $.ajax({
                    url: "Uploade.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "DelWeike", DelID: id },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            layer.msg("删除成功");
                            BindWeikeResource();
                        }
                        else { layer.msg('删除失败！'); }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }
        }
        //普通资源
        function BindPutongResource() {
            var ChapterID = $("#ChapterID").val();

            $("#Resource").children().remove();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CouseResource.ashx", "Func": "GetResourceList", CourceID: UrlDate.itemid, IsVideo: 0, ChapterID: ChapterID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#CountResource").html(json.result.retData.length);
                        $(json.result.retData).each(function () {

                            var li = " <li class=\"clearfix\"><img style=\"width: 20px; height: 16px; float: left; margin-right: 2px;\" src=\"" + this.FileIcon + "\"><p class=\"repository_name fl\">" +
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
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "/OnlineLearning/TaskHandler.ashx", "Func": "GetTaskDataPage", CourceID: UrlDate.itemid, ChapterID: ChapterID, UserIdCard: $("#HUserIdCard").val() },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#CountTask").html(json.result.retData.PagedData.length);
                        $(json.result.retData.PagedData).each(function () {
                            var li = "<li class=\"clearfix\"><div class=\"discuss_img fl\"><img src=\"../images/exam_img.png\" />" +
                                "</div><div class=\"test_description fl\" style=\"cursor:pointer;margin-left:10px;width:400px;\"><h2 onclick=\"LookTaskStatistics('" + this.ID + "','" + this.Name + "');\"><a href=\"javascript:;\">" + this.Name
                                + "</a><span class=\"test_type\">" + this.TaskType + "</span></h2><div class=\"notecnt\" style=\"cursor:pointer;color:#555555;font-size:14px;\" onclick=\"JumpToTask('" + this.RelationID + "','" + this.RelName + "','" + this.TaskType + "','" + this.ChapterID + "','" + this.ComCount + "','" + this.RelOtherField + "','self','tea');\">" +
                        "任务：" + this.RelName + "( 权重：" + this.Weight + "&emsp; 学生范围：" + this.ClassStrName + ")</div>"+" <div class='clearfix mt5'><div class=\"clearfix fl caozuo_none\">"
                            + (this.IsCreate.toString() == "1"? "<div class=\"fl\" style=\"color: #0b70bc\" onclick=\"DeleteTask('"+this.ID+"','false');\"><i class=\"icon icon-trash\" style=\"color: #0b70bc; display: inline-block;\"></i>删除 </div>" : " ")+"</div></div></div>" +
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
        function LookTaskStatistics(taskid, taskname) {
            window.open("/CourseManage/Course_TaskStatistics.aspx?taskid=" + taskid + "&coursetype=" + $(".course_type").attr("typevalue") + "&taskname=" + encodeURIComponent(taskname) + "&courseid=" + UrlDate.itemid);
        }
        function AddWeike(IsVideo) {
            var CourceID = UrlDate.itemid
            var UserIdCard = $("#HUserIdCard").val()
            OpenIFrameWindow('新增微课', 'AddWeike.aspx?CourceID=' + CourceID + "&ChapterID=" + $("#ChapterID").val() + "&IsVideo=" + IsVideo + "&UserIdCard=" + UserIdCard, '600px', '400px');
        }
        function SelResource(IsVideo) {
            var CourceID = UrlDate.itemid

            OpenIFrameWindow('选择资源', '../ResourceManage/PublicResoure.aspx?CourceID=' + CourceID + "&ChapterID=" + $("#ChapterID").val() + "&IsVideo=" + IsVideo, '900px', '90%');
        }
        $(function () {
            var ChapterID = $("#ChapterID").val();
            var CourceID = UrlDate.itemid
            if (CourceID != undefined) {
                $("#uploadify").uploadify({
                    'auto': true,                      //是否自动上传
                    'swf': '../Scripts/Uploadyfy/uploadify/uploadify.swf',
                    'uploader': 'Uploade.ashx',
                    'formData': { Func: "UplodWeik", Type: 2, CourceID: CourceID, ChapterID: ChapterID, IsVideo: 0 }, //参数
                    //'fileTypeDesc': '',
                    'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                    'buttonText': '上传资源',//按钮文字
                    // 'cancelimg': 'uploadify/uploadify-cancel.png',
                    'width': 90,
                    'height': 30,
                    //最大文件数量'uploadLimit':
                    'multi': false,//单选            
                    'fileSizeLimit': '20MB',//最大文档限制
                    'queueSizeLimit': 1,  //队列限制
                    'removeCompleted': true, //上传完成自动清空
                    'removeTimeout': 0, //清空时间间隔
                    //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
                    'onUploadSuccess': function (file, data, response) {
                        //var json = $.parseJSON(data);
                        BindPutongResource();
                        // $("#img_Pic").attr("src", json.result.retData);

                        //$("#img_Pic").val(data);
                    },

                });
            }
        });

        //评论
        function BindTopic() {
            $("#ul_discuss").children().remove();
            GetTopicData(1, 5, 0, " ", false, "ul_discuss", "li_discuss", "comment_discuss", "li_discusscomment", "span_discussreplaycount");
        }
        function AddTask() {
            OpenIFrameWindow('新增任务', 'Course_TaskAdd.aspx?itemid=0&courseid=' + UrlDate.itemid + '&coursetype=' + $(".course_type").attr("typevalue") + '&ChapterID=' + $("#ChapterID").val(), '600px', '480px');
        }
        function AddWork() {
            var pointid = $("#KnowleagPoint .on").attr("knowid");
            if (pointid == undefined || !pointid.length) {
                layer.msg("请选中知识点！");
                return;
            }
            OpenIFrameWindow('发布作业', '/OnlineLearning/Course_WorkEdit.aspx?itemid=0&courseid=' + UrlDate.itemid + '&coursetype=' + $(".course_type").attr("typevalue") + '&ChapterID=' + $("#ChapterID").val() + '&pointid=' + pointid, '500px', '410px');
        }
        function EditWork(itemid, chapterID, pointid) {
            OpenIFrameWindow('编辑作业', '/OnlineLearning/Course_WorkEdit.aspx?itemid=' + itemid + '&courseid=' + UrlDate.itemid + '&coursetype=' + $(".course_type").attr("typevalue") + '&ChapterID=' + chapterID + '&pointid=' + pointid, '500px', '410px');
        }
    </script>
    <%-- 加载讨论的js--%>
    <script type="text/javascript">
        $('.filtercri>a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
        });
        var user_pagetype = "tea";
        function GetDiscussDataPage(startIndex, pageSize) {
            if (isPower == 0) {
                return;
            }
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
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
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
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
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
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

    </script>
    <script type="text/javascript">

        function GetEvalueDataPage(startIndex, pageSize) {

            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
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
        function Star() {
            //stars评价
            $('.mnc').find(".assess").each(function () {
                var num = $(this).attr("id");
                if (num > 0) {
                    $(this).find("span").eq(num - 1).siblings().removeClass('on');
                    $(this).find("span").eq(num - 1).prevAll().andSelf().addClass('on');
                }
            })
        }        
    </script>
       
</body>
</html>
