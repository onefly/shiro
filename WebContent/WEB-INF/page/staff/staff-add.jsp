<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<h2 class="contentTitle">添加用户</h2>
<form method="post" action="<%=basePath %>/code/staff/add" class="required-validate pageForm" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="97">
	
		<p>
			<label>真实名字:</label>
			<input type="text" name="name" class="required" size="20" maxlength="32"/>
		</p>		
		<p>
			<label>职务:</label>
			<input type="text" name="job" class="required" size="20"  maxlength="50" />
		
		</p>
		
	</div>
			
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>