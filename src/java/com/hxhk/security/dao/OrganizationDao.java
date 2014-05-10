/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.dao.OrganizationDao.java
 * Class:			OrganizationDao
 * Date:			2012-8-27
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/
 
package com.hxhk.security.dao;

import java.util.List;

import javax.persistence.QueryHint;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;

import com.hxhk.security.entity.main.Organization;

/** 
 * 	
 * @author 	<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version  1.1.0
 * @since   2012-8-27 下午3:55:47 
 */

public interface OrganizationDao extends JpaRepository<Organization, Long>{
	Page<Organization> findByParentId(Long parentId, Pageable pageable);
	
	Page<Organization> findByParentIdAndNameContaining(Long parentId, String name, Pageable pageable);
	
	@QueryHints(value={
			@QueryHint(name="org.hibernate.cacheable",value="true"),
			@QueryHint(name="org.hibernate.cacheRegion",value="com.hxhk.security.entity.main")
		}
	)
	@Query("from Organization")
	List<Organization> findAllWithCache();
}