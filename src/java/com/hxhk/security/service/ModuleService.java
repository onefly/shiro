/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.service.ModuleService.java
 * Class:			ModuleService
 * Date:			2012-8-6
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/
 
package com.hxhk.security.service;

import java.util.List;

import com.hxhk.security.entity.main.Module;
import com.hxhk.util.dwz.PageInfo;


/** 
 * 	
 * @author 	<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version  1.1.0
 * @since   2012-8-6 上午9:32:17 
 */

public interface ModuleService extends BaseService<Module, Long>{
	List<Module> find(Long parentId, PageInfo pageInfo);
	
	List<Module> find(Long parentId, String name, PageInfo pageInfo);
	
	Module getTree();
}
