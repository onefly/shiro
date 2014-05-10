<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<script type="text/javascript">
function ajaxOrganTree(json){
	var url = "<%=basePath %>/management/security/organization/ajaxtree";   
    DWZ.ajaxDone(json);
    if (json.statusCode == DWZ.statusCode.ok){
    	$("#organTreeDiv").loadUrl(url);
    	alertMsg.correct(json.message);
        $("#organSearch").click();
    }else{
    	alertMsg.error(json.message);
    }
    
}
</script>
<form id="pagerForm" onsubmit="return divSearch(this, 'jbsxBox2organization');" action="<%=basePath %>/management/security/organization/list/${parentOrganization.id}" method="post">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	 
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>

<form method="post" action="<%=basePath %>/management/security/organization/list/${parentOrganization.id}" onsubmit="return divSearch(this, 'jbsxBox2organization');">
	<div class="pageHeader">
		<div class="searchBar">
			<ul class="searchContent">
			<li><h2 class="contentTitle">当前父组织 >> ${parentName}</h2></li>
				<li>
					<label>组织名称：</label>
					<input type="text" name="keywords" value="${keywords}"/>
				</li>
			</ul>
			<div class="subBar">
				<ul>						
					<li><div class="buttonActive"><div class="buttonContent"><button id="organSearch" type="submit">搜索</button></div></div></li>
				</ul>
			</div>
		</div>
	</div>
</form>

<div class="pageContent">

	<div class="panelBar">
		<ul class="toolBar">
		<shiro:hasPermission name="Organization:save">
			<li><a class="add" target="dialog" width="550" height="350" mask="true" href="<%=basePath %>/management/security/organization/create" ><span>添加</span></a></li>
		</shiro:hasPermission>
		<shiro:hasPermission name="Organization:edit">
			<li><a class="edit" target="dialog" width="550" height="350" mask="true" href="<%=basePath %>/management/security/organization/update/{slt_uid}" ><span>编辑</span></a></li>
		</shiro:hasPermission>
		<shiro:hasPermission name="Organization:delete">
			<li><a class="delete" callback="ajaxOrganTree" target="ajaxTodo" href="<%=basePath %>/management/security/organization/delete/{slt_uid}" title="确认要删除该组织?"><span>删除</span></a></li>
		</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" layoutH="138" width="100%" rel="jbsxBox2organization" >
		<thead>
			<tr>
				<th width="150" >名称</th>
				<th width="150" >父组织</th>
				<th >描述</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${organizations}">
			<tr target="slt_uid" rel="${item.id}">
				<td>${item.name}</td>
				<td>${parentOrganization.name}</td>
				<td>${item.description}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 分页 -->
	<div class="panelBar">
		<div class="pages">
			<span>每页显示</span>
			<select name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value}, 'jbsxBox2organization')">
				<c:forEach begin="10" end="50" step="10" varStatus="s">
					<option value="${s.index}" ${page.numPerPage eq s.index ? 'selected="selected"' : ''}>${s.index}</option>
				</c:forEach>
			</select>
			<span>总条数: ${page.totalCount}</span>
		</div>
	
		<div class="pagination" rel="jbsxBox2organization" totalCount="${page.totalCount}" numPerPage="${page.numPerPage}" pageNumShown="10" currentPage="${page.pageNum}"></div>
	</div>
	
</div>
