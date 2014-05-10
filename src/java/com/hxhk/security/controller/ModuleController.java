/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.controller.ModuleController.java
 * Class:			ModuleController
 * Date:			2012-8-6
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/
 
package com.hxhk.security.controller;

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

import com.hxhk.security.entity.main.Module;
import com.hxhk.security.exception.ServiceException;
import com.hxhk.security.service.ModuleService;
import com.hxhk.util.dwz.AjaxObject;
import com.hxhk.util.dwz.PageInfo;

/** 
 * 	
 * @author 	<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version  1.1.0
 * @since   2012-8-6 上午10:08:48 
 */
@Controller
@RequestMapping("/management/security/module")
public class ModuleController {
	@Autowired
	private ModuleService moduleService;
	
	private static final String CREATE = "security/views/management/security/module/create";
	private static final String UPDATE = "security/views/management/security/module/update";
	private static final String LIST = "security/views/management/security/module/list";
	private static final String TREE = "security/views/management/security/module/tree";
	private static final String MAIN = "security/views/management/security/module/main";
	
	@RequiresPermissions("Module:save")
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public String preCreate() {
		return CREATE;
	}
	
	@RequiresPermissions("Module:save")
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public @ResponseBody String create(Module module, HttpServletRequest request) {
		module.setParent((Module)request.getSession().getAttribute("parentModule"));
		moduleService.save(module);
		
		AjaxObject ajaxObject = new AjaxObject("模块添加成功！");
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("Module:edit")
	@RequestMapping(value="/update/{id}", method=RequestMethod.GET)
	public String preUpdate(@PathVariable Long id, Map<String, Object> map) {
		Module module = moduleService.get(id);
		
		map.put("module", module);
		return UPDATE;
	}
	
	@RequiresPermissions("Module:edit")
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public @ResponseBody String update(Module module) {
		moduleService.update(module);
		
		AjaxObject ajaxObject = new AjaxObject("模块修改成功！");
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("Module:delete")
	@RequestMapping(value="/delete/{id}", method=RequestMethod.POST)
	public @ResponseBody String delete(@PathVariable Long id) {
		AjaxObject ajaxObject = new AjaxObject();
		try {
			moduleService.delete(id);
			ajaxObject.setMessage("模块删除成功！");
		} catch (ServiceException e) {
			ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
			ajaxObject.setMessage("模块删除失败：" + e.getMessage());
		}
		
		ajaxObject.setCallbackType("");
		ajaxObject.setRel("jbsxBox2module");
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("Module:view")
	@RequestMapping(value="/tree", method=RequestMethod.GET)
	public String tree(Map<String, Object> map) {
		Module module = moduleService.getTree();
		
		map.put("module", module);
		return MAIN;
	}
	
	@RequiresPermissions("Module:view")
	@RequestMapping(value="/ajaxtree", method=RequestMethod.GET)
	public String ajaxtree(Long id,Map<String, Object> map) {
		Module module = moduleService.getTree();
		
		map.put("module", module);
		map.put("id", id);
		return TREE;
	}
	
	@RequiresPermissions("Module:view")
	@RequestMapping(value="/list/{parentId}", method={RequestMethod.GET, RequestMethod.POST})
	public String list(PageInfo pageInfo, @PathVariable Long parentId, String keywords, 
			Map<String, Object> map, HttpServletRequest request) {
		List<Module> modules = null;
		if (StringUtils.isNotBlank(keywords)) {
			modules = moduleService.find(parentId, keywords, pageInfo);
		} else {
			modules = moduleService.find(parentId, pageInfo);
		}
		
		request.getSession().setAttribute("parentModule", moduleService.get(parentId));
		Module m = moduleService.get(parentId);
		map.put("page", pageInfo);
		map.put("modules", modules);
		map.put("keywords", keywords);
		map.put("parentId", parentId);
		map.put("parentName", m.getName());
		return LIST;
	}
	
}
