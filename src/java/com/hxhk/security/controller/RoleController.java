/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.controller.RoleController.java
 * Class:			RoleController
 * Date:			2012-8-7
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/

package com.hxhk.security.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.hxhk.security.entity.main.Module;
import com.hxhk.security.entity.main.Role;
import com.hxhk.security.service.ModuleService;
import com.hxhk.security.service.RoleService;
import com.hxhk.util.dwz.AjaxObject;
import com.hxhk.util.dwz.PageInfo;

/**
 * 
 * @author <a href="mailto:hxhk@gmail.com">hxhk</a> Version 1.1.0
 * @since 2012-8-7 下午5:44:13
 */
@Controller
@RequestMapping("/management/security/role")
public class RoleController {

	@Autowired
	private RoleService roleService;

	@Autowired
	private ModuleService moduleService;

	private static final String CREATE = "security/views/management/security/role/create";
	private static final String UPDATE = "security/views/management/security/role/update";
	private static final String LIST = "security/views/management/security/role/list";

	@RequiresPermissions("Role:save")
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String preCreate(HttpServletRequest request) {

		StringBuffer sb = new StringBuffer();
		Module root = moduleService.getTree();
		for (Module m1 : root.getChildren()) {
			sb.append("" + m1.getId() + "," + m1.getParent().getId() + ","
					+ m1.getName() + "," + m1.getSn() + "," + m1.getPriority()
					+ "#");
			if (m1.getChildren().size() > 0) {
				for (Module m2 : m1.getChildren()) {
					sb.append("" + m2.getId() + "," + m2.getParent().getId()
							+ "," + m2.getName() + "," + m2.getSn() + ","
							+ m2.getPriority() + "#");
					if (m2.getChildren().size() > 0) {
						for (Module m3 : m2.getChildren()) {
							sb.append("" + m3.getId() + ","
									+ m3.getParent().getId() + ","
									+ m3.getName() + "," + m3.getSn() + ","
									+ m3.getPriority() + "#");
							if (m3.getChildren().size() > 0) {
								for (Module m4 : m3.getChildren()) {
									sb.append("" + m4.getId() + ","
											+ m4.getParent().getId() + ","
											+ m4.getName() + "," + m4.getSn()
											+ "," + m4.getPriority() + "#");
								}
							}

						}
					}
				}
			}
		}
		request.setAttribute("module", sb.toString());
		return CREATE;
	}

	// 重新组装PermissionList（切分test:save,test:edit的形式）
	private void refactor(Role role) {
		List<String> allList = Lists.newArrayList();
		List<String> list = role.getPermissionList();
		for (String string : list) {
			if (StringUtils.isBlank(string)) {
				continue;
			}

			if (string.contains(",")) {
				String[] arr = string.split(",");
				allList.addAll(Arrays.asList(arr));
			} else {
				allList.add(string);
			}
		}
		role.setPermissionList(allList);
	}

	@RequiresPermissions("Role:save")
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody
	String create(Role role) {
		refactor(role);
		roleService.save(role);

		AjaxObject ajaxObject = new AjaxObject("角色添加成功！");
		ajaxObject.setNavTabId("Role");
		return ajaxObject.toString();
	}

	@RequiresPermissions("Role:edit")
	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String preUpdate(@PathVariable Long id, HttpServletRequest request) {
		Role role = roleService.get(id);

		StringBuffer sb = new StringBuffer();
		Module root = moduleService.getTree();
		for (Module m1 : root.getChildren()) {
			sb.append("" + m1.getId() + "," + m1.getParent().getId() + ","
					+ m1.getName() + "," + m1.getSn() + "," + m1.getPriority()
					+ "#");
			if (m1.getChildren().size() > 0) {
				for (Module m2 : m1.getChildren()) {
					sb.append("" + m2.getId() + "," + m2.getParent().getId()
							+ "," + m2.getName() + "," + m2.getSn() + ","
							+ m2.getPriority() + "#");
					if (m2.getChildren().size() > 0) {
						for (Module m3 : m2.getChildren()) {
							sb.append("" + m3.getId() + ","
									+ m3.getParent().getId() + ","
									+ m3.getName() + "," + m3.getSn() + ","
									+ m3.getPriority() + "#");
							if (m3.getChildren().size() > 0) {
								for (Module m4 : m3.getChildren()) {
									sb.append("" + m4.getId() + ","
											+ m4.getParent().getId() + ","
											+ m4.getName() + "," + m4.getSn()
											+ "," + m4.getPriority() + "#");
								}
							}

						}
					}
				}
			}
		}
		request.setAttribute("module", sb.toString());
		request.setAttribute("role", role);
		return UPDATE;
	}

	@RequiresPermissions("Role:edit")
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public @ResponseBody
	String update(Role role) {
		refactor(role);
		roleService.update(role);

		AjaxObject ajaxObject = new AjaxObject("角色修改成功！");
		ajaxObject.setNavTabId("Role");
		return ajaxObject.toString();
	}

	@RequiresPermissions("Role:delete")
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	public @ResponseBody
	String delete(@PathVariable Long id) {
		AjaxObject ajaxObject = new AjaxObject("角色删除成功！");
		// 超级管理员角色不能删除
		if (id != 1) {
			roleService.delete(id);
		} else {
			ajaxObject.setMessage("超级管理员不能删除！");
			ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
		}
		ajaxObject.setCallbackType("");
		ajaxObject.setNavTabId("Role");
		return ajaxObject.toString();
	}

	@RequiresPermissions("Role:view")
	@RequestMapping(value = "/list", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String list(PageInfo pageInfo, String keywords, Map<String, Object> map) {
		List<Role> roles = null;
		if (StringUtils.isNotBlank(keywords)) {
			roles = roleService.find(pageInfo, keywords);
		} else {
			roles = roleService.findAll(pageInfo);
		}

		map.put("page", pageInfo);
		map.put("roles", roles);
		map.put("keywords", keywords);
		return LIST;
	}

}
