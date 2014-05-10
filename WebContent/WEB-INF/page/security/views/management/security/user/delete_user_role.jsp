<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<script type="text/javascript">
<!--
// top
jQuery(document).ready(function(){
     
    $(".deleteUserRole").click(function(){
    	var userRoleId = $(this).attr("id").split("submit_")[1];
    	jQuery.ajax({
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded;charset=UTF-8',
            url: '<%=basePath %>/management/security/user/delete/userRole/' + userRoleId,
            error: function() { 
    	 			alertMsg.error('删除角色关联失败！');
    			},
    		success: function() { 
    	    		// 删除已分配
    	    		$("#userRoleRow_" + userRoleId).remove();
    			}
        });	
    	
    });
    
});
//-->
</script>
<div class="pageContent" layoutH="0" >

	<fieldset>
		<legend>已分配角色</legend>
		<table class="list" width="100%">
			<thead>
				<tr>
					<th width="150">角色名称</th>
					<th>优先级（数值越小，优先级越高）</th>
				</tr>
			</thead>
			<tbody id="hasRoles">
				<c:forEach var="item" items="${userRoles}">
				<tr id="userRoleRow_${item.id}">
					<td>${item.role.name}</td>
					<td>
						<div style="float: left;line-height: 21px;margin: 0px 10px;width: 30px;">${item.priority}</div>
						<div class="button"><div class="buttonContent"><button id="submit_${item.id}" class="deleteUserRole">删除关联</button></div></div>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</div>


