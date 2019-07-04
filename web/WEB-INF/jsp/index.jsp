<%--
  Created by IntelliJ IDEA.
  User: 15700
  Date: 2019/4/13
  Time: 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
</head>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<link href="https://cdn.bootcss.com/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
<link rel="stylesheet" href="../../css/sweetalert.css">
<%--<script src="../../js/jquery-min.js"></script>--%>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="js/css/layui.css">
<script src="../../js/sweetalert.min.js"></script>
<script type="text/template">
    <tr id="{id}">
        <td>{billCode}</td>
        <td>{productName}</td>
        <td>{proName}</td>
        <td>{totalPrice}</td>
        <td>{isPayment}</td>
        <td>{creationDate}</td>
        <td><i class="fa fa-times-circle" style="color: red;font-size: 2em;cursor:pointer" onclick="del_bill({id})"></i></td>
    </tr>
</script>
<style>
    .head-icon{
        display: block;
        width: 100px;
        height: 100px;
        position: relative;
        left: 0;
        top: 0;
        border: 2px #000 solid;
        border-radius: 50%;
        overflow: hidden;
        background: url("${sessionScope.user.userIcon}") no-repeat center center;
        background-size:100% 100% ;
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
        width: 60px;
        height: 60px;
        outline: none;
        top: 0;
        left: 41%;
        opacity: 0;
        border-radius: 50%;
        background: transparent;
        filter:alpha(opacity=0);
    }
</style>
<body>
<div class="modal fade in" id="edit_bill" data-toggle="modal" tabindex="-1" role="dialog" aria-labelledby="edit_billLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="edit_billLabel">修改订单</h4>
            </div>
            <div class="modal-body">
                <form action="/addBill" id="addBillForm">
                    <div class="form-group">
                        <label for="productName" class="control-label">请选择商品：</label>
                        <select name="productName" id="productName" class="form-control" onchange="getOption(this.options[this.options.selectedIndex].value)">

                        </select>
                    </div>
                    <div class="form-group">
                        <label for="price" class="control-label">价格</label>
                        <div class="form-control text-left">
                            ￥<span id="price"></span>.00
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="providerName" class="control-label">供应商：</label>
                        <select name="providerNme" id="providerName" class="form-control">

                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">数量</label>
                        <div class="form-control">
                            <i class="col-sm-9"></i>
                            <i class="fa fa-plus col-sm-1" style="color: blue;font-size: 1.5em;cursor: pointer;" id="add"></i>
                            <span id="count" class="col-sm-1">0</span>
                            <i class="fa fa-minus col-sm-1" style="color: blue;font-size: 1.5em;cursor: pointer;" id="minus"></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="totalPrice" class="control-label">总价格</label>
                        <div class="form-control text-left">
                            ￥<span id="totalPrice"></span>.00
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-default" id="submit" onclick="submit_form()">提交</button>
            </div>
        </div>
    </div>
</div>
<%--用户修改--%>
<div class="modal fade in" id="edit_user" data-toggle="modal" tabindex="-1" role="dialog" aria-hidden="edit_userLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="edit_userLabel">用户修改</h4>
            </div>
            <div class="modal-body">
                <form action="" class="layui-form layui-form-pane" enctype="multipart/form-data">
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <img src="${sessionScope.user.userIcon}" class="file-box" id="img">
                            <input type="file" value="headIcon" name="file" class="file-btn" id="userIcon" multiple>
                            </img>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">用户名</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" name="userName" id="userName">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">旧密码</label>
                        <div class="layui-input-block">
                            <input type="password" class="layui-input" name="userPassword" id="userPassword">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">新密码</label>
                        <div class="layui-input-block">
                            <input type="password" class="layui-input" name="newPassword" id="newPassword" onblur="checkUserPassword()">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">新密码确认</label>
                        <div class="layui-input-block">
                            <input type="password" class="layui-input" name="newPasswordConfirm" id="newPasswordConfirm" onblur="checkUserPasswordConfirm()">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">邮箱</label>
                        <div class="layui-input-block">
                            <input type="email" class="layui-input" name="email" id="email" onblur="checkUserEmail()">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">出生日期</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" name="birthday" id="birthday">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" >性别</label>
                        <div class="layui-input-block">
                            <input type="radio" name="sex" value="1" title="男"  id="man">
                            <input type="radio" name="sex" value="2" title="女" id="female">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="editUser_submit" onclick="userEdit_submit()">提交</button>
            </div>
        </div>
    </div>
</div>
<%--订单增加modal--%>
<div class="modal fade in" id="addBill" data-toggle="modal" tabindex="-1" role="dialog" aria-hidden="add_billLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="add_billLabel">增加订单</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="option_productName" class="control-label">请选择商品：</label>
                        <select name="option_productName" id="option_productName" class="form-control" onchange="form_optionChange(this.options[this.options.selectedIndex].value)">

                        </select>
                    </div>
                    <div class="form-group">
                        <label for="price" class="control-label">价格</label>
                        <div class="form-control text-left">
                            ￥<span id="form_price"></span>.00
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="form_providerName">供应商名</label>
                        <input type="text" id="form_providerName" name="form_providerName" class="form-control" placeholder="请输入供应商名">
                    </div>
                    <div class="form-group">
                        <label for="form_productCount">购买数量</label>
                        <input type="text" id="form_productCount" name="form_productCount" class="form-control" placeholder="请输入购买数量" oninput="change_form_productCount()">
                    </div>
                    <div class="form-group">
                        <label for="totalPrice" class="control-label">总价格</label>
                        <div class="form-control text-left">
                            ￥<span id="form_totalPrice"></span>.00
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="addBill_submit" onclick="addBill_submit()">提交</button>
            </div>
        </div>
    </div>
</div>
<%--容器--%>
<div class="container">
    <div class="row">
        <div class="col-sm-12 text-center">
            <div class="panel">
                <div class="panel-heading">
                    <span class="head-icon" data-toggle="modal" data-target="#edit_user" ></span>
                    <h3 class="panel-title inline" style="display: inline-block; position: relative;left: 0; top: -50px;">欢迎${sessionScope.user.userName}</h3>
                    <i class="fa fa-sign-out" aria-hidden="true" style="font-size: 2em;cursor: pointer;position: absolute; right:5%;top: 10%;" id="logout"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="panel panel-primary ">
                <div class="panel-heading">
                    <h3>订单表的查询</h3>
                </div>
                <div class="panel-heading">
                    <form action="#" class="form-inline">
                        <input type="text" id="keyword" class="form-control col-offset-8" placeholder="请输入搜索关键字">
                        <input type="button" id="search" class="btn btn-primary" value="搜索">
                    </form>
                </div>
                <div class="panel-body">
                    <i data-toggle="modal" data-target="#addBill" class="fa fa-plus" style="cursor: pointer;color: #0c5460;font-size: 2em"></i>
                    <i data-toggle="modal" data-target="#edit_bill" class="fa fa-edit" style="color: blue;font-size: 2em;cursor:pointer" ></i>
                    <table class="table table-striped" id="order">
                        <thead>
                        <tr>
                            <td>订单编码</td>
                            <td>商品名称</td>
                            <td>供应商名称</td>
                            <td>账单金额</td>
                            <td>是否付款</td>
                            <td>创建时间</td>
                        </tr>
                        </thead>
                        <tbody id="order-data">
                        </tbody>
                    </table>
                    <div id="bottom" style="width:100%;height:50px;">
                        <div id="page_Info" style="width:50%;height:50px;line-height: 50px;float:left;"></div>
                        <div id="page_nav" style="width:50%;height:50px;line-height: 50px;float: left;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="js/layui.js"></script>
<script>
    var layui_form;
    layui.use(['layer', 'form','element','upload','table','laydate'], function () {
        var form=layui.form,
            laydate=layui.laydate;
        layui_form=form;
        laydate.render({
            elem:'#birthday'
        });
    });

    //模板添加数据
    function templateToView(data) {
        var html = $('script[type="text/template"]').html();//模板代码
        var arr=[];
        $("#order-data").html("");//清空tbody
        $.each(data, function (index, object) {
            arr.push(formatTemplate(object, html));
        });
        $("#order-data").append(arr.join("，"));
    }
    function formatTemplate(object, tmpl) {
        //m1 匹配到的字符{W} m2 字符的内容 W
        return tmpl.replace(/{(\w+)}/g,function (m1, m2, m3) {
            if(!m2){
                return "";
            }
            if(m2 === "creationDate"){
                return ChangeDateFormat(object[m2]);
            }
            if (m2 === "isPayment") {
                return (object[m2] === 2 ? "未支付" : "已支付");
            }
            if (m2 === "totalPrice") {
                return "￥"+object[m2]+".00";
            }
            return object[m2];
        })
    }
    //时间格式
    function ChangeDateFormat(cellval) {
        var date = new Date(parseInt(cellval, 10));
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        return date.getFullYear() + "-" + month + "-" + currentDate;
    }
    //根据条件查询
    function searchByCondition() {
        var keyword = $("#keyword").val();
        if(keyword!=="" || keyword !==undefined){
            $.ajax({
                url:"/getTest",
                type:"post",
                data:{"productName":keyword,"proName":null},
                success:function (data) {
                    templateToView(data.list);
                    makePage(data);
                    build_page_nav(data);
                }
            });
        }
    }
    $(document).ready(function () {
        //初始化获取所有订单
        getBillList();
        $('#search').click(searchByCondition);
        $('#edit_bill').on("shown.bs.modal",getContent);
        $('#addBill').on("shown.bs.modal",ready_modal_addBill);
        $('#edit_user').on("shown.bs.modal",ready_modal_getUserInfo);

        $('#edit_bill').on("hidden.bs.modal",function () {
            $("#providerName").html("");
            $("#productName").html("");
            $("#price").html("");
            $("#count").html(0);
            $("#totalPrice").html("");
            $("#submit").click(submit_form)
        });
        $('#addBill').on("hidden.bs.modal",function () {
            $('#option_productName').html("");
            $('#form_price').html("");
            $('#form_providerName').val("");
            $("#form_productCount").val(1);
            $('#form_totalPrice').html("");
        });
        $('#edit_user').on("hidden.bs.modal",function () {
            $('#userName').val()
            $('#userPassword').val("");
            $('#newPassword').val("");
            $("#newPasswordConfirm").val("");
            $('#email').val("");
            $('#birthday').val("");
        });
        $('#add').click(add);
        $('#minus').click(minus);
        //head
    });
    //删除订单根据id
    function del_bill(id) {
        sweetAlert({
            title:"是否删除",
            text:"你将无法更改!",
            type:"warning",
            showCancelButton:true,
            confirmButtonColor:"#dd6b55",
            closeOnConfirm:false

        },function () {
            $.ajax({
                url:"/deleteBillById",
                type:"post",
                data:{"id":id},
                success:function (data) {
                    if(data==="1"){
                        sweetAlert("删除","你的订单应删除","success")
                    }
                    getBillList();
                }
            })
        })
    }
    //为option添加数据
    function toOptionData(data,id) {
        var option="";
        for (var i=0; i<data.length; i++) {
            option+="<option value='"+ data[i]+"'>"+data[i]+"</option>";
        }
        $(id).append(option);
    }
    //获取供应商名字
    function getProverNameByproductName(productName) {
        $.ajax({
            url:"/getProductName",
            type:"post",
            data:{"productName":productName},
            success:function (data) {

                var proName=[];
                proName.push(data);
                $("#providerName").html("");
                toOptionData(proName,"#providerName");
            }
        })
    }
    //为模态框添加数据
    var price={};
    function getContent() {
        var productNames=[],providerNames=[],prices={};
       $.ajax({
           url:"/getList",
           type:"post",
           success:function (data) {
               for(var i=0; i<data.length; i++){
                   var bill = data[i];
                   productNames.push(bill['productName']);
                   providerNames.push(bill['proName']);
                   prices[bill['productName']]=Math.ceil(bill['totalPrice']/bill['productCount'])
               }
               //商品添加
               $("#providerName").html("");
               toOptionData(productNames,"#productName");
               price=prices;
               getProverNameByproductName(productNames[0]);
               $("#price").html("");
               $("#price").html(price[productNames[0]]);
               add();

           }
       });
    }
    //select改变事件
    function getOption(data) {
        getProverNameByproductName(data);
        $("#price").html("");
        $("#price").html(price[data]);
        $("#count").html("1");
        $("#totalPrice").html(price[data])
    }
    //数量的加减
    var count_span=$("#count");
    var bill_price=$("#price");
    var total_price=$("#totalPrice");
    function add() {
        var count=parseInt(count_span.html());
        var bill_p=parseInt(bill_price.html());
        count++;
        total_price.html(bill_p*count)
        count_span.html(count);
    }
    function minus() {
        var count=parseInt(count_span.html());
        var bill_p=parseInt(bill_price.html());
        if(count==1){

        }else{
            count--;
        }
        console.log(bill_p)
        total_price.html(bill_p*count)
        count_span.html(count);
    }

    //模态框的表单提交
    function submit_form() {
        var productName= $("#productName option:selected").text();
        var proName = $("#providerName option:selected").text();
        var allPrice = $("#totalPrice").html();
        var count = $("#count").html()
        $.ajax({
            url:"/updateBill",
            type:"post",
            data:{"productName":productName,"proName":proName,"totalPrice":allPrice,"productCount":count},
            success:function (data) {
                sweetAlert("修改成功","你的订单应修改成功","success");
                $("#edit_bill").modal('hide');
                $.ajax({
                    url:"/getList",
                    type:"post",
                    data:{"productName":productName,"proName":null},
                    success:function (data) {
                        templateToView(data);
                    }
                });
            }
        })
    }

    //处理增加订单.............................................................................
    function ready_modal_addBill() {
        var productNames=[],prices={};
        $.ajax({
            url:"/getList",
            type:"post",
            success:function (data) {
                for(var i=0; i<data.length; i++){
                    var bill = data[i];
                    productNames.push(bill['productName']);
                    prices[bill['productName']]=Math.ceil(bill['totalPrice']/bill['productCount'])
                }
                //商品添加
                $("#option_productName").html("");
                toOptionData(productNames,"#option_productName");
                price=prices;
                $("#form_price").html("");
                $("#form_productCount").val(1);
                $("#form_price").html(price[productNames[0]]);
                $("#form_totalPrice").html(price[productNames[0]]);
            }
        });
    }
    //option改变事件
    function form_optionChange(data) {
        $('#form_price').html("");
        $('#form_price').html(price[data]);
        $('#form_totalPrice').html(price[data])
    }
    //购买数量改变
    var form_productCount_dom =$("#form_productCount")
    function change_form_productCount() {
        var count =parseInt( form_productCount_dom.val());
        var total;
        if(count>0){

            total = count * parseInt($('#form_price').html());
            $('#form_totalPrice').html(total);
        }else{
            form_productCount_dom.val(1);
            $('#form_totalPrice').html($("#form_price").html());
        }

    }
    //订单增加form的提交
    function addBill_submit() {
        var productName= $("#option_productName option:selected").text();
        var providerName= $('#form_providerName').val();
        var productCount = $('#form_productCount').val();
        var totalPrice = $('#form_totalPrice').html();
        console.log(providerName)
        if(providerName===""||providerName===undefined){
            sweetAlert("错误","请输入供应商名","warning");
        } else{
            $.ajax({
                url:"/addBill",
                type:"post",
                data:{"productName":productName,"proName":providerName,"productCount":productCount,"totalPrice":totalPrice},
                success:function (data) {
                    sweetAlert("添加成功","你的订单添加成功","success");
                    $("#addBill").modal('hide');
                    $.ajax({
                        url:"/getList",
                        type:"post",
                        data:{"productName":productName,"proName":null},
                        success:function (data) {
                            templateToView(data);
                        }
                    });
                }
            })
        }
    }
    //登出
    $("#logout").on('click',function () {
        $.ajax({
            url:"/logout",
            type:"post",
            success:function (res) {
                if(res !== "error"){
                    window.location.href="/toLogin";
                }
            }
        })
    })
//    用户编辑..............................................................................................................
    //获取用户信息
    function ready_modal_getUserInfo() {
        $.ajax({
            url:"/getUserInfo",
            type:"post",
            success:function (res) {
                var msg = res.msg ;
                if(msg !== "未登录"){
                    $('#userName').val(msg['userName'])
                    $('#userPassword').val('');
                    $('#newPassword').val('');
                    $("#newPasswordConfirm").val('');
                    $('#email').val(msg['email']);
                    $('#birthday').val(ChangeDateFormat(msg['birthday']));
                    var sex = msg['gender'] ;
                    console.log(sex)
                    if(sex === 1){
                        $('#female').prop('checked',false)
                        $('#man').prop('checked',true)
                        layui_form.render()
                    }else{
                        console.log('female')
                        $('#man').prop('checked',false)
                        $('#female').prop('checked',true)
                        layui_form.render()
                    }


                }
            }
        })
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
    //头像设置
    $('#userIcon').change(function () {

        var $file = $(this),
            fileObj = $file[0],
            windowURL = window.URL || window.webkitURL,
            dataURL,
            $img = $('#img'),
            type = fileObj.files[0].type;
        type = type.substr(type.indexOf("/")+1,type.length)
        if(fileObj && fileObj.files&& fileObj.files[0]){
            if(type!="jpg"&&type!="gif"&&type!="jpeg"&& type!="png"){
                layer.tips("文件类型错误","#userIcon",{tipsMore:true})
                $img.attr('src',"${sessionScope.user.userIcon}");
                $file.val("")
            }else{
                dataURL = windowURL.createObjectURL(fileObj.files[0]);
                $img.attr('src',dataURL)
            }

        }else {
            if(type!="jpg"&&type!="gif"&&type!="jpeg"&& type!="png"){
                layer.tips("文件类型错误","#userIcon",{tipsMore:true})
                var imgObj = document.getElementById("img");
                imgObj.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src="${sessionScope.user.userIcon}";
                $file.val("")
            }else{
                dataURL = $file.val();
                var imgObj = document.getElementById("img");
                imgObj.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src=dataURL;
            }

        }
    });

    //检查密码符合要求
    function checkUserPassword() {
        var password = $('#newPassword').val();
        if(password === "" || password === undefined) {
        }else {
            var pattern = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
            if(!pattern.test(password)) {
                layer.tips('请输入密码与数字6到18组合','#newPassword',{tipsMore:true});
                $("#newPassword").val("");
            }else{
                if(password === $('#userPassword').val()){
                    tips('密码相同请重新输入','newPassword');
                    $('#newPassword').val("");
                }
            }
        }
        return false;
    }
    function checkUserPasswordConfirm() {
        var newPass = $('#newPassword').val(),
            confirmPass = $('#newPasswordConfirm').val();
        if(newPass === confirmPass || newPass === "" || confirmPass === ""){

        }else {
            tips('密码不一致','newPasswordConfirm')
            $('#newPasswordConfirm').val("");
        }
    }
    //提示
    function tips(msg,id) {
        layer.tips(msg,'#'+id,{tipsMore:true});
    }
    //用户提交
    function userEdit_submit() {
        var file = document.getElementById("userIcon").files[0],
            userName = $('#userName').val(),
            userPassword = $('#userPassword').val(),
            newPassword = $('#newPassword').val(),
            newPasswordConfirm = $('#newPasswordConfirm').val(),
            email = $('#email').val(),
            birthday = $('#birthday').val(),
            sex = $("input[type='radio']:checked").val(),
            form = new FormData();
        //user
        if(userName === "" || userName ===undefined){
            tips('用户明不能为空','userName');
            return;
        }else {
            form.append('userName',userName)
        }
        //password
        if (userPassword === ""|| userPassword === undefined){
            tips('请输入旧密码','userPassword');
            return ;
        } else{
            form.append('userPassword',userPassword)
        }
        if(newPassword === "" || newPassword === undefined){

        }else if(newPasswordConfirm ==="" || newPasswordConfirm === undefined) {
            tips('输入确认密码','newPasswordConfirm');
            return;
        }else if(newPassword === newPasswordConfirm){
            form.append('newPassword',newPassword);
            form.append('newPasswordConfirm',newPasswordConfirm);
        }else {
            tips('密码不一致','newPasswordConfirm')
            $('#newPasswordConfirm').val("");
            return;
        }
        //email
        if(email === "" || email === undefined) {
            tips('请输入邮箱','email');
            return;
        }else {
            form.append('email',email);
        }
        //birthday
        if(birthday === "" || email === undefined) {
            tips('请输入出生日期','birthday');
            return ;
        }else {
            form.append('birthday',birthday);
        }
        //sex
        form.append('gender',parseInt(sex));

        //file
        if(file === undefined){

        }else {
            var type = file.type;
            type= type.substr(type.indexOf("/")+1,type.length);
            if(type!="jpg"&&type!="gif"&&type!="jpeg"&& type!="png"){
                tips('格式不正确','userIcon')
                return ;
            }else {
                form.append('file',file);
            }
        }
        $.ajax({
            url:'/editUser',
            type:'post',
            data:form,
            processData:false,
            contentType:false,
            success:function (res) {
                var msg = res.msg;
                if(msg === "success"){
                    $("#edit_user").modal('hide');
                    sweetAlert({
                        title:"修改成功",
                        content:"修改成功，请重新登陆",
                        type:"success",
                        confirmButtonColor:"#47dd55",
                        closeOnConfirm:false,
                    },function (isConfirm) {
                        window.location.href ="/index"
                    })
                }else {
                    for(var key in msg){
                        tips(msg[key],key)
                        $('#'+key).val();
                    }
                }
            }
        });
        return ;
    }

    /**
     * 分页
     */
    function makePage(result){
        $("#page_Info").empty();
        var center=$("<center></center>").append("当前第"+result.pageNum+"页,总共"+result.pages+
            " 页,总"+result.total+" 条数记录");
        $("#page_Info").append(center);

    }
    function build_page_nav(result){
        $("#page_nav").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        var firstPage=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePage=$("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
        if(result.hasPreviousPage==false){
            firstPage.addClass("disabled");
            prePage.addClass("disabled");
        }else{
            //为元素添加点击事件
            firstPage.click(function(){
                to_Page(1);
            });
            prePage.click(function(){
                to_Page(result.pageNum-1);
            });
        }


        var nextPage=$("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        var lastPage=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.hasNextPage==false){
            nextPage.addClass("disabled");
            lastPage.addClass("disabled");
        }else{
            lastPage.click(function(){
                to_Page(result.pages);
            });
            nextPage.click(function(){
                to_Page(result.pageNum+1);
            });
        }


        ul.append(firstPage).append(prePage);
        $.each(result.navigatepageNums,function(index,item){
            var num=$("<li></li>").append($("<a></a>").append(item).attr("href","#"));
            if(result.pageNum==item){
                num.addClass("active");
            }
            num.click(function(){
                to_Page(item);
            });
            ul.append(num);
        });
        ul.append(nextPage).append(lastPage);
        var nav=$("<nav></nav>").addClass("Page navigation").append(ul);
        nav.appendTo("#page_nav");
    }
    function to_Page(pn){
        $.ajax({
            url:"/getTest",
            data:{"pn":pn},
            type:"post",
            success:function(result){
                templateToView(result.list)
                makePage(result);
                build_page_nav(result);
            }
        })
    }
    function getBillList(){
        $.ajax({
            url:"/getTest",
            type:"post",
            success:function (data) {
                templateToView(data.list)
                makePage(data);
                build_page_nav(data);
            }
        });
    }
</script>
</body>


</html>
