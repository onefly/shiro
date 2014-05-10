package com.hxhk.security.shiro;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;   
import javax.servlet.http.HttpServletResponse;   
  



import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerExceptionResolver;   
import org.springframework.web.servlet.ModelAndView;   

import com.hxhk.util.dwz.AjaxObject;
  
public class ExceptionHandler implements HandlerExceptionResolver {   
	protected Logger log = Logger.getLogger(getClass());
	private AjaxObject ajax = new AjaxObject();
   
    @Override
	public ModelAndView resolveException(HttpServletRequest request,   
            HttpServletResponse response, Object handler, Exception ex) { 
    	log.error(ex+"=========================", ex);
    	response.setCharacterEncoding("utf-8");
    	if(ex.toString().contains("ORA-02292")){
    		ajax.setMessage("该条记录正在被使用，无法删除！");
    		ajax.setCallbackType("");
    		ajax.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);    		   		
    	}else{
    		ajax.setMessage("系统错误！");
    		ajax.setCallbackType("");
    		ajax.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);   		
    	}
    	try {
			PrintWriter writer = response.getWriter();
			writer.write(ajax.toString());
			writer.flush();
		} catch (IOException e) {
			
		}
    	//request.setAttribute("ex", ex);  
        return null;//new ModelAndView("/security/views/error/404");   
    }   
  
}  
