package com.hxhk.util.log.impl;

import java.lang.reflect.Field;

import org.aspectj.lang.JoinPoint;
import com.hxhk.util.constant.Constant;
import com.hxhk.util.log.ILogService;
import com.hxhk.util.spring.SpringUtil;


public class LogServiceImpl implements ILogService {

    @Override
    public void log() {
        System.out.println("前置通知*************Log*******************");
    }
    
    //有参无返回值的方法
    @Override
	public void logArg(JoinPoint point) {
    	 //此方法返回的是一个数组，数组中包括request以及ActionCofig等类对象
    	String method = point.getSignature().getName();
    	String user = SpringUtil.getCurrentUser().getUsername();
    	if(method.contains(Constant.DELETE)){
    		System.out.println(user+",删除操作");
    	}else if(method.contains(Constant.UPDATE)){
    		System.out.println(user+",修改操作");
    	}else if(method.contains(Constant.ADD) || method.contains(Constant.SAVE)){
    		System.out.println(user+",新增操作");
    	}else{
    		System.out.println(user+",查询操作");
    	}
        Object[] args = point.getArgs();
        System.out.println("目标参数列表：");
        if (args != null) {
            for (Object obj : args) {
            	if(obj instanceof Integer){
            		System.out.println(obj);
            	}else if(obj instanceof String){
            		System.out.println(obj);
            	}else{
            	Field[] fields = obj.getClass().getDeclaredFields();
            	for(Field f:fields ){
            		try {
            			f.setAccessible(true);
						System.out.println(f.getName() + ":" +f.get(obj));
						f.setAccessible(false);
					} catch (IllegalArgumentException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
            	}
            }
            }
            System.out.println();          
        }
    }

    //有参并有返回值的方法
    @Override
	public void logArgAndReturn(JoinPoint point, Object returnObj) {
        //此方法返回的是一个数组，数组中包括request以及ActionCofig等类对象
        Object[] args = point.getArgs();
        System.out.println("目标参数列表：");
        if (args != null) {
            for (Object obj : args) {
            	if(obj instanceof Integer){
            		System.out.println(obj + " int");
            	}else if(obj instanceof String){
            		System.out.println(obj + " String");
            	}else{
            	Field[] fields = obj.getClass().getDeclaredFields();
            	for(Field f:fields ){
            		try {
            			f.setAccessible(true);
						System.out.println(f.getName() + ":" +f.get(obj));
						f.setAccessible(false);
					} catch (IllegalArgumentException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
            	}
            }
            }
            System.out.println();
            System.out.println("执行结果是：" + returnObj);
        }
    }
}
