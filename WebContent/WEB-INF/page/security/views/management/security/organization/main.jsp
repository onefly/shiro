<%@page import="com.hxhk.security.entity.main.Organization"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>

<div class="pageContent">
	<div class="tabs">

		<div class="tabsContent">
			<div>
				<div id="organTreeDiv" layoutH="0" style="float:left; display:block; overflow:auto; width:240px; border:solid 1px #CCC; line-height:21px; background:#fff">
					<%@ include file="/WEB-INF/page/security/views/management/security/organization/tree.jsp"%>
				</div>
				
				<div id="jbsxBox2organization" class="unitBox" style="margin-left:246px;">
					<!--#include virtual="list1.html" -->
				</div>
	
			</div>
		</div>
	</div>
</div>
