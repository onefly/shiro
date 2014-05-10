<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<form id="pagerForm" onsubmit="return divSearch(this, 'jbsxBox2module');" action="<%=basePath %>/management/security/module/list/${parentModule.id}" method="post">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	 
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>
<script type="text/javascript">
function ajaxDeleteTree(json){
	var url = "<%=basePath %>/management/security/module/ajaxtree?id=" + $('#moudleParentId').val();
	 DWZ.ajaxDone(json);
	if (json.statusCode == DWZ.statusCode.ok){
    $("#ajaxModuleTree").loadUrl(url);
    alertMsg.correct(json.message);
    $("#moduleSearch").click();  
	}else{
		alertMsg.error(json.message);
	}
}
</script>
<form method="post" action="<%=basePath %>/management/security/module/list/${parentModule.id}" onsubmit="return divSearch(this, 'jbsxBox2module');">
	<div class="pageHeader">
		<div class="searchBar">
			<ul class="searchContent">
				<li><h2 class="contentTitle">当前父模块 >> ${parentName}</h2></li>
				<li>
					<label>模块名称：</label>
					<input type="text" name="keywords" value="${keywords}"/>
				</li>
			</ul>
			<div class="subBar">
				<ul>						
					<li><div class="buttonActive"><div class="buttonContent"><button id="moduleSearch" type="submit">搜索</button></div></div></li>
				</ul>
			</div>
		</div>
	</div>
</form>
<input type="hidden" id="moudleParentId" value="${parentId}"/>
<div class="pageContent">

	<div class="panelBar">
		<ul class="toolBar">
		<shiro:hasPermission name="Module:save">
			<li><a class="add" target="dialog" width="550" height="350" mask="true" href="<%=basePath %>/management/security/module/create" ><span>添加</span></a></li>
		</shiro:hasPermission>
		<shiro:hasPermission name="Module:edit">
			<li><a class="edit" target="dialog" width="550" height="350" mask="true" href="<%=basePath %>/management/security/module/update/{slt_uid}" ><span>编辑</span></a></li>
		</shiro:hasPermission>
		<shiro:hasPermission name="Module:delete">
			<li><a class="delete" callback="ajaxDeleteTree" target="ajaxTodo" href="<%=basePath %>/management/security/module/delete/{slt_uid}" title="确认要删除该模块?"><span>删除</span></a></li>
		</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" layoutH="138" width="100%" rel="jbsxBox2module" >
		<thead>
			<tr>
				<th width="150" >名称</th>
				<th width="60" orderField="priority" class="${page.orderField eq 'priority' ? page.orderDirection : ''}">优先级</th>
				<th width="150" >父模块</th>
				<th>模块地址</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${modules}">
			<tr target="slt_uid" rel="${item.id}">
				<td>${item.name}</td>
				<td>${item.priority}</td>
				<td>${parentModule.name}</td>
				<td>${item.url}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 分页 -->
	<div class="panelBar">
		<div class="pages">
			<span>每页显示</span>
			<select name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value}, 'jbsxBox2module')">
				<c:forEach begin="10" end="50" step="10" varStatus="s">
					<option value="${s.index}" ${page.numPerPage eq s.index ? 'selected="selected"' : ''}>${s.index}</option>
				</c:forEach>
			</select>
			<span>总条数: ${page.totalCount}</span>
		</div>
	
		<div class="pagination" rel="jbsxBox2module" totalCount="${page.totalCount}" numPerPage="${page.numPerPage}" pageNumShown="10" currentPage="${page.pageNum}"></div>
	</div>
	
</div>


