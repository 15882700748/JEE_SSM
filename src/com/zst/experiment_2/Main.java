package com.zst.experiment_2;


import com.zst.experiment_2.controller.UserController;
import com.zst.experiment_2.entity.Bill;
import com.zst.experiment_2.entity.Provider;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class Main {

    public static void main(String[] args){
        try{
            ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
            UserController userController = (UserController)context.getBean("userController");
            String s="之";
            List<Bill> bills = userController.getList(null,null,null);
            for (Bill bill : bills) {
                System.out.println(bill);
            }
            for (Bill bill : userController.getList("东北",null,null)) {
                System.out.println(bill);
            }
            System.out.println(".....................");
//            List<Provider> providers = userController.getProvider(1);
//            for (Provider p : providers) {
//                System.out.println(p);
//                if(p.getBills().size()>0) {
//                    for (Bill b:p.getBills()){
//                        System.out.println(b);
//                    }
//                }
//            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
