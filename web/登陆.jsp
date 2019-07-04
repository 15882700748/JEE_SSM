<%--
  Created by IntelliJ IDEA.
  User: 15700
  Date: 2019/5/1
  Time: 13:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<link href="https://cdn.bootcss.com/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
<link rel="stylesheet" href="js/css/layui.css">
<style>
    body {
        width: 100wh;
        height: 90vh;
        color: rgb(244, 244, 244);
        background: linear-gradient(-45deg, #EE7752, #E73C7E, #23A6D5, #23D5AB);
        background-size: 400% 400%;
        -webkit-animation: Gradient 15s ease infinite;
    }
    input::-webkit-input-placeholder {
        /* placeholder颜色  */
        color: #e3eef9;
        /* placeholder字体大小  */
        font-size: 14px;!important;
    }
    @-webkit-keyframes Gradient {
        0% {
            background-position: 0% 50%
        }
        50% {
            background-position: 100% 50%
        }
        100% {
            background-position: 0% 50%
        }
    }

    @-webkit-keyframes Fade {
        0 % {
            opacity: 0.9;
        }
        50% {
            opacity: 0.5;
        }
        100% {
            opacity: 0.9;
        }
    }
    .layui-form-checkbox[lay-skin=primary] span {
        color:#fff ;
        height: 30px;
    }
    .layui-layer-dialog .layui-layer-content {
        color:#000;
    }
    #forgetPass {
        position: absolute;
        display: inline-block;
        width: 50px;
        height: 20px;
        left: 85%;
        font-size: 10px;
        top: 16px;
        cursor: pointer;
    }
    #forgetPass:hover{
        color: #707070;
        text-decoration: underline;
    }
    .form-input-icon{
        display: block;
        width: 38px;
        height: 38px;
        position: absolute;
        font-size: 25px;
        line-height: 38px;
        left: 4px;
        top: -5px;
    }
    input:focus .form-input-icon{

    }
</style>
<body>
<div class="layui-container" style="position: absolute;width: 500px;height: 300px;top: 50%; left: 45%;transform: translate(-50%,-45%)" >
    <div class="layui-row text-center" style="position: relative;width: 360px;height: auto;left: 110px;top: -50px;">
        <h1>登陆</h1>
    </div>
    <div class="layui-row" >
        <form action="" class="layui-form layui-form-pane">
            <div class="layui-form-item">
                <%--<label class="layui-form-label" for="userName" style="background: transparent;border: none;background: transparent;border: none">用户名</label>--%>
                <div class="layui-input-block">
                    <i class="fa fa-user form-input-icon" ></i>
                    <input type="text" name="userName" id="userName" lay-verify="userName" autocomplete="off" placeholder="请输入用户名或邮箱" class="layui-input" style="background: transparent;border-bottom: white solid;border-top: none;border-left: none;border-right: none;padding-left: 40px">
                </div>
            </div>
            <div class="layui-form-item">
                <%--<label class="layui-form-label" for="userPassword" style="background: transparent;border: none;background: transparent;border: none">密码</label>--%>
                <div class="layui-input-block">
                    <i class="fa fa-lock form-input-icon" ></i>
                    <input type="password" name="userPassword" id="userPassword" lay-verify="userPassword" autocomplete="off" placeholder="请输入密码" class="layui-input" style="background: transparent;border-bottom: white solid;border-top: none;border-left: none;border-right: none;padding-left: 40px" >
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block" style="height: 30px">
                    <span id="forgetPass" ><a href="/toForgetPassword" style="color: #fff;">密码忘记</a></span>
                    <input type="checkbox" id="remember" name="like[write]" lay-skin="primary" title="记住密码" >
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block layui-col-xs12">
                    <input type="button" id="submit" value="登陆" class="layui-btn-lg layui-btn layui-btn-radius " style="width: 360px">
                </div>
                <div class="layui-input-block layui-col-xs12 ">
                    <span style="color: #FFFFFF;font-size: 10px;position: relative;left: 135px;top: 20px;">没有账号？<a href="/toRegister" style="color: #FFFFFF">去注册</a></span>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="js/layui.js"></script>
<script>
    layui.use('form', function () {
        var form = layui.form;
        form.render('checkbox');
    });
    $('#submit').on('click',function () {
        var userName = $('#userName').val();
        var userPassword = $('#userPassword').val();
        var isRemember = $('#remember').is(":checked");
        if(userName === "") {
            layer.tips('用户名或邮箱不能为空','#userName',{tipsMore:true});
        }
        if(userPassword === "") {
            layer.tips('密码不能为空','#userPassword',{tipsMore:true});
        }
        if (userName !=="" && userPassword !== "") {
            var pattern = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
            $.ajax({
                url:"/login",
                type:"post",
                data:{"userAccount" : userName, "userPassword" : userPassword},
                success:function (res) {
                    if(res === "error") {
                        layer.confirm('用户不存在或者密码错误，是否跳转注册？',{icon:3,title:'错误'},function () {
                            window.location.href="/toRegister";
                        })
                        $('#userPassword').val("")
                    }else{
                        if(isRemember == true) {
                            setCookie('username',userName,7);
                            setCookie('password',userPassword,7);
                        }else{
                            delCookie('username');
                            delCookie('password');
                        }
                        window.location.href="/index";
                    }
                }
            })
        }
    });
    //Cookie
    function setCookie(name,value,day) {
        var date = new Date();
        date.setDate(date.getDate()+day);
        document.cookie = name + "=" + escape(value) + ";expires=" + date;
    }
    function getCookie(name) {
        var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
        if (arr != null) {
            console.log(arr)
            return unescape(arr[2]);

        }
        return null;
    }
    function delCookie(name){
        setCookie(name,"",-1);
    }
    $(document).ready(function(){
        var username = getCookie('username'),
            password = getCookie('password');
        if(username === "" || username === undefined || username === null){
            $('#userName').val("");
            $('#userPassword').val("");
            $('#remember').prop('checked',false);
        }else {
            $('#userName').val(username);
            $('#userPassword').val(password);
            $('#remember').prop('checked',true);
        }
    })
</script>
</body>
</html>
