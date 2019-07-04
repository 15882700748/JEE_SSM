<%--
  Created by IntelliJ IDEA.
  User: 15700
  Date: 2019/5/6
  Time: 19:03
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
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300" type="text/css" />
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

    @-webkit-keyframes rotate {
        from { -webkit-transform: rotate(0deg) }
        to { -webkit-transform: rotate(360deg) } }
    @-moz-keyframes rotate {
        from { -moz-transform: rotate(0deg) }
        to { -moz-transform: rotate(360deg) } }
    @-o-keyframes rotate {
        from { -o-transform: rotate(0deg) }
        to { -o-transform: rotate(360deg) } }
    @keyframes rotate {
        from { transform: rotate(0deg) }
        to { transform: rotate(360deg) } }

    @-webkit-keyframes fade {
        from { opacity: 1 }
        50% { opacity: 0 }
        to { opacity: 1 } }
    @-moz-keyframes fade {
        from { opacity: 1 }
        50% { opacity: 0 }
        to { opacity: 1 } }
    @-o-keyframes fade {
        from { opacity: 1 }
        50% { opacity: 0 }
        to { opacity: 1 } }
    @keyframes fade {
        from { opacity: 1 }
        50% { opacity: 0 }
        to { opacity: 1 } }

    /* CONTAINER */
    #loading {
        display: none;
        width: 150px;
        height: 150px;
        /* PRESENTATIONAL PURPOSES */
        margin: auto;
        position: absolute;
        top: 0; left: 0; bottom: 0; right: 0;
        /**/
        cursor: pointer;
        -webkit-user-select: none;
        -webkit-border-radius: 50%;
        -moz-border-radius: 50%;
        border-radius: 50%;
        -webkit-box-shadow: 0 0 0 6px #222,
        0 0 6px 10px #444;
        -moz-box-shadow: 0 0 0 6px #222,
        0 0 6px 10px #444;
        box-shadow: 0 0 0 6px #222,
        0 0 6px 10px #444
    }

    /* TEXT */
    #loading_content {
        background: #222;
        background: -webkit-linear-gradient(#222,#111);
        background: -moz-linear-gradient(#222,#111);
        background: -o-linear-gradient(#222,#111);
        background: linear-gradient(#222,#111);
        position: absolute;
        top: 5px;
        left: 5px;
        right: 5px;
        bottom: 5px;
        -webkit-border-radius: 50%;
        -moz-border-radius: 50%;
        border-radius: 50%;
        text-align: center;
        font: normal normal normal 12px/140px
        'Electrolize', Helvetica, Arial, sans-serif;
        color: #fff;
    }

    #loading_content span {
        vertical-align: middle;
        -webkit-animation: fade 1s linear infinite;
        -moz-animation: fade 1s linear infinite;
        -o-animation: fade 1s linear infinite;
        animation: fade 1s linear infinite
    }

    /* SPINNING GRADIENT */
    .ring {
        margin: 0 auto;
        border-radius: 110px;
        padding: 10px;
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        -webkit-animation: rotate 1s linear infinite;
        -moz-animation: rotate 1s linear infinite;
        -o-animation: rotate 1s linear infinite;
        animation: rotate 1s linear infinite
    }

    /* COLORS */
    .green {
        background: -webkit-linear-gradient(#bfff00,transparent,#bfff00);
        background: -moz-linear-gradient(#bfff00,transparent,#bfff00);
        background: -o-linear-gradient(#bfff00,transparent,#bfff00);
        background: linear-gradient(#bfff00,transparent,#bfff00)
    }

    .blue {
        background: -webkit-linear-gradient(#3cf,transparent,#3cf);
        background: -moz-linear-gradient(#3cf,transparent,#3cf);
        background: -o-linear-gradient(#3cf,transparent,#3cf);
        background: linear-gradient(#3cf,transparent,#3cf)
    }

    .red {
        background: -webkit-linear-gradient(#cd5c5c,transparent,#cd5c5c);
        background: -moz-linear-gradient(#cd5c5c,transparent,#cd5c5c);
        background: -o-linear-gradient(#cd5c5c,transparent,#cd5c5c);
        background: linear-gradient(#cd5c5c,transparent,#cd5c5c)
    }

    .purple {
        background: -webkit-linear-gradient(#e166e1,transparent,#e166e1);
        background: -moz-linear-gradient(#e166e1,transparent,#e166e1);
        background: -o-linear-gradient(#e166e1,transparent,#e166e1);
        background: linear-gradient(#e166e1,transparent,#e166e1)
    }
</style>
<body>
<div class="loading_container" id="loading">
    <div class='ring blue'></div>
    <div id="loading_content">
        <span>加载中，请稍后</span>
    </div>
</div>
<div class="layui-container" id="find" style="position: absolute;width: 500px;height: 300px;top: 50%; left: 45%;transform: translate(-50%,-45%)" >
    <div class="layui-row text-center" style="position: relative;width: 360px;height: auto;left: 110px;top: -50px;">
        <h1>密码找回</h1>
    </div>
    <div class="layui-row" >
        <form action="" class="layui-form layui-form-pane">
            <div class="layui-form-item">
                <%--<label class="layui-form-label" for="userName" style="background: transparent;border: none;background: transparent;border: none">用户名</label>--%>
                <div class="layui-input-block">
                    <i class="fa fa-envelope-o form-input-icon" ></i>
                    <input type="email" name="email" id="email" lay-verify="email" autocomplete="off" placeholder="请输入邮箱" class="layui-input" style="background: transparent;border-bottom: white solid;border-top: none;border-left: none;border-right: none;padding-left: 40px">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block layui-col-xs12">
                    <input type="button" id="submit" value="找回" class="layui-btn-lg layui-btn layui-btn-radius " style="width: 360px">
                </div>
                <div class="layui-input-block layui-col-xs12 ">
                    <span style="color: #FFFFFF;font-size: 10px;position: relative;left: 156px;top: 20px;"><a href="/toLogin" style="color: #FFFFFF">返回登陆</a></span>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="js/layui.js"></script>
<script>
    layui.use('form', function () {
       var form=layui.form;
    });
    $('#submit').on('click',function () {
        var email = $('#email').val();
        var pattern = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
        if(email === "" || email === undefined){
            layer.tips('邮箱为空','#email',{tipsMore:true});
        }else if(!pattern.test(email)) {
            layer.tips('请输入正确的邮件格式','#email',{tipsMore:true});
            $("#email").val("");
        }else{
            $('#loading').show()
            $('#find').hide();
            $.ajax({
                url:'/forgetPassword',
                type:'post',
                data:{"email":email},
                success:function (res) {
                    var msg = res.msg;
                    $('#loading').hide();
                    $('#find').show();
                    if(msg !=="用户不存在"){
                        layer.confirm(msg,{icon:3,title:'错误'},function () {
                            window.location.href = "/toLogin";
                        })
                    }else {
                        layer.tips(msg,'#email',{tipsMore:true});
                    }
                }
            })
        }
    })
</script>
</body>
</html>
