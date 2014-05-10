/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.controller.IndexController.java
 * Class:			IndexController
 * Date:			2012-8-2
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/
 
package com.hxhk.security.controller;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.hxhk.security.SecurityConstants;
import com.hxhk.security.entity.main.Module;
import com.hxhk.security.entity.main.User;
import com.hxhk.security.entity.main.UserRole;
import com.hxhk.security.service.ModuleService;
import com.hxhk.security.service.UserRoleService;
import com.hxhk.security.service.UserService;
import com.hxhk.security.shiro.ShiroDbRealm;
import com.hxhk.util.dwz.AjaxObject;

/** 
 * 	
 * @author 	<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version  1.1.0
 * @since   2012-8-2 下午5:45:57 
 */
@Controller
@RequestMapping("/management/index")
public class IndexController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserRoleService userRoleService;
	
	@Autowired
	private ModuleService moduleService;
	
	private static final String INDEX = "security/views/management/index/index";
	private static final String UPDATE_PASSWORD = "security/views/management/index/updatePwd";
	private static final String UPDATE_BASE = "security/views/management/index/updateBase";
	
	@RequiresAuthentication 
	@RequestMapping(value="", method=RequestMethod.GET)
	public String index(HttpServletRequest request) {
		Subject subject = SecurityUtils.getSubject();
		ShiroDbRealm.ShiroUser shiroUser = (ShiroDbRealm.ShiroUser)subject.getPrincipal();
		
		//User user = userService.get(shiroUser.getLoginName());
		List<UserRole> userRoles = userRoleService.find(shiroUser.getId());
		shiroUser.getUser().setUserRoles(userRoles);
		
		Module menuModule = getMenuModule(userRoles);

		// 这个是放入user还是shiroUser呢？
		request.getSession().setAttribute(SecurityConstants.LOGIN_USER, shiroUser.getUser());
		request.setAttribute("menuModule", menuModule);
		return INDEX;
	}
	
	private Module getMenuModule(List<UserRole> userRoles) {
		// 得到所有权限
		Set<String> permissionSet = Sets.newHashSet();
		for (UserRole userRole : userRoles) {
			Set<String> tmp = Sets.newHashSet(userRole.getRole().getPermissionList());
			permissionSet.addAll(tmp);
		}
		
		// 组装菜单,只获取二级菜单
		//Module rootModule = moduleService.get(1L);
		Module rootModule = moduleService.getTree();
		List<Module> list1 = Lists.newArrayList();
		for (Module m1 : rootModule.getChildren()) {
			// 只加入拥有view权限的Module,目前仅支持四级菜单
			if (permissionSet.contains(m1.getSn() + ":" + SecurityConstants.OPERATION_VIEW)) {
				List<Module> list2 = Lists.newArrayList();
				for (Module m2 : m1.getChildren()) {
					if (permissionSet.contains(m2.getSn() + ":" + SecurityConstants.OPERATION_VIEW)) {
						List<Module> list3 = Lists.newArrayList();
						for (Module m3 : m2.getChildren()) {
							if (permissionSet.contains(m3.getSn() + ":" + SecurityConstants.OPERATION_VIEW)) {
								List<Module> list4 = Lists.newArrayList();
								for (Module m4 : m3.getChildren()) {
									if (permissionSet.contains(m4.getSn() + ":" + SecurityConstants.OPERATION_VIEW)) {
										list4.add(m4);
									}
								}
								m3.setChildren(list4);
								list3.add(m3);
							}
						}
						m2.setChildren(list3);
						list2.add(m2);
					}
				}
				m1.setChildren(list2);
				list1.add(m1);
			}
		}
		rootModule.setChildren(list1);
		
		return rootModule;
	}
	
	@RequestMapping(value="/updatePwd", method=RequestMethod.GET)
	public String updatePassword() {
		return UPDATE_PASSWORD;
	}
	
	@RequestMapping(value="/updatePwd", method=RequestMethod.POST)
	public @ResponseBody String updatePassword(HttpServletRequest request, String oldPassword, 
			String plainPassword, String rPassword) {
		User user = (User)request.getSession().getAttribute(SecurityConstants.LOGIN_USER);
		
		if (plainPassword.equals(rPassword)) {
			user.setPlainPassword(plainPassword);
			userService.update(user);
			
			AjaxObject ajaxObject = new AjaxObject("密码修改成功！");
			return ajaxObject.toString();
		}
		
		AjaxObject ajaxObject = new AjaxObject("密码修改失败！");
		ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
		ajaxObject.setCallbackType("");
		return ajaxObject.toString();
	}
	
	@RequestMapping(value="/updateBase", method=RequestMethod.GET)
	public String preUpdate() {
		return UPDATE_BASE;
	}
	
	@RequestMapping(value="/updateBase", method=RequestMethod.POST)
	public @ResponseBody String update(User user, HttpServletRequest request) {
		User loginUser = (User)request.getSession().getAttribute(SecurityConstants.LOGIN_USER);
		
		loginUser.setPhone(user.getPhone());
		loginUser.setEmail(user.getEmail());

		userService.update(loginUser);

		AjaxObject ajaxObject = new AjaxObject("详细信息修改成功！");
		return ajaxObject.toString();
	}
}
