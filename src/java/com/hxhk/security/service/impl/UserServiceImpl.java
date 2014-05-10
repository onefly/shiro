/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.service.impl.UserServiceImpl.java
 * Class:			UserServiceImpl
 * Date:			2012-8-7
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/
 
package com.hxhk.security.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxhk.security.dao.UserDao;
import com.hxhk.security.entity.main.User;
import com.hxhk.security.exception.ExistedException;
import com.hxhk.security.exception.ServiceException;
import com.hxhk.security.service.UserService;
import com.hxhk.security.shiro.ShiroDbRealm;
import com.hxhk.security.shiro.ShiroDbRealm.HashPassword;
import com.hxhk.util.dwz.PageInfo;
import com.hxhk.util.dwz.springdata.PageUtils;

/** 
 * 	
 * @author 	<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version  1.1.0
 * @since   2012-8-7 下午3:14:29 
 */
@Service
@Transactional(readOnly=true)
public class UserServiceImpl extends BaseServiceImpl<User, Long> implements UserService {
	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	private UserDao userDao;
	
	@Autowired
	private ShiroDbRealm shiroRealm;
	
	/**  
	 * 构造函数
	 * @param jpaRepository  
	 */ 
	@Autowired
	public UserServiceImpl(UserDao userDao) {
		super(userDao);
		this.userDao = userDao;
	}
	
	/**
	 * 
	 * @param user
	 * @throws ExistedException  
	 * @see com.hxhk.security.service.UserService#save(com.hxhk.security.entity.main.User)
	 */
	@Override
	@Transactional
	public void save(User user) throws ExistedException {		
		if (userDao.findByUsername(user.getUsername()) != null) {
			throw new ExistedException("用户添加失败，登录名：" + user.getUsername() + "已存在。");
		}
		
		if (userDao.findByRealname(user.getRealname()) != null) {
			throw new ExistedException("用户添加失败，真实名：" + user.getRealname() + "已存在。");
		}
		
		//设定安全的密码，使用passwordService提供的salt并经过1024次 sha-1 hash
		if (StringUtils.isNotBlank(user.getPlainPassword()) && shiroRealm != null) {
			HashPassword hashPassword = shiroRealm.encrypt(user.getPlainPassword());
			user.setSalt(hashPassword.salt);
			user.setPassword(hashPassword.password);
		}
		
		userDao.save(user);
		shiroRealm.clearCachedAuthorizationInfo(user.getUsername());
	}

	/**   
	 * @param user  
	 * @see com.hxhk.security.service.UserService#update(com.hxhk.security.entity.main.User)  
	 */
	@Override
	@Transactional
	public void update(User user) {
		//if (isSupervisor(user.getId())) {
		//	logger.warn("操作员{},尝试修改超级管理员用户", SecurityUtils.getSubject().getPrincipal());
		//	throw new ServiceException("不能修改超级管理员用户");
		//}
		//设定安全的密码，使用passwordService提供的salt并经过1024次 sha-1 hash
		
		if (StringUtils.isNotBlank(user.getPlainPassword()) && shiroRealm != null) {
			HashPassword hashPassword = shiroRealm.encrypt(user.getPlainPassword());
			user.setSalt(hashPassword.salt);
			user.setPassword(hashPassword.password);
		}
		
		userDao.save(user);
		shiroRealm.clearCachedAuthorizationInfo(user.getUsername());
	}

	/**   
	 * @param id  
	 * @see com.hxhk.security.service.UserService#delete(java.lang.Long)  
	 */
	@Override
	@Transactional
	public void delete(Long id) throws ServiceException {
		if (isSupervisor(id)) {
			logger.warn("操作员{}，尝试删除超级管理员用户", SecurityUtils.getSubject()
					.getPrincipal() + "。");
			throw new ServiceException("不能删除超级管理员用户。");
		}
		userDao.delete(id);
	}

	/**   
	 * @param username
	 * @return  
	 * @see com.hxhk.security.service.UserService#get(java.lang.String)  
	 */
	@Override
	public User get(String username) {
		return userDao.findByUsername(username);
	}

	/**   
	 * @param pageInfo
	 * @param name
	 * @return  
	 * @see com.hxhk.security.service.UserService#find(com.hxhk.util.dwz.PageInfo, java.lang.String)  
	 */
	@Override
	public List<User> find(PageInfo pageInfo, String name) {
		org.springframework.data.domain.Page<User> pageUser = 
				userDao.findByUsernameContaining(name, PageUtils.createPageable(pageInfo));
		PageUtils.injectPageProperties(pageInfo, pageUser);
		return pageUser.getContent();
	}

	/**
	 * 判断是否超级管理员.
	 */
	private boolean isSupervisor(Long id) {
		return id == 1;
	}
}
