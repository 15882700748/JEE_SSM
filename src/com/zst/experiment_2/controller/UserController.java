package com.zst.experiment_2.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.deploy.net.HttpResponse;
import com.zst.experiment_2.dao.BillMapper;
import com.zst.experiment_2.dao.ProviderMapper;
import com.zst.experiment_2.dao.UserMapper;
import com.zst.experiment_2.entity.Bill;
import com.zst.experiment_2.entity.Provider;
import com.zst.experiment_2.entity.User;
import com.zst.experiment_2.util.SendMail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class UserController {

    @Autowired
    BillMapper billMapper;
    @Autowired
    ProviderMapper providerMapper;
    @Autowired
    UserMapper userMapper;


    private int width = 90;//定义图片的width
    private int height = 20;//定义图片的height
    private int codeCount = 4;//定义图片上显示验证码的个数
    private int xx = 15;
    private int fontHeight = 18;
    private int codeY = 16;
    char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
            'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
            'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

    @RequestMapping("/getList")
    @ResponseBody
    public List<Bill> getList(String productName, String  proName, Integer isPayment){
        return billMapper.getBillList(productName,proName,isPayment);
    }

    @RequestMapping("/getProvider")
    @ResponseBody
    public List<Provider> getProvider(Integer providerId){
        return providerMapper.getBillListByProviderId(providerId);
    }
    @RequestMapping("/index")
    public String index(){
        return "index";
    }
//    删除订单根据id
    @RequestMapping("/deleteBillById")
    @ResponseBody
    public String deleteBillById(long id){
        return billMapper.deleteByPrimaryKey(id)>0?"1":"0";
    }
    //根据产品名获取供应商
    @RequestMapping("/getProductName")
    @ResponseBody
    public List<String> getProviderName(String productName){

        return providerMapper.getProviderNames(productName);
    }

    //更新订单
    @RequestMapping("/updateBill")
    @ResponseBody
    public String updateBill(Bill bill){
        System.out.println(bill.getProductName());
        return billMapper.updateBill(bill)>0?"1":"0";
    }
    //添加订单
    @RequestMapping("/addBill")
    @ResponseBody
    @Transactional
    public String addBill(Bill bill){
        System.out.println(bill.getProName());
        Provider p= new Provider();
        Date date = new Date();
        p.setCreationDate(date);
        p.setProName(bill.getProName());
        p.setProAddress("四川理工");
        p.setProContact("15882700748");
        p.setProCode("sc_GYS005"+(int)Math.random()*100);
        providerMapper.insert(p);
        bill.setCreationDate(date);
        bill.setIsPayment(2);
        bill.setProviderId(Integer.parseInt(String.valueOf(p.getId())));
        bill.setBillCode("Bill_2016_"+(int)Math.random()*100);
        return billMapper.addBill(bill)>0?"1":"0";
    }

    //检测用户是否存在
    @ResponseBody
    @RequestMapping("/checkUserIsExist")
    public String checkUser(User user) {
        return userMapper.selectUser(user).size()>0 ? "1":"0";
    }
    //验证码
    @RequestMapping("/imgCode")
    @ResponseBody
    public void getimgCode(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        resp.setHeader("Pragma","No-cache");
        resp.setHeader("Cache-Control","No-cache");
        resp.setDateHeader("Expires",0);
        resp.setContentType("image/jpeg");
        BufferedImage buffImg = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);
//		Graphics2D gd = buffImg.createGraphics();
        //Graphics2D gd = (Graphics2D) buffImg.getGraphics();
        Graphics gd = buffImg.getGraphics();
        // 创建一个随机数生成器类
        Random random = new Random();
        // 将图像填充为白色
        gd.setColor(Color.WHITE);
        gd.fillRect(0, 0, width, height);

        // 创建字体，字体的大小应该根据图片的高度来定。
        Font font = new Font("Fixedsys", Font.BOLD, fontHeight);
        // 设置字体。
        gd.setFont(font);

        // 画边框。
        gd.setColor(Color.BLACK);
        gd.drawRect(0, 0, width - 1, height - 1);

        // 随机产生40条干扰线，使图象中的认证码不易被其它程序探测到。
        gd.setColor(Color.BLACK);
        for (int i = 0; i < 40; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            gd.drawLine(x, y, x + xl, y + yl);
        }

        // randomCode用于保存随机产生的验证码，以便用户登录后进行验证。
        StringBuffer randomCode = new StringBuffer();
        int red = 0, green = 0, blue = 0;

        // 随机产生codeCount数字的验证码。
        for (int i = 0; i < codeCount; i++) {
            // 得到随机产生的验证码数字。
            String code = String.valueOf(codeSequence[random.nextInt(36)]);
            // 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。
            red = random.nextInt(255);
            green = random.nextInt(255);
            blue = random.nextInt(255);

            // 用随机产生的颜色将验证码绘制到图像中。
            gd.setColor(new Color(red, green, blue));
            gd.drawString(code, (i + 1) * xx, codeY);

            // 将产生的四个随机数组合在一起。
            randomCode.append(code);
        }
        // 将四位数字的验证码保存到Session中。
        HttpSession session = req.getSession();
        System.out.print(randomCode);
        session.setAttribute("code", randomCode.toString());

        // 禁止图像缓存。
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setDateHeader("Expires", 0);

        resp.setContentType("image/jpeg");

        // 将图像输出到Servlet输出流中。
        ServletOutputStream sos = resp.getOutputStream();
        ImageIO.write(buffImg, "jpeg", sos);
        sos.close();
    }

    //登陆
    @RequestMapping("/toLogin")
    public String toLogin(){
        return "../../登陆";
    }
    @RequestMapping ("/login")
    @ResponseBody
    public String login(HttpSession session,User user,String userAccount) {
        String regEx = "^[a-z0-9]+([._\\\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$";
        Pattern pattern = Pattern.compile(regEx);
        Matcher matcher = pattern.matcher(userAccount);
        if (matcher.matches()) {
           user.setEmail(userAccount);
        }else {
            user.setUserName(userAccount);
        }
        if(userMapper.selectUser(user).size()>0){
            session.setAttribute("user",userMapper.selectUser(user).get(0));
            return "success";
        }
        return "error";
    }
    //注册
    @RequestMapping("/toRegister")
    public String toRegister(){
        return "../../注册";
    }

    @RequestMapping(value = "/register",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> register( @Valid User user, BindingResult result, MultipartFile file,HttpServletRequest request) throws Exception {
        Map<String,Object> map = new HashMap<>();
        List<ObjectError> lists ;
        if (result.hasErrors()) {
            lists = result.getAllErrors();
            map.put("msg",lists);
        }
        if(file !=null && !result.hasErrors()) {
            String basePath ;
            String originalFileName = file.getOriginalFilename();
            String newFileName = user.getUserName()+originalFileName.substring(originalFileName.indexOf("."));
            String type = originalFileName.substring(originalFileName.indexOf(".")+1,originalFileName.length());
            if ("gif".equals(type.toLowerCase()) || "png".equals(type.toLowerCase()) || "jpg".equals(type.toLowerCase())||"jpeg".equals(type.toLowerCase())){
                //获取项目路径
                ServletContext sc = request.getSession().getServletContext();
                String path = sc.getRealPath("/img")+"/";
                basePath = path;
                File temp = new File(basePath+newFileName);
                if(!temp.exists()) {
                    file.transferTo(temp);
                }
                //验证邮箱唯一
                User userEmail = new User();
                userEmail.setEmail(user.getEmail());
                if(userMapper.selectUser(userEmail).size()==0){
                    user.setUserIcon("/img/"+newFileName);
                    user.setCreatedBy(new Long(1));
                    user.setCreationDate(new Date());
                    user.setUserRole(1);
                    userMapper.insert(user);
                    map.put("msg","success");
                }else {
                    result.rejectValue("email","NotBlank","邮件已绑定");
                    lists=result.getAllErrors();
                    map.put("msg",lists);
                }

            }else{
                result.rejectValue("userIcon","NotBlank","图片类型错误");
                lists=result.getAllErrors();
                map.put("msg",lists);
            }
        }else if(file == null){
            result.rejectValue("userIcon","NotBlank","请选择头像");
            lists=result.getAllErrors();
            map.put("msg",lists);
        }
        return map;
    }
    //注销
    @RequestMapping("/logout")
    @ResponseBody
    public String logout(HttpServletRequest request){
        Object obj = request.getSession().getAttribute("user");

        if(obj!=null) {
            request.getSession().setAttribute("user",null);
        }
        System.out.println(obj);
        return "success";
    }

    //修改密码
    @RequestMapping("/toForgetPassword")
    public String toForgetPassword(){
        return "forgetPassword";
    }
    @RequestMapping("/forgetPassword")
    @ResponseBody
    public Map<String,Object> forgetPassword(User user){
        Map<String, Object> map = new HashMap<>();
        List<User>  userList = userMapper.selectUser(user);//用户名
        if(userList.size()==0){
            map.put("msg","用户不存在");
            return map;
        }
        User user1 = userMapper.selectUser(user).get(0);
        map.put("msg","密码找回成功请登录邮箱");
        SendMail mySendMai = new SendMail();
        mySendMai.sendMail(user1.getEmail(),"系统提示，您的密码为："+user1.getUserPassword());
        return map;
    }
//    用户信息编辑.................................................

//    获取用户的信息
    @RequestMapping("/getUserInfo")
    @ResponseBody
    public Map<String,Object> getUserInfo(HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();
        Object user = request.getSession().getAttribute("user");
        if(user == null) {
            map.put("msg","未登录");
        }else {
            map.put("msg",user);
        }
        return map;
    }

    //用户修改提交
    @RequestMapping("/editUser")
    @ResponseBody
    public Map<String,Object> editUser(User user, String newPassword, String newPasswordConfirm, MultipartFile file,HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> msgContent = new HashMap<>();
        boolean editedPass = false, editedName =  false;
        User updateUser = new User();
        User sessionUser = (User) request.getSession().getAttribute("user");
        //id
        updateUser.setId(sessionUser.getId());
        //userName
        if (!user.getUserName().equals(sessionUser.getUserName())) {
            User temp = new User();
            temp.setUserName(user.getUserName());
            if (userMapper.selectUser(temp).size() > 0) {
                msgContent.put("userName", "用户已存在");
                map.put("msg", msgContent);
                return map;
            } else {
                updateUser.setUserName(user.getUserName());
                editedName = true;
            }
        }
        //odlPassword
        if (!user.getUserPassword().equals(sessionUser.getUserPassword())) {
            msgContent.put("userPassword", "旧密码不正确");
            map.put("msg", msgContent);
            return map;
        }
        //newPassword
        if ("".equals(newPassword)|| newPassword == null || "".equals(newPasswordConfirm) || newPasswordConfirm == null) {
            System.out.println("没有修改密码");
        } else {
            if (newPassword.equals(newPasswordConfirm)) {
                updateUser.setUserPassword(newPassword);
                editedPass = true;
            } else {
                msgContent.put("userPassword", "新密码不正确");
                map.put("msg", msgContent);
                return map;
            }
        }
        //email
        if (user.getEmail().equals("") || user.getEmail() == null) {//空
            msgContent.put("email", "邮箱为空");
            map.put("msg", msgContent);
            return map;
        } else {
            String regEx = "^[a-z0-9]+([._\\\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$";
            Pattern pattern = Pattern.compile(regEx);
            Matcher matcher = pattern.matcher(user.getEmail());
            if (!matcher.matches()) {//格式
                msgContent.put("email", "邮箱格式不正确");
                map.put("msg", msgContent);
                return map;
            } else {
                User temp = new User();
                temp.setEmail(user.getEmail());
                if (user.getEmail().equals(sessionUser.getEmail())) {//自身

                } else if (userMapper.selectUser(temp).size() > 0) {//修改存在
                    msgContent.put("email", "邮箱已注册");
                    map.put("msg", msgContent);
                    return map;
                } else {
                    updateUser.setEmail(user.getEmail());
                }
            }
        }
        //birthday
        if (user.getBirthday().equals(sessionUser.getBirthday())) {

        } else {
            updateUser.setBirthday(user.getBirthday());
        }
        //sex
        updateUser.setGender(user.getGender());
        //file
        if (file != null) {
            String basePath;
            String originalFileName = file.getOriginalFilename();
            String newFileName = user.getUserName() + originalFileName.substring(originalFileName.indexOf("."));
            String type = originalFileName.substring(originalFileName.indexOf(".") + 1, originalFileName.length());
            if ("gif".equals(type.toLowerCase()) || "png".equals(type.toLowerCase()) || "jpg".equals(type.toLowerCase()) || "jpeg".equals(type.toLowerCase())) {
                //获取项目路径
                ServletContext sc = request.getSession().getServletContext();
                String path = sc.getRealPath("/img") + "/";
                basePath = path;
                File temp = new File(basePath + newFileName);

                if(editedName){//editedName && file !=null
                    String oldFileName = sessionUser.getUserName() + originalFileName.substring(originalFileName.indexOf("."));
                    File odlFile = new File(basePath+oldFileName);
                    if(!odlFile.delete()){
                        System.out.println("文件删除错误");
                    }
                    System.out.println("editedName ： " + editedName);
                    System.out.println("oldFileName : "+oldFileName);
                    System.out.println("newFileName : "+newFileName);
                }
                updateUser.setUserIcon("/img/"+newFileName);
                try {
                    file.transferTo(temp);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }else {
                msgContent.put("userIcon", "文件类型错误");
                map.put("msg", msgContent);
                return map;
            }
        }
//        if(!editedName){ //!editedName && file == null
//            String basePath;
//            String originalFileName = sessionUser.getUserIcon();
//            String newFileName = user.getUserName() + originalFileName.substring(originalFileName.indexOf("."));
//            String oldFileName = sessionUser.getUserName() + originalFileName.substring(originalFileName.indexOf("."));
//            ServletContext sc = request.getSession().getServletContext();
//            String path = sc.getRealPath("/img") + "/";
//            basePath = path;
//            File oldFile = new File(basePath + oldFileName);
//            System.out.println("editedName ： " + editedName);
//            System.out.println("oldFileName : "+oldFileName);
//            System.out.println("newFileName : "+newFileName);
//            File newFile = new File(basePath + newFileName);
//            if(!oldFile.renameTo(newFile)){
//                System.out.println("失败");
//            }
//            updateUser.setUserIcon("/img/"+newFileName);
//        }else if (editedName && file ==null){//editedName && file == null
//
//        }
        String basePath;
        String originalFileName = sessionUser.getUserIcon();
        String newFileName = user.getUserName() + originalFileName.substring(originalFileName.indexOf("."));
        String oldFileName = sessionUser.getUserName() + originalFileName.substring(originalFileName.indexOf("."));
        ServletContext sc = request.getSession().getServletContext();
        String path = sc.getRealPath("/img") + "/";
        basePath = path;
        File oldFile = new File(basePath + oldFileName);
        System.out.println("editedName ： " + editedName);
        System.out.println("oldFileName : "+oldFileName);
        System.out.println("newFileName : "+newFileName);
        File newFile = new File(basePath + newFileName);
        if(!oldFile.renameTo(newFile)){
            System.out.println("失败");
        }
        updateUser.setUserIcon("/img/"+newFileName);
        userMapper.updateByPrimaryKeySelective(updateUser);
        if(!editedPass){
            request.getSession().setAttribute("user",userMapper.selectUser(user).get(0));
        }else {
            request.getSession().setAttribute("user",null);
        }
        map.put("msg","success");
        return map;
    }
    @RequestMapping("/getTest")
    @ResponseBody
    public PageInfo<Bill> getList(@RequestParam(value = "pn", defaultValue="1") int pn,String productName, String  proName, Integer isPayment){
        PageHelper.startPage(pn,5);
        List<Bill> bills = billMapper.getBillList(productName,proName,isPayment);
        PageInfo<Bill> billPageInfo = new PageInfo<>(bills,5);
        return billPageInfo;
    }
}
