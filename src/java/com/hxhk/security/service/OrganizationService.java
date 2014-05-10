/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.service.OrganizationService.java
 * Class:			OrganizationService
 * Date:			2012-8-27
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/
 
package com.hxhk.security.service;

import java.util.List;

import com.hxhk.security.entity.main.Organization;
import com.hxhk.util.dwz.PageInfo;

/** 
 * 	
 * @author 	<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version  1.1.0
 * @since   2012-8-27 下午3:56:25 
 */

public interface OrganizationService extends BaseService<Organization, Long>{
	
	List<Organization> find(Long parentId, PageInfo pageInfo);
	
	List<Organization> find(Long parentId, String name, PageInfo pageInfo);
	
	Organization getTree();
}
