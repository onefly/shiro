/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.service.impl.RoleServiceImpl.java
 * Class:			RoleServiceImpl
 * Date:			2012-8-7
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/
 
package com.hxhk.security.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxhk.security.dao.RoleDao;
import com.hxhk.security.entity.main.Role;
import com.hxhk.security.service.RoleService;
import com.hxhk.security.shiro.ShiroDbRealm;
import com.hxhk.util.dwz.PageInfo;
import com.hxhk.util.dwz.springdata.PageUtils;

/** 
 * 	
 * @author 	<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version  1.1.0
 * @since   2012-8-7 下午5:04:52 
 */
@Service
@Transactional(readOnly=true)
public class RoleServiceImpl extends BaseServiceImpl<Role, Long> implements RoleService {
	
	private RoleDao roleDao;
	
	@Autowired(required = false)
	private ShiroDbRealm shiroRealm;
	
	/**  
	 * 构造函数
	 * @param jpaRepository  
	 */ 
	@Autowired
	public RoleServiceImpl(RoleDao roleDao) {
		super(roleDao);
		this.roleDao = roleDao;
	}

	/**   
	 * @param role  
	 * @see com.hxhk.security.service.RoleService#update(com.hxhk.security.entity.main.Role)  
	 */
	@Override
	@Transactional
	public void update(Role role) {
		roleDao.save(role);
		shiroRealm.clearAllCachedAuthorizationInfo();
	}

	/**   
	 * @param id  
	 * @see com.hxhk.security.service.RoleService#delete(java.lang.Long)  
	 */
	@Override
	@Transactional
	public void delete(Long id) {
		roleDao.delete(id);
		shiroRealm.clearAllCachedAuthorizationInfo();
	}

	/**   
	 * @param pageInfo
	 * @param name
	 * @return  
	 * @see com.hxhk.security.service.RoleService#find(com.hxhk.util.dwz.PageInfo, java.lang.String)  
	 */
	@Override
	public List<Role> find(PageInfo pageInfo, String name) {
		org.springframework.data.domain.Page<Role> roles = 
				roleDao.findByNameContaining(name, PageUtils.createPageable(pageInfo));
		PageUtils.injectPageProperties(pageInfo, roles);
		return roles.getContent();
	}

}
