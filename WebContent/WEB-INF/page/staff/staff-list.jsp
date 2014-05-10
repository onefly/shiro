<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<form id="pagerForm" method="post" action="<%=basePath %>/code/staff/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	 
	<input type="hidden" name="name" value="${keywords}"/>
</form>

<form method="post" action="<%=basePath %>/code/staff/list" onsubmit="return navTabSearch(this)">
	
	<div class="pageHeader">
		<div class="searchBar">
			<ul class="searchContent">
				<li>
					<label>姓名：</label>
					<input type="text" name="name" value="${keywords}"/>
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
			<shiro:hasPermission name="staff:save">
				<li><a class="add" target="dialog" rel="lookup2organization" mask="true" width="530" height="380" href="<%=basePath %>/code/staff/addInit" ><span>添加</span></a></li>
			</shiro:hasPermission>
			<shiro:hasPermission name="staff:edit">
				<li><a class="edit" target="dialog" rel="lookup2organization" mask="true" width="530" height="380" href="<%=basePath %>/code/staff/updateInit/{slt_uid}" ><span>编辑</span></a></li>
			</shiro:hasPermission>
			<shiro:hasPermission name="staff:delete">
				<li><a class="delete" target="ajaxTodo" href="<%=basePath %>/code/staff/delete?id={slt_uid}" title="确认要删除该记录?"><span>删除</span></a></li>
			</shiro:hasPermission>
			
		</ul>
	</div>
	
	<table class="list" layoutH="115" width="98%">
		<thead>
			<tr>
				<th width="100" orderField="staffId" class="${page.orderField eq 'staffId' ? page.orderDirection : ''}">员工编号</th>
				<th width="100" orderField="name" class="${page.orderField eq 'name' ? page.orderDirection : ''}">姓名</th>
				<th width="200" orderField="job" class="${page.orderField eq 'job' ? page.orderDirection : ''}">员工职务</th>
				
				
			</tr>
		</thead>
		<tbody>
			<c:forEach var="staffPO" items="${staffPOs}">
			<tr target="slt_uid" rel="${staffPO.staffId}">
				<td>${staffPO.staffId}</td>
				<td>${staffPO.name}</td>
				<td>${staffPO.job}</td>							
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 分页 -->
	<%@ include file="/WEB-INF/page/security/views/management/_frag/pager/panelBar.jsp"%>
	
	
</div>
