<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<script type="text/javascript">
function organUpdateAjaxDone(json){

    DWZ.ajaxDone(json);

    if (json.statusCode == DWZ.statusCode.ok){

    	$("#organSearch").click(); 
    	var url = "<%=basePath %>/management/security/organization/ajaxtree";
        $("#organTreeDiv").loadUrl(url);
         $.pdialog.closeCurrent();

    }

}


</script>
<h2 class="contentTitle">修改组织</h2>
<form method="post" action="<%=basePath %>/management/security/organization/update" class="required-validate pageForm" onsubmit="return validateCallback(this, organUpdateAjaxDone);">
	<input type="hidden" name="id" value="${organization.id }"/>
	<input type="hidden" name="parent.id" value="${organization.parent.id }"/>
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>名称：</dt>
			<dd>
				<input type="text" name="name" class="required" size="32" maxlength="32" value="${organization.name }" alt="请输入组织名称"/>
			</dd>
		</dl>		
		<dl>
			<dt>描述：</dt>
			<dd>
				<textarea name="description" cols="32" rows="3" maxlength="255">${organization.description }</textarea>
			</dd>
		</dl>					
	</div>
			
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>