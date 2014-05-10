<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<%@page import="com.hxhk.security.entity.main.Module,java.util.*"%>
<% String list = (String)request.getAttribute("module");%>
<style>
	
.btnDiv a{
color:#0000FF;	
text-decoration: none;	
}
.btnDiv a:hover{
color:#CC3300;	
}
.items{
color:#669999;
font-size:14px;		
}
.title{
font-size:16px;		
font-weight:bold;
}
.copyrightdiv{
font-size:12px;	
font-family:"Arial";
color:#C0C0C0;	
}
.centerClo {
	text-align:center;
	vertical-align:middle;
}
</style>
	<link rel="StyleSheet" href="<%=basePath%>/styles/tree/css/tabletree4j.css" type="text/css" />
	<script type="text/javascript" src="<%=basePath%>/styles/tree/TableTree4J.js"></script>
<script type="text/javascript">

var gridTree;
$(function(){
		
	gridTree=new TableTree4J("gridTree","<%=basePath%>/styles/tree/");	
	gridTree.tableDesc="<table border=\"1\" class=\"GridView\" width=\"93%\" id=\"table1\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse: collapse\"  bordercolordark=\"#C0C0C0\" bordercolorlight=\"#C0C0C0\" >";	
	var headerDataList=new Array("根模块","读取","创建","修改","删除","全部");
	var widthList=new Array("50%","10%","10%","10%","10%","10%");
	//参数: arrayHeader,id,headerWidthList,booleanOpen,classStyle,hrefTip,hrefStatusText,icon,iconOpen
	gridTree.setHeader(headerDataList,1,widthList,true,"GridHead","根模块","header status text",null,null);				
	//设置列样式
	gridTree.gridHeaderColStyleArray=new Array("","centerClo","centerClo","centerClo","centerClo","centerClo");
	gridTree.gridDataCloStyleArray=new Array("","centerClo","centerClo","centerClo","centerClo","centerClo");	
//add data
	var list = $("#menuList").val();
	var menu = list.split("#");
	//var dataList;
	var data;
	//alert(menu.length);
	//alert(menu[0].split(",").length);
	for(var i=0 ;i<menu.length;i++){
		 data = menu[i].split(",");
		 //var view = "<input type='checkbox' name='c1' value='1' />";//"<input type='checkbox' name='permissionList[3]' value='"+data[3]+":view' checked=\"checked\"/>";
		 //var save = "<input type='checkbox' name='c1' value='1' />";//"<input type='checkbox' name='permissionList[3]' value='"+data[3]+":save' checked=\"checked\"/>";
		 //var edit = "<input type='checkbox' name='c1' value='1' />";//"<input type='checkbox' name='permissionList[3]' value='"+data[3]+":edit' checked=\"checked\"/>";
		 //var del = "<input type='checkbox' name='c1' value='1' />";//"<input type='checkbox' name='permissionList[3]' value='"+data[3]+":delete' checked=\"checked\"/>";
		 //var all = "<input type='checkbox' name='c1' value='1' />";//"<input type='checkbox'  class='checkboxCtrl' group='permissionList[3]' checked=\"checked\"/>";
		 //var dataList=new Array("test",view,save,edit,del,all);
		 //var dataList=new Array(data[2],"<input type='checkbox' name='permissionList[3]' value='"+data[3]+":view' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />");
		var dataList=new Array(data[2],"<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":view' />","<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":save' />","<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":edit' />","<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":delete' />","<input type='checkbox'  class='checkboxCtrl' group='permissionList["+i+"]' />");
		//参数: dataList,id,pid,booleanOpen,order,url,target,hrefTip,hrefStatusText,classStyle,icon,iconOpen
		gridTree.addGirdNode(dataList,data[0],data[1],true,data[4],"#",null,data[2],data[2],null,null,null);
		//gridTree.addGirdNode(dataList,data[0],data[1],true,data[4],"#",null,data[2],data[2],null,null,null);
		//gridTree.addGirdNode(dataList,data[0],data[1],true,3,"#",null,"hello!","状态栏文字",null,null,null);
	}
	//var dataList=new Array("系统管理","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />");
	//参数: dataList,id,pid,booleanOpen,order,url,target,hrefTip,hrefStatusText,classStyle,icon,iconOpen
	//gridTree.addGirdNode(dataList,100,1,null,3,"#",null,"hello!","状态栏文字",null,null,null);
	
	//var dataList=new Array("系统管理1","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />");
	//参数: dataList,id,pid,booleanOpen,order,url,target,hrefTip,hrefStatusText,classStyle,icon,iconOpen
	//gridTree.addGirdNode(dataList,101,1,null,3,"#",null,"hello!","状态栏文字",null,null,null);
	
	//var dataList=new Array("系统管理3","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />");
	//参数: dataList,id,pid,booleanOpen,order,url,target,hrefTip,hrefStatusText,classStyle,icon,iconOpen
	//gridTree.addGirdNode(dataList,103,100,null,3,"#",null,"hello!","状态栏文字",null,null,null);

	

//print	
	gridTree.printTableTreeToElement("gridTreeDiv");		
})

</script>
<input type="hidden" value=<%=list%> id="menuList" />
<h2 class="contentTitle">添加角色</h2>
<form method="post" action="<%=basePath %>/management/security/role/create" class="required-validate pageForm" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="97">
	<dl>
		<dt>名称：</dt>
		<dd>
			<input type="text" name="name" class="required" size="30" maxlength="32" alt="请输入角色名称"/>
		</dd>
	</dl>
	<div class="divider"></div>
		<div id="gridTreeBtn" class="btnDiv" >
			<span class="items">角色权限</span>   &nbsp;&nbsp;&nbsp;
			
						<a  href="javascript:gridTree.openAllNodes()">展开所有</a> | 
			<a  href="javascript:gridTree.closeAllNodes()">关闭所有</a>
		</div>
		<div id="gridTreeDiv">
			
		</div>
	
	</div>	
	
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit" >确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>