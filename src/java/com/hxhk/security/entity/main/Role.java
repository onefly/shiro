/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, ketayao.com
 * Filename:		com.ketayao.entity.Role.java
 * Class:			Role
 * Date:			2012-6-7
 * Author:			<a href="mailto:ketayao@gmail.com">ketayao</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/
 
package com.hxhk.security.entity.main;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.common.collect.Lists;
import com.hxhk.security.entity.IdEntity;

/** 
 * 	
 * @author 	<a href="mailto:ketayao@gmail.com">ketayao</a>
 * Version  1.1.0
 * @since   2012-6-7 上午11:07:45 
 */
@Entity
@Table(name="security_role")
@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE, region="com.hxhk.security.entity.main")
public class Role extends IdEntity {
	
	/** 描述  */
	private static final long serialVersionUID = -5537665695891354775L;
	
	@Column(nullable=false, length=32)
	private String name;
	
	@ElementCollection
	@CollectionTable(
			name = "security_role_permission", 
			joinColumns = { @JoinColumn(name = "roleId") }
	)
	@Column(name = "permission")
	@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE, region="com.ketayao.security.entity.main")
	private List<String> permissionList = Lists.newArrayList();
	
	@OneToMany(mappedBy="role", cascade=CascadeType.ALL)
	private List<UserRole> userRoles = new ArrayList<UserRole>(0);

	/**  
	 * 返回 name 的值   
	 * @return name  
	 */
	public String getName() {
		return name;
	}

	/**  
	 * 设置 name 的值  
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**  
	 * 返回 userRoles 的值   
	 * @return userRoles  
	 */
	public List<UserRole> getUserRoles() {
		return userRoles;
	}

	/**  
	 * 设置 userRoles 的值  
	 * @param userRoles
	 */
	public void setUserRoles(List<UserRole> userRoles) {
		this.userRoles = userRoles;
	}

	/**  
	 * 返回 permissionList 的值   
	 * @return permissionList  
	 */
	public List<String> getPermissionList() {
		return permissionList;
	}

	/**  
	 * 设置 permissionList 的值  
	 * @param permissionList
	 */
	public void setPermissionList(List<String> permissionList) {
		this.permissionList = permissionList;
	}
	
	
}
