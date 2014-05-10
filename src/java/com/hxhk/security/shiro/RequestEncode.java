package com.hxhk.security.shiro;


import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class RequestEncode
{
    public static void requestConvertEncode
	(HttpServletRequest httpservletrequest, String string,
	 String string_0_) {
	String string_1_ = "";
	Enumeration enumeration = httpservletrequest.getParameterNames();
	while (enumeration.hasMoreElements()) {
	    string_1_ = (String) enumeration.nextElement();
	    String[] strings
		= httpservletrequest.getParameterValues(string_1_);
	    for (int i = 0; i < strings.length; i++)
		strings[i] = convertEncode(strings[i], string, string_0_);
	}
    }
    
    public static void requestConvertPostUrlEncode
	(HttpServletRequest httpservletrequest, String string,
	 String string_2_, String string_3_) {
	String string_4_ = "";
	Enumeration enumeration = httpservletrequest.getParameterNames();
	while (enumeration.hasMoreElements()) {
	    string_4_ = (String) enumeration.nextElement();
	    if (string_3_.indexOf(new StringBuilder().append(string_4_).append
				      ("=").toString())
		> -1) {
		String[] strings
		    = httpservletrequest.getParameterValues(string_4_);
		for (int i = 0; i < strings.length; i++)
		    strings[i] = convertEncode(strings[i], string, string_2_);
	    }
	}
    }
    
    public static String convertEncode(String string, String string_5_,
				       String string_6_) {
	String string_7_ = null;
	try {
	    string_7_ = new String(string.getBytes(string_5_), string_6_);
	} catch (Exception exception) {
	    exception.printStackTrace();
	}
	return string_7_;
    }
}


/***** DECOMPILATION REPORT *****
	LOCATION: D:\workspace\quanna_wx\WebRoot\WEB-INF\lib\hxhk-xframe-2.0.10.jar!com.bonc.xframe.util.RequestEncode
	TOTAL TIME: 0 ms
 ********************************/

