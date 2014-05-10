<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="/hxhktag" prefix="h" %>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<form id="pagerForm" method="post" action="<%=basePath %>/management/security/user/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	 
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>

<form method="post" action="<%=basePath %>/management/security/user/list" onsubmit="return navTabSearch(this)">
	
	<div class="pageHeader">
		<div class="searchBar">
			<ul class="searchContent">
				<li>
					<label>登录名称：</label>
					<input type="text" name="keywords" value="${keywords}"/>
				</li>
			</ul>
			<div class="subBar">
				<ul>						
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">搜索</button></div></div></li>
				</ul>
			</div>
		</div>
	</div>
</form>

<div class="pageContent">

	<div class="panelBar">
		<ul class="toolBar">
			<shiro:hasPermission name="User:save">
				<li><a class="add" target="dialog" rel="lookup2organization" mask="true" width="530" height="380" href="<%=basePath %>/management/security/user/create" ><span>添加</span></a></li>
			</shiro:hasPermission>
			<shiro:hasPermission name="User:edit">
				<li><a class="edit" target="dialog" rel="lookup2organization" mask="true" width="530" height="380" href="<%=basePath %>/management/security/user/update/{slt_uid}" ><span>编辑</span></a></li>
			</shiro:hasPermission>
			<shiro:hasPermission name="User:delete">
				<li><a class="delete" target="ajaxTodo" href="<%=basePath %>/management/security/user/delete/{slt_uid}" title="确认要删除该用户?"><span>删除</span></a></li>
			</shiro:hasPermission>
			<shiro:hasPermission name="User:edit">
				<li class="line">line</li>
				<li><a class="edit" target="ajaxTodo" href="<%=basePath %>/management/security/user/reset/password/{slt_uid}" title="确认重置密码为123456?"><span>重置密码</span></a></li>
				<li><a class="edit" target="ajaxTodo" href="<%=basePath %>/management/security/user/reset/status/{slt_uid}" title="确认更新状态"><span>更新账户状态</span></a></li>
				<li class="line">line</li>
				<li><a class="add" href="<%=basePath %>/management/security/user/lookup2create/userRole/{slt_uid}" target="dialog" mask="true" width="400" height="500" title="分配角色"><span>分配角色</span></a></li>
				<li><a class="delete" href="<%=basePath %>/management/security/user/lookup2delete/userRole/{slt_uid}" target="dialog" mask="true" width="400" height="500" title="删除已分配角色"><span>删除已分配角色</span></a></li>
			</shiro:hasPermission>
		</ul>
	</div>
	
	<table class="table" layoutH="138" width="100%">
		<thead>
			<tr>
				<th width="100">登录名称</th>
				<th width="100">真实名字</th>
				<th width="200">邮箱地址</th>
				<th width="100">电话</th>
				<th width="150" orderField=organization.name class="${page.orderField eq 'organization.name' ? page.orderDirection : ''}">所在组织</th>
				<th width="150" >角色</th>
				<th width="100" orderField="status" class="${page.orderField eq 'status' ? page.orderDirection : ''}">账户状态</th>
				<th orderField="createTime" class="${page.orderField eq 'createTime' ? page.orderDirection : ''}">创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${users}">
			<tr target="slt_uid" rel="${item.id}">
				<td>${item.username}</td>
				<td>${item.realname}</td>
				<td>${item.email}</td>
				<td>${item.phone}</td>
				<td>${item.organization.name}</td>
				<td>
					<c:forEach var="ur" items="${item.userRoles }">
						${ur.role.name }&nbsp;&nbsp;
					</c:forEach>
				</td>
				<td>${item.status == "enabled" ? "可用":"不可用"}</td>
				<td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 分页
	
	 -->
	 <h:pageInfo page="${page}" targetType="navTab"/>
	
</div>
