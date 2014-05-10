/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.controller.OrganizationController.java
 * Class:			OrganizationController
 * Date:			2012-8-27
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

import com.hxhk.security.entity.main.Organization;
import com.hxhk.security.exception.ServiceException;
import com.hxhk.security.service.OrganizationService;
import com.hxhk.util.dwz.AjaxObject;
import com.hxhk.util.dwz.PageInfo;

/** 
 * 	
 * @author 	<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version  1.1.0
 * @since   2012-8-27 下午4:10:26 
 */
@Controller
@RequestMapping("/management/security/organization")
public class OrganizationController {
	@Autowired
	private OrganizationService organizationService;
	
	private static final String CREATE = "security/views/management/security/organization/create";
	private static final String UPDATE = "security/views/management/security/organization/update";
	private static final String LIST = "security/views/management/security/organization/list";
	private static final String TREE = "security/views/management/security/organization/tree";
	private static final String MAIN = "security/views/management/security/organization/main";
	
	@RequiresPermissions("Organization:save")
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public String preCreate() {
		return CREATE;
	}
	
	@RequiresPermissions("Organization:save")
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public @ResponseBody String create(Organization organization, HttpServletRequest request) {
		organization.setParent((Organization)request.getSession().getAttribute("parentOrganization"));
		organizationService.save(organization);
		
		AjaxObject ajaxObject = new AjaxObject("组织添加成功！");
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("Organization:edit")
	@RequestMapping(value="/update/{id}", method=RequestMethod.GET)
	public String preUpdate(@PathVariable Long id, Map<String, Object> map) {
		Organization organization = organizationService.get(id);
		
		map.put("organization", organization);
		return UPDATE;
	}
	
	@RequiresPermissions("Organization:edit")
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public @ResponseBody String update(Organization organization) {
		organizationService.update(organization);
		
		AjaxObject ajaxObject = new AjaxObject("组织修改成功！");
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("Organization:delete")
	@RequestMapping(value="/delete/{id}", method=RequestMethod.POST)
	public @ResponseBody String delete(@PathVariable Long id) {
		AjaxObject ajaxObject = new AjaxObject();
		try {
			organizationService.delete(id);
			ajaxObject.setMessage("组织删除成功！");
		} catch (ServiceException e) {
			ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
			ajaxObject.setMessage("组织删除失败：" + e.getMessage());
		}
		
		ajaxObject.setCallbackType("");
		ajaxObject.setRel("jbsxBox2organization");
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("Organization:view")
	@RequestMapping(value="/tree", method=RequestMethod.GET)
	public String tree(Map<String, Object> map) {
		Organization organization = organizationService.getTree();
		
		map.put("organization", organization);
		return MAIN;
	}
	@RequiresPermissions("Organization:view")
	@RequestMapping(value="/ajaxtree", method=RequestMethod.GET)
	public String ajaxtree(Map<String, Object> map) {
		Organization organization = organizationService.getTree();
		
		map.put("organization", organization);
		return TREE;
	}
	
	@RequiresPermissions("Organization:view")
	@RequestMapping(value="/list/{parentId}", method={RequestMethod.GET, RequestMethod.POST})
	public String list(PageInfo pageInfo, @PathVariable Long parentId, String keywords, 
			Map<String, Object> map, HttpServletRequest request) {
		List<Organization> organizations = null;
		if (StringUtils.isNotBlank(keywords)) {
			organizations = organizationService.find(parentId, keywords, pageInfo);
		} else {
			organizations = organizationService.find(parentId, pageInfo);
		}
		
		request.getSession().setAttribute("parentOrganization", organizationService.get(parentId));
		Organization o = organizationService.get(parentId);
		map.put("page", pageInfo);
		map.put("organizations", organizations);
		map.put("keywords", keywords);
		map.put("parentName",o.getName());
		
		return LIST;
	}
	
}
