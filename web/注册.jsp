<%--
  Created by IntelliJ IDEA.
  User: 15700
  Date: 2019/4/5
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
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
          color: rgb(253, 251, 255);
          background: linear-gradient(-45deg, #EE7752, #E73C7E, #23A6D5, #23D5AB);
          background-size: 400% 400%;
          -webkit-animation: Gradient 15s ease infinite;
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
      input::-webkit-input-placeholder {
          /* placeholder颜色  */
          color: #e3eef9;
          /* placeholder字体大小  */
          font-size: 14px;!important;
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
      #eye{
          position: relative;
          left: 330px;
          top: 25px;
          width: 14px;
          height: 14px;
          cursor: pointer;
          display: none;
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
      .file-box {
          display: inline-block;
          position: relative;
          overflow: hidden;
          background: #fff;
          left: 41%;
          top: 0;
          width: 60px;
          height: 60px;
          border-radius: 50%;
      }
      .file-btn {
          position: absolute;
          display: inline-block;
          width: 100%;
          height: 100%;
          outline: none;
          top: 0;
          left: 0;
          opacity: 0;
          background: transparent;
          filter:alpha(opacity=0);
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
          position: absolute;
          top: 44%; left: 47%;
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
  <div class="layui-container" style="position: absolute;width: 500px;height: 300px;top: 40%; left: 45%;transform: translate(-40%,-45%)" id="login">
      <div class="layui-row text-center" style="position: relative;width: 360px;height: auto;left: 110px;top: -50px;">
          <h1>注册</h1>
      </div>
      <div class="layui-row">
          <form action="" method="post" class="layui-form layui-form-pane" enctype="multipart/form-data" id="form">
              <div class="layui-form-item">
                  <div class="layui-input-block">
                      <img src="" class="file-box" id="img">
                          <input type="file" value="headIcon" name="file" class="file-btn" id="userIcon" multiple>
                      </img>
                  </div>
              </div>
              <div class="layui-form-item">
                  <%--<label class="layui-form-label" for="userName" style="background: transparent;border: none;background: transparent;border: none">用户名</label>--%>
                  <div class="layui-input-block">
                      <i class="fa fa-user form-input-icon" ></i>
                      <input type="text" name="userName" id="userName" lay-verify="userName" autocomplete="off" placeholder="请输入用户名" class="layui-input" oninput="checkUserIsExist()"  style="background: transparent;border-bottom: white solid;border-top: none;border-left: none;border-right: none;padding-left: 40px">
                  </div>
              </div>
              <div class="layui-form-item" style="height: 43px">
                  <%--<label class="layui-form-label" for="userPassword" style="background: transparent;border: none">密码</label>--%>
                  <div class="layui-input-block">
                      <div id="eye">
                          <i class="fa fa-eye"></i>
                      </div>
                      <i class="fa fa-lock form-input-icon" ></i>
                      <input type="password" name="userPassword" id="userPassword" lay-verify="userPassword" autocomplete="off" placeholder="请输入密码" class="layui-input" onblur="checkUserPassword()"  style="background: transparent;border-bottom: white solid;border-top: none;border-left: none;border-right: none;padding-left: 40px">
                  </div>
              </div>
              <div class="layui-form-item">
                  <%--<label class="layui-form-label" for="userName" style="background: transparent;border: none;background: transparent;border: none">用户名</label>--%>
                  <div class="layui-input-block">
                      <i class="fa fa-envelope-o form-input-icon" ></i>
                      <input type="email" name="userName" id="email" lay-verify="email" autocomplete="off" placeholder="请输入邮箱" class="layui-input" onblur="checkUserEmail()"  style="background: transparent;border-bottom: white solid;border-top: none;border-left: none;border-right: none;padding-left: 40px">
                  </div>
              </div>
              <div class="layui-form-item">
                  <%--<label for="phone" class="layui-form-label" style="background: transparent;border: none">手机号</label>--%>
                  <div class="layui-input-block">
                      <i class="fa fa-phone form-input-icon" ></i>
                      <input type="tel" name="phone" id="phone" lay-verify="phone" autocomplete="off" placeholder="请输入电话号" class="layui-input"  style="background: transparent;border-bottom: white solid;border-top: none;border-left: none;border-right: none;padding-left: 40px">
                  </div>
              </div>
              <div class="layui-form-item">
                  <%--<label class="layui-form-label" style="background: transparent;border: none">性别</label>--%>
                  <div class="layui-input-block">
                      <input type="radio" name="sex" value="1" title="男" checked>
                      <input type="radio" name="sex" value="2" title="女">
                  </div>
              </div>
              <div class="layui-form-item">
                  <%--<label for="birthday" class="layui-form-label" style="background: transparent;border: none">出生日期</label>--%>
                  <div class="layui-input-block">
                      <i class="fa fa-birthday-cake form-input-icon" ></i>
                      <input type="text" class="layui-input" name="birthday" id="birthday" autocomplete="off"  style="background: transparent;border-bottom: white solid;border-top: none;border-left: none;border-right: none;padding-left: 40px">
                  </div>
              </div>
              <div class="layui-form-item">
                  <div class="layui-input-block layui-col-xs12">
                      <input type="button" id="submit" value="注册" class="layui-btn-lg layui-btn layui-btn-radius " style="width: 360px" >
                  </div>
                  <div class="layui-input-block layui-col-xs12 ">
                      <span style="color: #FFFFFF;font-size: 10px;position: relative;left: 135px;top: 20px;" >已有账号，<a href="/toLogin" style="color: #FFFFFF">去登陆</a></span>
                  </div>
              </div>
          </form>
      </div>
  </div>
  <script src="js/layui.js"></script>
  <script>
      layui.use(['layer', 'form','element','upload','table','laydate'], function(){
          var layer = layui.layer,
              form = layui.form,
              upload= layui.upload,
              table = layui.table,
              laydate = layui.laydate;
          //upload
          upload.render({
              elem:"#uploadDemo",
              url:"",
              done:function (res) {
                  layer.msg(res);
              }
          });
          //table
          table.render({
              elem:"#demo",//
              height:480,
              url:'/getList',
              title:'订单表',
              page:true,
              toolbar:'default',//开启表格头部工具栏区域
              totalRow:true,
              skin:'row',
              cols:[[
                  {type: 'checkbox', fixed: 'left'},
                  {field:'id',title:'ID',width:80,sort:true,fixed:'left',totalRowText:'合计', align:'center'},
                  {field:'billCode',title:'billCode',sort:true,width:150,edit:'text', align:'center'},
                  {field:'productName',title:'productName',sort:true,width:150,edit:'text', align:'center'},
                  {field:'productDesc',title:'productDesc',sort:true,width:150,edit:'text', align:'center'},
                  {field:'productCount',title:'productCount',sort:true,width:150,edit:'text', align:'center'},
                  {field:'totalPrice',title:'totalPrice',sort:true,width:150,edit:'text', align:'center'},
                  {field:'creationDate',title:'creationDate',sort:true,width:150,edit:'text', align:'center'},
                  {field:'isPayment',title:'isPayment',sort:true,width:150,edit:'text', align:'center'}
              ]],
              response:{
                statusCode:200
              },
              parseData:function (res) {
                  for (var i=0; i<res.length;i++) {
                      res[i]['creationDate']=ChangeDateFormat(res[i]['creationDate']);
                      res[i]['isPayment'] = res['isPayment'] === "1" ? "未支付" : "已支付";
                      res[i]['productCount'] += res[i]['productUnit'];
                      res[i]['totalPrice'] = "￥"+res[i]['totalPrice']+".00"
                  }
                  return  {"code": 200, //解析接口状态
                      "msg": "", //解析提示文本
                      "count": res.length, //解析数据长度
                      "data": res }//解析数据列表;
              }
          });
          table.on('toolbar(test)',function (obj) {
              var checkStatus = table.checkStatus(obj.config.id),
                  data = checkStatus.data;
              switch (obj.event) {
                  case 'add' :
                      layer.msg('add');
                      break;
                  case 'update' :
                      if(data.length === 0) {
                          layer.msg("请选择一行")
                      }else if(data.length > 1) {
                          layer.msg("只能同时编辑一个");
                      }else {
                          layer.alert('edit[id]'+checkStatus.data[0].id);
                      }
                      break;
                  case 'delete' :
                      if(data.length === 0) {
                          layer.msg('请选择一行');
                      }else{
                          layer.msg('delete');
                      }
                      break;
              }
          })

          //birthday select
          laydate.render({
              elem:'#birthday'
          });
      });
      function ChangeDateFormat(cellval) {
          var date = new Date(parseInt(cellval, 10));
          var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
          var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
          return date.getFullYear() + "-" + month + "-" + currentDate;
      }
      var flage_userName = false,
          flage_userPassword = false,
          flage_userPhone = false,
          flage_userBirthday = false;
      //submit event
      function submit_user() {
          var username = $('#userName').val(),
              password = $('#userPassword').val(),
              phone = $('#phone').val(),
              sex = $("input[type='radio']:checked").val(),
              date = $('#birthday').val(),
              file = document.getElementById("userIcon").files[0];
          var form = new FormData( $('#form'));
          form.append('userName',username)
          form.append('userPassword',password)
          form.append('phone',phone)
          form.append('gender',parseInt(sex))
          form.append('birthday',date)
          form.append('file',file);
          form.append('email',$('#email').val());
          $('#loading').show();
          $('#login').hide();
          $.ajax({
              url:'/register',
              type:'post',
              // data:{"userName":username,"userPassword":password,"phone":phone,"gender":parseInt(sex),"birthday":date},
              data:form,
              processData:false,
              contentType:false,
              success:function (res) {
                  $('#loading').hide();
                  $('#login').show();

                  if(res.msg !== "success") {
                      res = res.msg;
                      for (var i =0; i<res.length; i++) {
                          layer.tips(res[i]["defaultMessage"],'#'+res[i]['field'],{tipsMore:true});
                      }
                      if(date === "" || date ===undefined) {
                          layer.tips("请输入时间",'#birthday',{tipsMore:true});
                      }
                  }else{
                      window.location.href="/index"
                  }
              }
          })
      }
      $('#submit').on('click',submit_user);
      // $('#submit').on('mouseover',function () {
      //     var disabled = $('#submit').hasClass('layui-btn-disabled');
      //     if(disabled){
      //         $('#submit').unbind('click');
      //     }else{
      //         $('#submit').on('click',submit_user)
      //     }
      // });
      //检查用户是否存在
      function checkUserIsExist() {
          var username = $('#userName').val();
          if(username ===undefined || username === ""){
              layer.tips('用户名不能为空','#userName',{tipsMore:true})
              $('#submit').addClass('layui-btn-disabled');
              $('#submit').unbind('click')
          }else {
              $.ajax({
                  url:'/checkUserIsExist',
                  type:'post',
                  data:{'userName':$('#userName').val()},
                  success:function (res) {
                      if (res === "1") {
                          layer.tips('用户名已存在','#userName',{tipsMore:true,color:'#fff'});
                          $('#submit').addClass('layui-btn-disabled')
                          $('#submit').unbind('click')
                      }else {
                          layer.tips('用户名可用','#userName',{tipsMore:true});
                          $('#submit').removeClass('layui-btn-disabled')
                          $('#submit').unbind('click')
                          $('#submit').bind('click',submit_user)
                          return true
                      }
                  }
              })
          }
          return false;
      }
      function checkUserPassword() {
          var password = $('#userPassword').val();
          if(password === "" || password === undefined) {
              layer.tips('密码不能为空','#userPassword',{tipsMore:true})
          }else {
              var pattern = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
              if(!pattern.test(password)) {
                  layer.tips('请输入密码与数字6到18组合','#userPassword',{tipsMore:true});
                  $("#userPassword").val("");
              }else{
                  return true;
              }
          }
          return false;
      }
      //检查用户邮箱格式
      function checkUserEmail(){
          var email = $('#email').val();
          if(email === "" || email === undefined) {
              layer.tips('邮箱不能为空','#email',{tipsMore:true})
          }else {
              var pattern = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
              if(!pattern.test(email)) {
                  layer.tips('请输入正确的邮件格式','#email',{tipsMore:true});
                  $("#email").val("");
              }else{
                  return true;
              }
          }
          return false;
      }
      $('#userIcon').change(function () {

          var $file = $(this),
              fileObj = $file[0],
              windowURL = window.URL || window.webkitURL,
              dataURL,
              $img = $('#img'),
              type = fileObj.files[0].type;
          type = type.substr(type.indexOf("/")+1,type.length)
          console.log(type)
          if(fileObj && fileObj.files&& fileObj.files[0]){
              if(type!="jpg"&&type!="gif"&&type!="jpeg"&& type!="png"){
                  layer.tips("文件类型错误","#userIcon",{tipsMore:true})
                  $('#img').attr('src',"https://up.enterdesk.com/edpic/4f/98/1c/4f981c0ec5605ff7c47092f0159cbf3a.jpg");
              }else{
                  dataURL = windowURL.createObjectURL(fileObj.files[0]);
                  $img.attr('src',dataURL)
              }

          }else {
              if(type!="jpg"&&type!="gif"&&type!="jpeg"&& type!="png"){
                  layer.tips("文件类型错误","#userIcon",{tipsMore:true})
                  $('#img').attr('src',"https://up.enterdesk.com/edpic/4f/98/1c/4f981c0ec5605ff7c47092f0159cbf3a.jpg");
              }else{
                  dataURL = $file.val();
                  var imgObj = document.getElementById("img");
                  imgObj.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                  imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src=dataURL
              }

          }
      })
      $(document).ready(function () {
          $('#img').attr('src',"https://up.enterdesk.com/edpic/4f/98/1c/4f981c0ec5605ff7c47092f0159cbf3a.jpg");
      })
  </script>
  </body>
</html>
