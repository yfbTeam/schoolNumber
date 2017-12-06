<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StuLessonDetail.aspx.cs" Inherits="SMSWeb.OnlineLearning.StuLessonDetail" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>课程详情</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="js/menu_top.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/KindUeditor/kindeditor-min.js"></script>
    <script src="/Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="/Scripts/KindUeditor/lang/zh_CN.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="TopicAndComment.js"></script>
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
        .test_lists li .homework_none{width:100%;}
        .keep{margin-top:20px;font-size:14px;color:#666;cursor:pointer;}
        .keep{font-size:16px;}
        .collect{color:#D84A27;margin-top:20px;font-size:14px;cursor:pointer;}
        .collect{font-size:16px;}
    </style>
    <script id="li_mylessons" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="mycourse_img fl">
                <img src="${ImageUrl}" alt="" onerror="javascript:this.src='/images/course_default.jpg'"/>
            </div>
            <div class="fr mycourse_mes">
                <h1 class="mycourse_name" progess="{{if AllWeight==0}}0%{{else}}${Math.round(ComWeight/AllWeight * 10000) / 100.00 + "%"}{{/if}}">${Name}</h1>
                  <div class="assess" id="${Evalue}" style="height:24px; position:absolute; margin-top:-32px; right:12px; top:60px;">
                    <span id="1" onclick="Evalue(1,${ID},this)"></span>
                    <span id="2" onclick="Evalue(2,${ID},this)"></span>
                    <span id="3" onclick="Evalue(3,${ID},this)"></span>
                    <span id="4" onclick="Evalue(4,${ID},this)"></span>
                    <span id="5" onclick="Evalue(5,${ID},this)"></span>
                </div>
                <h2 class="clearfix">
                    <div class="fl lecturer">
                        主讲老师：<span>${LecturerName} </span>
                    </div>
                    <div class="fl course_type" typevalue="${CourceType}">
                        课程类别：{{if CourceType==1}}<span>必修课</span>{{else}}<span>选修课</span>{{/if}}
                    </div>
                    <div class="fl class_venue">
                        上课场地：<span>${StudyPlace}</span>
                    </div>
                    <div class="fl people_number">
                        选课人数上限：<span>${StuMaxCount}</span>
                    </div>
                </h2>
                <div class="course_desc">${CourseIntro}</div>
                <%--<div class="course_price btnprice_colorfree">
                    ￥${Price}
                </div>--%>
                <div class="collect" onclick="AddFavorite_Click('${Name}');">
                    <i class="icon-heart-empty"></i>
                    加入收藏
                </div>
                <%--<div class="keep">
                    <i class="icon-heart"></i>
                    移除收藏
                </div>--%>
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
                    <span class="movie fl">
                       {{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
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
                        <textarea id="commarea_discus${Id}" name="commarea_discus" rows="" cols="" placeholder="请添加你的评论..."></textarea>
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
            <div class="imga fl"> <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/></div>
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
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/>
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">
                           {{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                        </span>
                    </div>
                    <div class="notecnt">${Name}</div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">${CreateTime_Format}</div>
                       
                    </div>
                     <div class="edit_delete mt5 clearfix">
                        <div class="clearfix fl caozuo_none">
                            {{if IsCreate==1}}
                            <div class="fl" style="color:#0b70bc" onclick="DeleteTopic(${Id},'true');">
                                     <i class="icon icon-trash" style="color:#0b70bc;display:inline-block;"></i>删除                                                                
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
                                <textarea id="commarea_${Id}" name="commarea_topic" rows="" cols="" placeholder="请添加你的评论..."></textarea>
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
            <div class="imga fl"><img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/></div>
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
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/>
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">
                           {{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                        </span>
                    </div>
                    <div class="notecnt">${Name}</div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">${CreateTime_Format}</div>
                       
                    </div>
                    <div class="edit_delete mt5 clearfix">
                        <div class="clearfix fl caozuo_none">
                            {{if IsCreate==1}}
                            <div class="fl" style="color:#0b70bc" onclick="DeleteTopic(${Id},'true',1,'ul_note');">
                                     <i class="icon icon-trash" style="color:#0b70bc;display:inline-block;"></i>删除                                                                
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
                                <textarea id="commarea_note${Id}" name="commarea_note" rows="" cols="" placeholder="请添加你的评论..."></textarea>
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
            <div class="imga fl"> <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/></div>
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
        <li class="noteitem" style="cursor:pointer;" onclick="JumpToTask(${RelationID},'${RelName}','${TaskType}','${ChapterID}','${ComCount}','${RelOtherField}');">
        <div class="notedit">
            <a href="javascript:;" class="img">
                <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/>
            </a>
            <div class="mnc">
                <div class="notehead clearfix">
                    <span class="note_user fl">${CreateName}</span>
                    <span class="note_lesson fr">                       
                       {{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                    </span>
                </div>
                <div class="notecnt">${Name}<span class="test_type ml10" style="padding:0px 4px;">${TaskType}</span></div>
                <div class="notecnt">任务：${RelName}               
                    ( 权重：${Weight} )                    
                    {{if IsHasTask==1}}
                    {{if ComCount==0}}<span class="test_trouble">未完成</span>{{else}}<span class="test_type">已完成</span>{{/if}}
                    {{/if}}
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
        <li id="li_catalogwork_${Id}" class="clearfix" workrelid="${WorkRelId}" iscorrect="${IsCorrect}">
            <div class="test_description fl">
                <h2><a href="javascript:;">${Name}</a></h2>
                <p>
                    <span>发布人：${CreateName}</span>
                    <span>发布时间：${DateTimeConvert(CreateTime,"yyyy-MM-dd HH:mm")}</span>
                </p>
            </div>
            <div class="test_lists_right fr clearfix">
                <div class="dates_a  pr" style="width: 280px">
                    <div class="seedeletion seedeletiona" >
                        <a href="javascript:;" class="homework fl" onclick="DownLoad('${Attachment}');" style="padding:0px 4px;"><i class="icon icon-download-alt" style="color:#fff;"></i>下载教师布置作业</a>
                        {{if IsCanCorrect==0}} 
                            <a href="javascript:;" class="homework homeworkb pr homeworka" style="background:#ccc;line-height:24px;">
                                <i class='icon icon-upload-alt' style='color:#fff;'></i>提交作业
                            </a> 
                        {{else}}    
                            <a href="javascript:;" class="homework homeworkb pr homeworka">
                               <input type="file" id="uploadifycata_${Id}" name="uploadify" class="uploadify_catalogwork"/>
                            </a>
                        {{/if}}                        
                        <span class="closeshow fl" style="margin-top:-3px;">+</span>
                    </div>
                    <div class="data">
                        提交截止时间：{{if IsCanCorrect==0}}<label style="color:red;">${EndTime_Format}</label>
                        {{else}}${EndTime_Format}{{/if}}
                    </div>
                </div>
            </div>
            <div class="homework_none none clearfix">                
                 <div class="wrap" style="width:100%;">               
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
                                <th>详情评语</th>                            
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
            <td><a onclick="DownLoad('${Attachment}');">${CutFileName(Attachment,16)}</a></td>
            <td>{{if CorrectUID==''}}<span style="color:red;">否</span>{{else}}<span>是</span>{{/if}}</td>
            <td>${Score}</td>  
            <td>${StoreLevel}</td>   
            <td>{{if CorrectUID!=''}}<a href="javascript:;" onclick="LookCorrectWork('${WorkId}',${Id});">查看</a>{{/if}}</td>      
        </tr>
    </script>

    <%--作业列表的绑定--%>
    <script id="li_tabwork" type="text/x-jquery-tmpl">
        <li id="li_tabwork_${Id}" workrelid="${WorkRelId}" iscorrect="${IsCorrect}">
            <div class="homework_mes clearfix">
                <div class="homework_mes_left fl">
                    <h2><a href="javascript:;" style="cursor:pointer;" onclick="LookWorkStatistics('${Id}','${Name}');">${Name}</a><span class="submit"><label id="lbl_commit_${Id}">${WorkRelCount}</label>人已提交</span><span class="nosubmit" style="cursor:pointer;" onclick="GetStuWorkCompleteInfo('${Id}');"><label id="lbl_nocommit_${Id}">0</label>人未提交</span></h2>
                    <p>
                        <span>发布人：${CreateName}</span>
                        <span>发布时间：${DateTimeConvert(CreateTime,"yyyy-MM-dd HH:mm")}</span>
                        <span>提交截止时间：{{if IsCanCorrect==0}}<label style="color:red;">${EndTime_Format}</label>
                        {{else}}${EndTime_Format}{{/if}} </span>                      
                    </p>
                </div>
                <div class="homework_mes_right fr">
                    <div class="homework_mes_a">
                        <a href="javascript:;" onclick="DownLoad('${Attachment}');" class="homework fl"><i class="icon icon-download-alt"></i>下载教师布置作业</a>                        
                       {{if IsCanCorrect==0}} 
                            <a href="javascript:;" class="homework homeworkb pr" style="background:#ccc;line-height:24px;">
                                <i class='icon icon-upload-alt' style='color:#fff;margin:4px;'></i>提交作业
                            </a> 
                        {{else}}    
                            <a href="javascript:;" class="homework homeworkb pr">
                                <input type="file" id="uploadify_${Id}" name="uploadify" class="uploadify_work"/>
                            </a>
                        {{/if}}                            
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
                                <th>详情评语</th>                            
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
            <td>{{if CorrectUID==''}}<span style="color:red;">否</span>{{else}}<span>是</span>{{/if}}</td>
            <td>${Score}</td>  
            <td>${StoreLevel}</td>   
            <td>{{if CorrectUID!=''}}<a href="javascript:;" onclick="LookCorrectWork('${WorkId}',${Id});">查看</a>{{/if}}</td>      
        </tr>
    </script>
    <style type="text/css">
        .note_oper .heart .icon, .discuss-wrap .heart .icon {
            color: #D84A27;
        }

        .test_lists li .test_lists_right .seedeletiona .homeworka span{width:auto;line-height:18px;}
        .test_lists li .test_lists_right .seedeletiona .homeworka .uploadify{top:0;}

        .homeworkb{display:block;float:left;width:84px;height:24px;padding:0px;}
        .homeworkb .uploadify{left:2px;top:2px;}
        .homeworkb .uploadify-button {border:none;color:#fff;font-weight:normal;background:#1775BD;font-size:14px;}
    </style>
</head>
<body>
    <input type="hidden" id="ChapterID" value="" />
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HStuIDCard" runat="server" />
    <input type="hidden" id="Hid_ClassID" value="<%=ClassID %>"/>
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
           <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
            <nav class="navbar menu_mid fl">
                <ul id="CourceMenu">
                    <li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                    <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                    <li currentclass="active"><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                    <li currentclass="active"><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
                    <li currentclass="active"><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                    <li  currentclass="active"><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                    <li currentclass="active"><a href="/analysisa/student_studyprocess(4).aspx">个人学习进度</a></li>
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
                        <a href="/Gopay/Gopay.aspx" target="_blank"><span>账户管理</span></a>
                        <a href="/PersonalSpace/PersonalSpace_Student.aspx" target="_blank"><span >个人中心</span></a>
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
                    <a href="javascript:;" class="on">课程详情</a>
                </div>
            </div>
            <!--面包屑-->
            <div class="crumbs">
                <a href="MyLessons.aspx" id="a_parentUrl">在线学习</a>
                <span>></span>
                <a href="#" id="a_lessonname"></a>
            </div>
            <div class="mycourse">
                <ul class="mycourse_lists" id="ul_mylessons"></ul>
            </div>
            <div class="coursedetail_nav">
                <a href="javascript:;" class="on">目录</a>
                <a href="javascript:;" onclick="GetDiscussDataPage(1, 5);">讨论</a>
                <a href="javascript:;" onclick="GetNoteDataPage(1, 5);">笔记</a>
                <a href="javascript:;" onclick="GetTaskDataPage(1,5);">任务</a>
                <a href="javascript:;" onclick="GetWorkDataPage(1,5);">作业</a>

            </div>
            <div class="shadow">
            </div>
        </div>
    </div>
    <div class="width course_process_wrap bordshadrad mb10">
        <div class="course_process pr">
            <div class="shadow_left">
                <span></span>
                <span></span>
            </div>
            <div class="shadow_right">
                <span></span>
                <span></span>
            </div>
            <div class="processwrap clearfix">
                <div class="process_outer fl" style="width:1160px;">
                    <div class="process_inner" id="div_process_inner" style="width:0%;"></div>
                </div>
                <%--<a href="javascript:;" class="course_btn btnprice_bgfree fr">继续学习</a>--%>
            </div>
            <div class="completedclass_wrap clearfix">
                <div class="fl completedclass">
                    目前已完成 <span id="span_Percent">0%</span>, 加油啊！
				
                </div>
                <%--<a href="javascript:;" class="fr">下一个课时 : 传统学英语方法的误区</a>--%>
            </div>
            <div class="shadow">
            </div>
        </div>
    </div>
    <div class="width course_student_wrap clearfix">
        <div class="clearfix" style="display: block;">
            <div class="course_student clearfix pr bordshadrad fl">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <div class="coursedetail_items fl">
                    <div class="detail_items_title">
                        课程目录
                    </div>
                    <ul class="item_sides" id="menu_side"><li><div class="item_chapter"><span>暂无目录数据</span></div></li></ul>
                </div>
                <div class="course_student_right fr">
                    <%--<div class="stytem_select clearfix">
                        <div class="search_exam fl pr">
                            <input type="text" name="" id="" value="" placeholder="请输入课程名称" />
                            <i class="icon  icon-search"></i>
                        </div>
                    </div>
                    <p class="course_title">设想上课睡觉睡觉</p>--%>
                    <div class="knowledge_points" id="div_knowcontent">
						<h1 class="knowledge_title">知识点</h1>
                        <div class="points clearfix" id="KnowleagPoint">
							
						</div>
					</div>
                    <h1 class="course_detail clearfix">
                        <div class="on">
                            <i class="icon icon_course"></i>
                            <span>微课（<em id="CountVideo">0</em>）</span>
                        </div>
                        <div class="">
                            <i class="icon icon_resource"></i>
                            <span>资源（<em id="CountResource">0</em>）</span>
                        </div>
                        <div class="">
                            <i class="icon icon_discuss"></i>
                            <span>讨论（<em id="CountTopic">0</em>）</span>
                        </div>
                        <div class="">
                            <i class="icon"><img src="../images/homework1.png" /></i>
                            <span>任务（<em id="CountTask">0</em>）</span>
                        </div>
                        <div class="">
                            <i class="icon icon_test"></i>
                            <span>作业（<em id="CountWork">0</em>）</span>
                        </div>
                    </h1>
                    <div class="course_detail_listswrap">
                        <div>
                            <ul class="course_detail_lists clearfix" id="weike"></ul>
                        </div>
                        <div class="none">
                            <ul class="repository_lists" id="Resource"></ul>
                        </div>
                        <div class="none">
                            <ul class="discuss_lists" id="ul_discuss"></ul>
                        </div>
                        <div class="none">
                            <%--<div class="stytem_select_right fr">
                            <a href="itemmanage.html" class=""><i class="icon icon-plus"></i>从题库选择试卷</a>
                            <a href="exammanage.html" class=""><i class="icon icon-plus"></i>添加试卷</a>
                        </div>--%>
                            <div class="clear">
                            </div>
                            <ul class="test_lists exam_lists testing" id="Task"></ul>
                        </div>
                        <div class="none">
                            <ul class="test_lists exam_lists testing clearfix" id="ul_catalogwork"></ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="course_learned fr bordshadrad pr">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <p class="learned_title">正在学习的同学</p>
                <div class="class_selectwrap">
                    <ul class="class_select" id="ul_studystu"><li><span>暂无正在学习的同学！</span></li></ul>
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
            <!--讨论-->
            <div class="discuss_wrap">
                <div class="note_title">
                    <span class="fl">讨论区</span><div class="search_exam fl ml10 pr">
                        <input type="text" name="txt_topicTitle" id="txt_topicTitle" value="" onblur="GetDiscussDataPage(1, 5);" placeholder="请输入讨论标题" />
                        <i class="icon  icon-search" style="top:16px;"></i>
                    </div>               
                </div>
                <div class="discuss_listswrap">
                    <ul id="ul_topic"><li>暂无讨论！</li></ul>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
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
            <!--笔记-->
            <div class="note_wrap">
                <div class="note_title">
                    <span class="fl">笔记</span><div class="search_exam fl ml10 pr">
                        <input type="text" name="txt_noteTitle" id="txt_noteTitle" value="" onblur="GetNoteDataPage(1, 5);" placeholder="请输入笔记标题"/>
                        <i class="icon  icon-search" style="top:16px;"></i>
                    </div>                    
                </div>
                <div class="discuss_listswrap">
                    <ul id="ul_note"><li>暂无笔记！</li></ul>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar_note"></span>
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
            <!--任务-->
            <div class="work_wrap">
                <div class="note_title">
                     <span class="fl">任务</span><div class="search_exam fl ml10 pr">
                        <input type="text" name="txt_taskTitle" id="txt_taskTitle" value="" onblur="GetTaskDataPage(1, 5);" placeholder="请输入任务标题"/>
                        <i class="icon  icon-search" style="top:16px;"></i>
                    </div>
                </div>
                <div class="discuss_listswrap">
                    <ul id="ul_task"><li>暂无任务！</li></ul>
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
						<input type="text" name="txt_workname" id="txt_workname" value="" onblur="GetWorkDataPage(1,5);" placeholder="请输入作业标题"/>
						<i class="icon  icon-search"></i>
                        <input type="text" name="txt_chaptername" id="txt_chaptername" value="" onblur="GetWorkDataPage(1,5);" placeholder="请输入目录名称"/>
						<i class="icon  icon-search"></i>
					</div>
				</div>
				<div class="knowledge_points none">
					<h1 class="knowledge_title">知识点</h1>
					<div class="points clearfix" id="div_workknowedge"><a href="javascript:;">暂无知识点！</a></div>
				</div>
				<h1 class="course_detail clearfix">
					<div class="fl">
						<i class="icon"><img src="../images/homework.png" alt="" /></i>
						<span style="color:#1775bd">作业</span>
					</div>
				</h1>
				<ul class="homework_lists" id="ul_tabwork"><li style="border:none;">暂无作业！</li></ul>
                <!--分页-->
                <div class="page">
                    <span id="pageBar_work"></span>
                </div>
            </div>
        </div>
    </div>
    <div id="div_stuContent" class="course_learned fr bordshadrad pr" style="display: none;width:500px;">
        <p class="learned_title"></p>
        <div class="class_selectwrap">
            <ul class="class_select" id="ul_stuContent"></ul>
        </div>
    </div>
    <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/system.js"></script>
    <script>          
        //讨论 笔记目录切换
        $('.coursedetail_nav a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            $('.course_student_wrap>div').eq(n).show().siblings().hide();
        });
        ////折叠菜单选中样式
        //$('#menu_side li ul li ul li').click(function () {
        //    $(this).addClass('active').siblings().removeClass('active');
        //})
        //微课 资源 tab切换
        $('.course_detail>div').click(function () {
            $(this).addClass('on').siblings().removeClass();
            var n = $(this).index();
            $('.course_detail_listswrap>div').eq(n).show().siblings().hide();
        })
    </script>
</body>
<script type="text/javascript">
    var UrlDate = new GetUrlDate(); //实例化
    var upworkid = UrlDate.tabconid || "";
    $(document).ready(function () {
        $("#CourceMenu li").eq(UrlDate.flag).addClass('active').siblings().removeClass('active');
        $("#a_parentUrl").html(UrlDate.flag == 0 ? "学习中心门户" : "在线学习");
        $("#a_parentUrl").attr("href", UrlDate.flag == 0 ? "/PersonalSpace/Learning_center_portal.aspx" : "/OnlineLearning/MyLessons.aspx");
        getData(1, 10);               
    });
    var isPower = 1;
    var Teacher_IDCard = "", Teacher_Name = "";
    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                Func: "GetMyLessonsDataPage",
                PageIndex: startIndex,
                pageSize: pageSize,
                CourseID: UrlDate.itemid,
                StuNo: $("#HUserIdCard").val(),
                ClassID: $("#Hid_ClassID").val(),
                OperSymbol: ">"
            },
            success: OnSuccess,
            error: OnError
        });
    }
    function OnSuccess(json) {
        if (json.result.errNum.toString() == "0") {
            var rtnData = json.result.retData.PagedData;
            Teacher_IDCard = rtnData[0].CreateUID, Teacher_Name = rtnData[0].LecturerName;
            $("#ul_mylessons").html('');
            $("#li_mylessons").tmpl(rtnData).appendTo("#ul_mylessons");            
            $("#a_lessonname").html($(".mycourse_name").html());
            $("#div_process_inner").width($(".mycourse_name").attr("progess"));
            $("#span_Percent").html($(".mycourse_name").attr("progess"));
            ////加入访问率分析代码////
            if (rtnData != null && rtnData.length > 0) {
                addMonnitor(0, rtnData[0].ID, rtnData[0].Name, 0, $("#HUserName").val(), $("#HUserIdCard").val());
            }
            ///////            
            StudyTheCourseStu($(".course_type").attr("typevalue"));
            Star();
           
        }
        else {
            $("#ul_mylessons").html('<li style="text-align:center">您无权限访问该课程！</li>');
            isPower = 0;
        }
        hoverEnlarge($('.mycourse_lists li .mycourse_img img'))
    }
    function OnError(errMsg) {
        $("#ul_mylessons").html('<li style="text-align:center">' + json.result.errMsg.toString() + '</li>');
        isPower = 0;
    }

    function Star() {
        //stars评价
        $('.mycourse_mes').find(".assess").each(function () {
            var num = $(this).attr("id");
            if (num > 0) {
                $(this).find("span").eq(num - 1).siblings().removeClass('on');
                $(this).find("span").eq(num - 1).prevAll().andSelf().addClass('on');
            }
        })
    }

    //课程评价
    function Evalue(star, ID, em) { //stars评价
        if ($(em).parent().find(".on").length > 0) {
            layer.msg("不允许重复评论");
        }
        else {
            $(em).siblings().removeClass('on');
            $(em).prevAll().andSelf().addClass('on');
            OpenIFrameWindow('添加评价', '/CourseManage/EvalueContent.aspx?ID=' + ID + "&Evalue="+star, '630px', '70%');
        }
    }
    function StudyTheCourseStu(coursetype) {
        $("#ul_studystu").children().remove();
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/OnlineLearning/MyLessonsHandler.ashx", "Func": "StudyTheCourseStu", CourseID: UrlDate.itemid, CourceType: coursetype },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    if (json.result.retData.length <= 0) {
                        $("#ul_studystu").html("<li><span>暂无正在学习的同学！</span></li>");
                        return;
                    }
                    studyTheCourseStu = json.result.retData;
                    studyTheCourseStu_Count = json.result.retData.length;
                    var gradeArray = [], classArray = [];
                    $(json.result.retData).each(function () {
                        if (gradeArray.indexOf(this.GradeID) == -1) {
                            gradeArray.push(this.GradeID);
                            if (gradeArray.length == 1) {
                                $("#ul_studystu").append("<li><span>" + this.GradeName + "<i class='icon  icon-angle-down'></i></span><ul style='display: block;' id=\"ul_grade_" + this.GradeID + "\"></ul></li>");
                            } else {
                                $("#ul_studystu").append("<li><span>" + this.GradeName + "<i class='icon  icon-angle-up'></i></span><ul id=\"ul_grade_" + this.GradeID + "\"></ul></li>");
                            }
                        }
                        if (classArray.indexOf(this.ClassID) == -1) {
                            classArray.push(this.ClassID);
                            if (classArray.length == 1) {
                                $("#ul_grade_" + this.GradeID).append("<li><span class='active'>" + this.ClassName + "<i class='icon  icon-angle-down'></i></span><ul id=\"ul_class_" + this.ClassID + "\" class='learned_students_lists clearfix' style='display: block;'></ul></li>");
                            } else {
                                $("#ul_grade_" + this.GradeID).append("<li><span>" + this.ClassName + "<i class='icon  icon-angle-up'></i></span><ul id=\"ul_class_" + this.ClassID + "\" class='learned_students_lists clearfix'></ul></li>");
                            }
                        }
                        $("#ul_class_" + this.ClassID).append("<li><div class='learned_students_img'><img src=\""+this.PhotoURL+"\" alt='' onerror=\"javascript:this.src='/images/discuss_img_01.jpg'\"/></div><p class='learned_students_name'>" + this.Name + "</p></li>");
                    });
                    if (UrlDate.nav_index) {
                        $('.coursedetail_nav a').eq(UrlDate.nav_index).click();
                    }
                    GradeOrClassExpand();
                    Chapator();
                    BindWeikeResource();
                    BindPutongResource();
                    BindTopic();
                    BindExamPaper();
                }
                else {
                    $("#ul_studystu").html("<li><span>暂无正在学习的同学！</span></li>");
                }
            },
            error: function (errMsg) {
                layer.msg('加载失败！');
            }
        });
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
    var chapterDiv = "";
    var i = 0
    var j = 0;
    var knowStatus = "hide";
    function Chapator() {
        $("#div_knowcontent").hide();
        knowStatus = "hide";
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/CourseManage/CourceManage.ashx", Func: "Chapator", CourseID: UrlDate.itemid },
            success: function (json) {
                BindChapator("0", "0", json);
                $("#menu_side").html(chapterDiv);
                DisplayKnowledge();
                //折叠菜单
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
                        knowStatus="show";
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
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
        if (chapterDiv.length == 0) {
            $("#menu_side").html("<li><div class=\"item_chapter\"><span>暂无目录数据</span></div></li>");
        }
    }
    function DisplayKnowledge() {
        if (knowStatus == "hide") {
            $("#div_knowcontent").hide();
            catawork_knowedgeid = "";
            GetWorkData();
        } else {
            $("#div_knowcontent").show();
            BindKnowledge();
        }
    }
    function BindChapator(pid, perPid, json) {
        var Itemclass = "item_content"
        if (perPid == "0" && pid != "0") {
            Itemclass = "item_knot";
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
                var divid = "div" + this.ID;
                if (pid == "0" && this.Pid == pid) {
                    if (i == 0) {
                        $("#ChapterID").val(this.ID);
                        chapterDiv += "<li class='active'>";
                    }
                    else { chapterDiv += "<li>"; }
                    chapterDiv += "<div class=\"item_chapter\" id='" + divid + "'><span>" + this.Name + "</span><i class=\"icon  icon-angle-down\"></i></div>";
                    i++;
                    BindChapator(this.ID, this.Pid, json);
                    chapterDiv += "</li>";
                }
                if (pid != "0" && this.Pid == pid) {
                    chapterDiv += "<li><div class=\"" + Itemclass + "\" id='" + divid + "'><span>" + this.Name + "</span></div>"
                    j++;
                    BindChapator(this.ID, this.Pid, json);
                    chapterDiv += "</li>"
                }
            })
            if (pid != "0") {
                chapterDiv += "</ul>";
            }
        }
    }
    //微课资源
    function BindWeikeResource() {
        $("#weike").children().remove();
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/CourseManage/CouseResource.ashx", "Func": "GetResourceList", CourceID: UrlDate.itemid, IsVideo: 1, ChapterID: $("#ChapterID").val(), StuIdCard: $("#HStuIDCard").val() },
            success: function (json) {
                if (json.result.errNum.toString() == "999") {
                    $("#CountVideo").html(0);
                } else if (json.result.errNum.toString() == "0") {
                    $("#CountVideo").html(json.result.retData.length);
                    $(json.result.retData).each(function () {
                        var li = " <li><div class=\"course_detail_img\"><img src=\"" + this.VidoeImag + "\" onerror=\"javascript:this.src='/images/viedo_default.jpg'\"/></div><p class=\"course_detail_name\">" +
                           this.Name + "</p><div class=\"course_succdeta\">" + (this.ClickId == 0 ? "<span style=\"background:red;\">未看</span>" : (this.IsLookEnd == 0 ? "<span style=\"background:red;\">未看完</span>" : "<span style=\"background:green;\">已看完</span>")) + "</div><div class=\"course_detail_bg none\"><a onclick=\"ShowVideo('" + this.ID + "');\" class='icon-play-circle' style='font-size:50px;'></a></div></li>";
                        $("#weike").append(li);
                    })
                }
                else {
                    //layer.msg(json.result.errMsg);
                    $("#CountVideo").html(0);
                }
                $('.course_detail_lists li').hover(function () {
                    $(this).find('.course_detail_bg').fadeIn();
                }, function () {
                    $(this).find('.course_detail_bg').fadeOut();
                })
            },
            error: function (errMsg) {
                layer.msg('加载失败！');
            }
        });
    }
    function ShowVideo(videoid) {
        location.href = 'PlayerStudy.aspx?itemid=' + UrlDate.itemid + '&videoid=' + videoid
            + '&comchapterid=' + $("#ChapterID").val() + '&initchapterid=' + $('#menu_side').find('.active').children().attr('id').replace('div', '') + "&flag=" + UrlDate.flag;
    }
    //普通资源
    function BindPutongResource() {
        $("#Resource").children().remove();
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/CourseManage/CouseResource.ashx", "Func": "GetResourceList", CourceID: UrlDate.itemid, IsVideo: 0, ChapterID: $("#ChapterID").val() },
            success: function (json) {
                if (json.result.errNum.toString() == "999") {
                    $("#CountResource").html(0);
                } else if (json.result.errNum.toString() == "0") {
                    $("#CountResource").html(json.result.retData.length);
                    $(json.result.retData).each(function () {
                        var li = " <li class=\"clearfix\"><img style=\"width: 20px; height: 16px; float: left; margin-right: 2px;\" src=\"" + this.FileIcon + "\" onerror=\"javascript:this.src='/icons/ico-veizhib.png'\"><p class=\"repository_name fl\">" +
                this.Name + this.postfix + "</p><div class=\"repository_download none\" onclick=\"DownLoad('" + this.FileUrl + "');\"> <i class=\"icon icon-download-alt\"></i></div><span class=\"repository_date fr\">" +
                this.CreateTime + "</span></li>";
                        $("#Resource").append(li);
                    })
                }
                else {
                    //layer.msg(json.result.errMsg);
                    $("#CountResource").html(0);
                }
                $('.repository_lists>li').hover(function () {
                    $(this).find('.repository_download').show();
                }, function () {
                    $(this).find('.repository_download').hide();
                });
            },
            error: function (errMsg) {
                layer.msg('加载失败！');
            }
        });
    }
    //评论
    function BindTopic() {
        $("#ul_discuss").children().remove();
        GetTopicData(1, 5, 0, " ", false, "ul_discuss", "li_discuss", "comment_discuss", "li_discusscomment", "span_discussreplaycount");
    }
    //任务
    function BindExamPaper() {
        $("#Task").children().remove();
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/OnlineLearning/TaskHandler.ashx", "Func": "GetTaskDataPage", CourceID: UrlDate.itemid, ChapterID: $("#ChapterID").val() },
            success: function (json) {
                if (json.result.errNum.toString() == "999") {
                    $("#CountTask").html(0);
                } else if (json.result.errNum.toString() == "0") {
                    $("#CountTask").html(json.result.retData.PagedData.length);
                    $(json.result.retData.PagedData).each(function () {
                        var li = "<li class=\"clearfix\" onclick=\"JumpToTask('" + this.RelationID + "','" + this.RelName + "','" + this.TaskType + "','" + this.ChapterID + "','" + this.ComCount + "','" + this.RelOtherField + "');\"><div class=\"discuss_img fl\"><img src=\"../images/exam_img.png\" />" +
                            "</div><div class=\"test_description fl\"><h2><a href=\"javascript:;\">" + this.Name + "(" + this.RelName + ")"
                            + "</a><span class=\"test_type\">" + this.TaskType + "</span></h2><div class=\"notecnt\" style=\"cursor:pointer;color:#555555;font-size:14px;\" onclick=\"JumpToTask('" + this.RelationID + "','" + this.RelName + "','" + this.TaskType + "','" + this.ChapterID + "','" + this.ComCount + "','" + this.RelOtherField + "','self','tea');\">" +
                        "任务：" + this.RelName + "( 权重：" + this.Weight +")</div></div>" +
                            "  <div class=\"test_lists_right fr clearfix\"><div class=\"public_name fl\">发布人：" + this.CreateName + "</div><div class=\"dates_a dates_b fr pr\">"
                             + "<div class=\"seedeletion none\"><span class=\"preview pr\"><i class=\"icon icon-eye-open\"></i><em class=\"icon_tips\">预览</em></span>" +
                        "</div><div class=\"data\">发布时间：" + DateTimeConvert(this.CreateTime) + "</div></div></div></li>";

                        $("#Task").append(li);
                    })
                }
                else { $("#CountTask").html(0); }
            },
            error: function (errMsg) {
                layer.msg('加载失败！');
            }
        });
    }
    //取消左侧导航选中事件
    function ClearActiveClass() {
        $("#menu_side li").removeClass("active");
        $("#menu_side li ul li").removeClass("active");
        $("#menu_side  li ul li ul l").removeClass("active");
    }
    function knotContentHover(obj) {
        obj.hover(function () {
            $(this).children('div').show();
        }, function () {
            $(this).children('div').hide();
        })
    }
</script>

<%-- 加载讨论、任务、作业的js--%>
<script type="text/javascript">
    $('.filtercri>a').click(function () {
        $(this).addClass('on').siblings().removeClass('on');
    });
    var user_pagetype = "stu";
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
                PageName: "/OnlineLearning/TopicHandler.ashx",
                Func: "GetTopicDataPage",
                PageIndex: startIndex,
                pageSize: pageSize,
                Type: 0,
                CouseID: UrlDate.itemid,
                //ChapterID: $("#ChapterID").val(),
                TopicId: jump_topicid,
                Name: $("#txt_topicTitle").val().trim(),
                StuIDCard: $("#HStuIDCard").val(),
                UserIdCard: $("#HUserIdCard").val(),
                ClassID: $("#Hid_ClassID").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#ul_topic").html('');
                    $("#li_topic").tmpl(json.result.retData.PagedData).appendTo("#ul_topic");
                    $("#pageBar").show();$("#pageBar").show();
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
                PageName: "/OnlineLearning/TopicHandler.ashx",
                Func: "GetTopicDataPage",
                PageIndex: startIndex,
                pageSize: pageSize,
                Type: 1,
                CouseID: UrlDate.itemid,
                //ChapterID: $("#ChapterID").val(),
                Name:$("#txt_noteTitle").val().trim(),
                StuIDCard: $("#HStuIDCard").val(),
                UserIdCard: $("#HUserIdCard").val(),
                ClassID: $("#Hid_ClassID").val()
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
</script>
</html>

