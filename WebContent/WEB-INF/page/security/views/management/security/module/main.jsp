<%@page import="com.hxhk.security.entity.main.Module"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>

<div class="pageContent">
	<div class="tabs">

		<div class="tabsContent">
			<div>
				<div id="ajaxModuleTree" layoutH="0" style="float:left; display:block; overflow:auto; width:240px; border:solid 1px #CCC; line-height:21px; background:#fff">
			    	
						<%@ include file="/WEB-INF/page/security/views/management/security/module/tree.jsp"%>
					
				</div>
				
				<div id="jbsxBox2module" class="unitBox" style="margin-left:246px;">
					<!--#include virtual="list1.html" -->
				</div>
	
			</div>
		</div>
	</div>
</div>
