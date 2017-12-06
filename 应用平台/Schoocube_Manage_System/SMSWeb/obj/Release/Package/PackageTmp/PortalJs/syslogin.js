$(function () {
    initLogIn();
    $("#GoBBS").on("click", function () {
        if ($.cookie('LoginCookie_Cube') == null || $.cookie('LoginCookie_Cube') == "null" || $.cookie('LoginCookie_Cube') == "") {
            $(this).attr("href", "http://192.168.10.92:9010/index.aspx");
        } else {
            var param = "user=" + encrypt($("#HUserName").val()) + "&pwd=" + encrypt($.cookie("PwdCookie_Cube"));
            $(this).attr("href", "http://192.168.10.92:8072/InterfaceUser.aspx?" + param);
            //$(this).attr("href", "http://localhost:8889/InterfaceUser.aspx?" + param);
        }
    })
})
function initLogIn() {
    var htmlstr = "";
    if ($.cookie('LoginCookie_Cube') == null || $.cookie('LoginCookie_Cube') == "null" || $.cookie('LoginCookie_Cube') == "") {
        htmlstr = " <a href=\"javascript:;\" class=\"login\" onclick=\"OpenIFrameWindow('登录','/Portal/login.aspx','350px','350px')\">登录</a>|<a href=\"javascript:;\" class=\"resig\" onclick=\"OpenIFrameWindow('注册','/Portal/Register.aspx','540px','550px')\">注册</a>";
        $("#loginItem").html(htmlstr);
    } else {
        var info = $.parseJSON($.cookie('LoginCookie_Cube'));
        
        $.post("/Common.ashx", { PageName: "PortalManage/AdminManager.ashx", func: "QueryUserisRoot", LoginName: info.LoginName }, function (result) {
            if (result != null) {
                var json = JSON.parse(result);
                if (json.result.errMsg == "success") {
                    var items = json.result.retData;
                    if (items != null && items.length > 0) {
                        htmlstr += "<a target=\"_blank\"  href='/Portal/Admin/Index.aspx'>管理后台</a>" + " 欢迎" + info.LoginName + "<a onclick=\"sysloginOut()\" href=\"javascript:;\">[退出]</a>";
                        $("#loginItem").html(htmlstr);
                    } else {
                        htmlstr = "欢迎" + info.LoginName + "<a onclick=\"sysloginOut()\" href=\"javascript:;\">[退出]</a>";
                        $("#loginItem").html(htmlstr);
                    }
                    
                } else {
                    htmlstr = "欢迎" + info.LoginName + "<a onclick=\"sysloginOut()\" href=\"javascript:;\">[退出]</a>";
                    $("#loginItem").html(htmlstr);
                }
            }

        });
    }
    

}

function sysloginOut() {
    //$.cookie('LoginCookie_Cube', null);
    //$.cookie('LoginCookie_Cube', '');
    //$.cookie('PwdCookie_Cube', null);
    //$.cookie('PwdCookie_Cube', '');
    //$.removecookie('LoginCookie_Cube');
    //$.removecookie('PwdCookie_Cube');
    $.cookie('LoginCookie_Cube', null, { path: '/' });
    $.cookie('PwdCookie_Cube', null, { path: '/' });
    window.location = "/Portal/index.aspx";
}




/*
*功能：对url加密算法（只针对window.location.href跳转，不针对post表单提交及ajax方式）
*算法：对于暴露在浏览器地址栏中的属性值进行加密，如一个属性为agentID=1，
*     若对1加密后为k230101io934jksd32r4，说明如下：
*     前三位为随机数；
*     第四到第五位为要加密字符转换成16进制的位数，
*       如：要加密字符为15转换成16进制为f，位数为1，则第四、五位为01；
*     第六位标识要加密字符为何种字符，0：纯数字，1：字符
*       若是字符和数字的混合，则不加密；
*     从第七位开始为16进制转换后的字符（字母和非数字先转换成asc码）；
*     若加密后的字符总位数不足20位，则用随机数补齐到20位，若超出20位，则不加随机数。
*     即加密后总位数至少为20位。
*/
function encode16(str) {
    str = str.toLowerCase();
    if (str.match(/^[-+]?\d*$/) == null) {//非整数字符，对每一个字符都转换成16进制，然后拼接
        var s = str.split("");
        var temp = "";
        for (var i = 0; i < s.length; i++) {
            s[i] = s[i].charCodeAt();//先转换成Unicode编码
            s[i] = s[i].toString(16);
            temp = temp + s[i];
        }
        return temp + "{" + 1;//1代表字符
    } else {//数字直接转换成16进制
        str = parseInt(str).toString(16);
    }
    return str + "{" + 0;//0代表纯数字
}


function produceRandom(n) {
    var num = "";
    for (var i = 0; i < n; i++) {
        num += Math.floor(Math.random() * 10);
    }
    return num;
}

//主加密函数
function encrypt(str) {
    var encryptStr = "";//最终返回的加密后的字符串
    encryptStr += produceRandom(3);//产生3位随机数

    var temp = encode16(str).split("{");//对要加密的字符转换成16进制
    var numLength = temp[0].length;//转换后的字符长度
    numLength = numLength.toString(16);//字符长度换算成16进制
    if (numLength.length == 1) {//如果是1，补一个0
        numLength = "0" + numLength;
    } else if (numLength.length > 2) {//转换后的16进制字符长度如果大于2位数，则返回，不支持
        return "";
    }
    encryptStr += numLength;

    if (temp[1] == "0") {
        encryptStr += 0;
    } else if (temp[1] == "1") {
        encryptStr += 1;
    }

    encryptStr += temp[0];

    if (encryptStr.length < 20) {//如果小于20位，补上随机数
        var ran = produceRandom(20 - encryptStr.length);
        encryptStr += ran;
    }
    return encryptStr;
}