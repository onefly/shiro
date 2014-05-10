package com.hxhk.util.tag;


import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.hxhk.util.dwz.PageInfo;

public class PageTag extends TagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected Logger log = Logger.getLogger(getClass());
	private PageInfo page;
	private String targetType;

	@Override
	public int doStartTag() {
		try {
			JspWriter out = this.pageContext.getOut();
			if (page == null) {
				out.println("No page Found...");
				 return SKIP_BODY;
			}
			out.println("<div class=\"panelBar\"><div class=\"pages\"><span>每页显示</span>");
			out.println("<select name=\"numPerPage\" onchange=\"navTabPageBreak({numPerPage:this.value})\">");
			for(int i=10; i<=30;i+=5){
				if(i==page.getNumPerPage()){
					out.println("<option value="+i+" selected=\"selected\">"+i+"</option>");
				}else{
					out.println("<option value="+i+" >"+i+"</option>");
				}
			}
			out.println("</select>");
			out.println("<span>共 "+page.getTotalPage()+" 页 , "+page.getTotalCount()+" 条记录</span>");
			out.println("</div>");
			out.println("<div class=\"pagination\" targetType=\""+targetType+"\" totalCount="+page.getTotalCount()+" numPerPage="+page.getNumPerPage()+" pageNumShown=\"15\" currentPage="+page.getPageNum()+"></div>");
			out.println("</div>");
		} catch (java.io.IOException e) {
			log.error(e.getMessage(), e);

		}
		return SKIP_BODY;
	}

	public PageInfo getPage() {
		return page;
	}

	public void setPage(PageInfo page) {
		this.page = page;
	}

	public String getTargetType() {
		return targetType;
	}

	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}

}
