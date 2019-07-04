package com.zst.experiment_1;

import com.zst.experiment_1.controller.TestController;
import com.zst.experiment_1.dao.TestDao;
import com.zst.experiment_1.dao.TestDaoImpl;
import com.zst.experiment_1.user.ComplexUser;
import com.zst.experiment_1.user.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Main {
    public static void main(String[] args){
        ApplicationContext context = new ClassPathXmlApplicationContext( "applicationContext.xml");
        ComplexUser user1 = (ComplexUser)context.getBean("user1");
        ComplexUser user2 = (ComplexUser)context.getBean("user2");
        User user = (User)context.getBean("entity");
        TestController testController = (TestController)context.getBean("testController");
        System.out.println(user.getName());
        System.out.println(user1);
        System.out.println(user2);
        testController.save();
    }
}
