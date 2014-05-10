<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<div class="pageContent">
<form method="post" action="<%=basePath %>/management/index/updatePwd" class="required-validate pageForm" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layouth="57">
		<%--
		<p>
			<label>
				当前密码：
			</label><input type="password" name="oldPassword" class="required"/>
		</p>
		--%>
		<p>
			<label>
				新密码：
			</label><input type="password" name="plainPassword" id="newPassword" class="required"/>
		</p>
		<p>
			<label>
				确认新密码：
			</label><input type="password" name="rPassword" class="required" equalTo="#newPassword"/>
		</p>
	</div>
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确认</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close" >关闭</button></div></div></li>
		</ul>
	</div>
</form>
</div>