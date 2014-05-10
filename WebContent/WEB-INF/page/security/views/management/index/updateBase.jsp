<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<div class="pageContent">
<form method="post" action="<%=basePath %>/management/index/updateBase" class="required-validate pageForm" onsubmit="return validateCallback(this, dialogAjaxDone);">
	
	<div class="pageFormContent" layoutH="57">
		<p>
			<label>登录账号</label>
			<input type="text" name="username" size="30" class="readonly" readonly="readonly" value="${user.username }"/>
		</p>
		<p>
			<label>真是姓名</label>
			<input type="text" name="realname" size="30" class="readonly" readonly="readonly" value="${user.realname }"/>
		</p>
		<p>
			<label>电话</label>
			<input type="text" name="phone" class="phone" size="30" value="${user.phone }" maxlength="64"/>
		</p>
		<p>
			<label>email</label>
			<input type="text" name="email" class="email" maxlength="128" size="30" value="${user.email }"/>
		</p>	
	</div>
			
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>
</div>