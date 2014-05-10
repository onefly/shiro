/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.controller.UserController.java
 * Class:			UserController
 * Date:			2012-8-7
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/
 
package com.hxhk.security.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.hxhk.security.entity.main.Organization;
import com.hxhk.security.entity.main.Role;
import com.hxhk.security.entity.main.User;
import com.hxhk.security.entity.main.UserRole;
import com.hxhk.security.exception.ExistedException;
import com.hxhk.security.service.OrganizationService;
import com.hxhk.security.service.RoleService;
import com.hxhk.security.service.UserRoleService;
import com.hxhk.security.service.UserService;
import com.hxhk.util.dwz.AjaxObject;
import com.hxhk.util.dwz.PageInfo;

/** 
 * 	
 * @author 	<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version  1.1.0
 * @since   2012-8-7 下午3:12:23 
 */
@Controller
@RequestMapping("/management/security/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	UserRoleService userRoleService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private OrganizationService organizationService;
	
	private static final String CREATE = "security/views/management/security/user/create";
	private static final String UPDATE = "security/views/management/security/user/update";
	private static final String LIST = "security/views/management/security/user/list";
	private static final String LOOK_UP_ROLE = "security/views/management/security/user/assign_role";
	private static final String LOOK_USER_ROLE = "security/views/management/security/user/delete_user_role";
	private static final String LOOK_ORG = "security/views/management/security/user/lookup_org";
	
	@RequiresPermissions("User:save")
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public String preCreate() {
		return CREATE;
	}
	
	@RequiresPermissions("User:save")
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public @ResponseBody String create(User user) {	
		user.setCreateTime(new Date());
		
		try {
			userService.save(user);
		} catch (ExistedException e) {
			AjaxObject ajaxObject = new AjaxObject(e.getMessage());
			ajaxObject.setCallbackType("");
			ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
			return ajaxObject.toString();
		}
		
		AjaxObject ajaxObject = new AjaxObject("用户添加成功！");
		ajaxObject.setNavTabId("User");
		return ajaxObject.toString();
	}
	
	@ModelAttribute("preloadUser")
	public User getOne(@RequestParam(value = "id", required = false) Long id) {
		if (id != null) {
			User user = userService.get(id);
			user.setOrganization(null);
			return user;
		}
		return null;
	}
	
	@RequiresPermissions("User:edit")
	@RequestMapping(value="/update/{id}", method=RequestMethod.GET)
	public String preUpdate(@PathVariable Long id, Map<String, Object> map) {
		User user = userService.get(id);
		
		map.put("user", user);
		return UPDATE;
	}
	
	@RequiresPermissions("User:edit")
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public @ResponseBody String update(@ModelAttribute("preloadUser")User user) {
		userService.update(user);
		
		AjaxObject ajaxObject = new AjaxObject("用户修改成功！");
		ajaxObject.setNavTabId("User");
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("User:delete")
	@RequestMapping(value="/delete/{id}", method=RequestMethod.POST)
	public @ResponseBody String delete(@PathVariable Long id) {
		AjaxObject ajaxObject = new AjaxObject("用户删除成功！");
		try {
			userService.delete(id);
		} catch (ExistedException e) {
			ajaxObject.setMessage(e.getMessage());
		}
		
		//AjaxObject ajaxObject = new AjaxObject("用户删除成功");
		ajaxObject.setCallbackType("");
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("User:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(PageInfo pageInfo, String keywords, Map<String, Object> map) {
		List<User> users;
		if (StringUtils.isNotBlank(keywords)) {
			users = userService.find(pageInfo, keywords);
		} else {
			users = userService.findAll(pageInfo);
		}
		
		map.put("page", pageInfo);
		map.put("users", users);
		map.put("keywords", keywords);
		return LIST;
	}
	
	@RequiresPermissions("User:edit")
	@RequestMapping(value="/reset/{type}/{userId}", method=RequestMethod.POST)
	public @ResponseBody String reset(@PathVariable String type, @PathVariable Long userId) {
		User user = userService.get(userId);
		AjaxObject ajaxObject = new AjaxObject();
		if (type.equals("password")) {
			user.setPlainPassword("123456");
			
			ajaxObject.setMessage("重置密码成功，默认密码为123456！"); 
		} else if (type.equals("status")) {
			if (user.getStatus().equals("enabled")) {
				user.setStatus("disabled");
			} else {
				user.setStatus("enabled");
			}
			
			ajaxObject.setMessage("更新状态为" + user.getStatus());
		}
		
		userService.update(user);
		ajaxObject.setCallbackType("");
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("User:save")
	@RequestMapping(value="/create/userRole", method={RequestMethod.POST})
	public @ResponseBody void assignRole(UserRole userRole) {
		userRoleService.save(userRole);
	}
	
	@RequiresPermissions("User:edit")
	@RequestMapping(value="/lookup2create/userRole/{userId}", method={RequestMethod.GET, RequestMethod.POST})
	public String listUnassignRole(Map<String, Object> map, @PathVariable Long userId) {
		PageInfo pageInfo = new PageInfo();
		pageInfo.setNumPerPage(Integer.MAX_VALUE);
		
		List<UserRole> userRoles = userRoleService.find(userId);
		List<Role> roles = roleService.findAll(pageInfo);
		
		List<Role> hasList = Lists.newArrayList();
		List<Role> allRoles = Lists.newArrayList(roles);
		// 删除已分配roles
		for (UserRole ur : userRoles) {
			for (Role role : roles) {
				if (ur.getRole().getId().equals(role.getId())) {
					hasList.add(role);
					break;
				}
			}
		}
		
		allRoles.removeAll(hasList);
		
		map.put("userRoles", userRoles);
		map.put("roles", allRoles);
		
		map.put("userId", userId);
		return LOOK_UP_ROLE;
	}
	
	@RequiresPermissions("User:edit")
	@RequestMapping(value="/lookup2delete/userRole/{userId}", method={RequestMethod.GET, RequestMethod.POST})
	public String listUserRole(Map<String, Object> map, @PathVariable Long userId) {
		List<UserRole> userRoles = userRoleService.find(userId);
		map.put("userRoles", userRoles);
		return LOOK_USER_ROLE;
	}
	
	@RequiresPermissions("User:edit")
	@RequestMapping(value="/delete/userRole/{userRoleId}", method={RequestMethod.POST})
	public @ResponseBody void deleteUserRole(@PathVariable Long userRoleId) {
		userRoleService.delete(userRoleId);
	}
	
	@RequiresPermissions(value={"User:edit", "User:save"})
	@RequestMapping(value="/lookup2org", method={RequestMethod.GET})
	public String lookup(Map<String, Object> map) {
		Organization org = organizationService.getTree();
		
		map.put("org", org);
		return LOOK_ORG;
	}
}
