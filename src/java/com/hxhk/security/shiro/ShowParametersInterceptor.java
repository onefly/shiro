package com.hxhk.security.shiro;

import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;




public class ShowParametersInterceptor implements HandlerInterceptor{
	private  final Log logger = LogFactory.getLog(getClass());
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse res, Object o, Exception e)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse res,
			Object o, ModelAndView model) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res,
			Object o) throws Exception {
		showParameters(req);		
		return true;
	}

	private void showParameters(HttpServletRequest localHttpServletRequest) {
		if (logger.isDebugEnabled()) {
			logger.debug("下面是参数展示，post方式的中文会是乱码：");			
			Map localMap = localHttpServletRequest.getParameterMap();
			Iterator localIterator = localMap.entrySet().iterator();
			while (localIterator.hasNext()) {
				Map.Entry localEntry = (Map.Entry) localIterator.next();
				String str = (String) localEntry.getKey();
				logger.debug("--->param name:"
						+ str
						+ " value:"
						+ RequestEncode.convertEncode(Arrays
								.toString((Object[]) localEntry.getValue()),
								"iso8859-1", "UTF-8"));
			}
		}

	}
}
