package com.hxhk.util.spring;

import org.apache.shiro.SecurityUtils;

import com.hxhk.security.entity.main.User;
import com.hxhk.util.constant.Constant;

public class SpringUtil {
	/**
	 * 获得当前登录用户
	 * @return User
	 */
	public static User getCurrentUser(){
		return (User) SecurityUtils.getSubject().getSession(true).getAttribute(Constant.CURRENT_USER);
	}
}
