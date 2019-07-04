package com.zst.experiment_1.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;

public class MyAspect {
    public void before(JoinPoint joinPoint) {
        System.out.println("before：模拟权限控制");
        System.out.println(",目标对象："+joinPoint.getTarget()+", 被增强处理的方法： "+joinPoint.getSignature().getName());
    }
    public void afterReturning(JoinPoint joinPoint) {
        System.out.println("afterReturning：模拟删除文件");
        System.out.println(", 被增强处理的方法： "+joinPoint.getSignature().getName());
    }
    public Object around(ProceedingJoinPoint proceedingJoinPoint)throws Throwable {
        System.out.println("around start：执行目标方法前，模拟开启事务");
        Object obj = proceedingJoinPoint.proceed();
        System.out.println("around end，执行目标方法后，模拟关闭事务");
        return obj;
    }
    public void except(Throwable e){
        System.out.println("异常通知：程序执行异常" + e.getMessage());
    }
    public void after() {
        System.out.println("after：模拟释放资源");
    }
}
