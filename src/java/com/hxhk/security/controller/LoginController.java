/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.security.controller.LoginController.java
 * Class:			LoginController
 * Date:			2012-8-2
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/

package com.hxhk.security.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hxhk.security.SecurityConstants;
import com.hxhk.security.shiro.ShiroDbRealm;
import com.hxhk.util.dwz.AjaxObject;

/**
 * 
 * @author <a href="mailto:hxhk@gmail.com">hxhk</a> Version 1.1.0
 * @since 2012-8-2 下午5:29:01
 */
@Controller
@RequestMapping("/login")
public class LoginController {
	private static final String LOGIN_PAGE = "security/views/login";
	private static final String LOGIN_DIALOG = "security/views/management/index/loginDialog";

	@RequestMapping(method = RequestMethod.GET)
	public String login(HttpServletRequest request) {
		return LOGIN_PAGE;
	}

	@RequestMapping(method = { RequestMethod.GET, RequestMethod.HEAD }, headers = "x-requested-with=XMLHttpRequest")
	public @ResponseBody
	String loginDialog(HttpServletRequest request) {
		AjaxObject ajaxObject = new AjaxObject("会话超时，请重新登录。");
		ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_TIMEOUT);
		ajaxObject.setCallbackType(AjaxObject.CALLBACK_TYPE_CLOSE_CURRENT);

		return ajaxObject.toString();
	}

	@RequestMapping(value = "/timeout", method = { RequestMethod.GET })
	public String timeout() {
		return LOGIN_DIALOG;
	}

	@RequestMapping(value = "/timeout/success", method = { RequestMethod.POST })
	public @ResponseBody
	String timeoutSuccess(HttpServletRequest request) {
		Subject subject = SecurityUtils.getSubject();
		ShiroDbRealm.ShiroUser shiroUser = (ShiroDbRealm.ShiroUser)subject.getPrincipal();

		// 这个是放入user还是shiroUser呢？
		request.getSession().setAttribute(SecurityConstants.LOGIN_USER, shiroUser.getUser());
		
		AjaxObject ajaxObject = new AjaxObject("登录成功。");
		ajaxObject.setCallbackType(AjaxObject.CALLBACK_TYPE_CLOSE_CURRENT);

		return ajaxObject.toString();
	}

	@RequestMapping(method = RequestMethod.POST)
	public String fail(
			@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String username,
			Map<String, Object> map, HttpServletRequest request) {

		String msg = parseException(request);
		
		map.put("msg", msg);
		map.put("username", username);
		
		return LOGIN_PAGE;
	}

	@RequestMapping(method = { RequestMethod.POST, RequestMethod.HEAD }, headers = "x-requested-with=XMLHttpRequest")
	public @ResponseBody
	String failDialog(HttpServletRequest request) {
		String msg = parseException(request);
		
		AjaxObject ajaxObject = new AjaxObject(msg);
		ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
		ajaxObject.setCallbackType("");

		return ajaxObject.toString();
	}

	private String parseException(HttpServletRequest request) {
		String error = (String) request
				.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
		String msg = "其他错误！";
		if (error != null) {
			if ("org.apache.shiro.authc.UnknownAccountException".equals(error))
				msg = "未知帐号错误！";
			else if ("org.apache.shiro.authc.IncorrectCredentialsException"
					.equals(error))
				msg = "密码错误！";
			else if ("com.ygsoft.security.shiro.IncorrectCaptchaException"
					.equals(error))
				msg = "验证码错误！";
			else if ("org.apache.shiro.authc.AuthenticationException"
					.equals(error))
				msg = "认证失败！";
			else if ("org.apache.shiro.authc.DisabledAccountException"
					.equals(error))
				msg = "账号被冻结！";
		}
		return "登录失败，" + msg;
	}
}
