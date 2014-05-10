<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/page/security/views/include.inc.jsp"%>
<%@page import="com.hxhk.security.entity.main.Role"%>
<%@page import="com.hxhk.security.entity.main.Module,java.util.*"%>
<% String list = (String)request.getAttribute("module");
Role role = (Role)request.getAttribute("role");
List<String> permissionList = role.getPermissionList();
StringBuffer permis = new StringBuffer();
for(String s:permissionList){
	permis.append(s+",");
}

%>
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
	gridTree.setHeader(headerDataList,1,widthList,true,"GridHead","This is a tipTitle of head href!","header status text","","");				
	//设置列样式
	gridTree.gridHeaderColStyleArray=new Array("","centerClo","centerClo","centerClo","centerClo","centerClo");
	gridTree.gridDataCloStyleArray=new Array("","centerClo","centerClo","centerClo","centerClo","centerClo");	
//add data
	var list = $("#menuList").val();
	var rolePermis = $("#rolePermiss").val();
	
	var menu = list.split("#");
	var dataList;
	var data;
	//alert(menu[0].split(",").length);
	 for(var i=0 ;i<menu.length;i++){
		 data = menu[i].split(",");
		 var all1 = 0;
		 var all2 = 0;
		 var all3 = 0;
		 var all4 = 0;
		 var view ="";
		 var view1 = "<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":view' />";
		 var view2 = "<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":view' checked=true/>";
		 var viewStr = data[3]+":view";
		 if(rolePermis.indexOf(viewStr)>=0){
			  all1 = 1;
			 view=view2;
		 }else{
			 view=view1;
			  all1 = 0;
		 }
		 
		 var save ="";
		 var save1 = "<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":save' />";
		 var save2 = "<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":save' checked=true/>";
		 var saveStr = data[3]+":save";
		 if(rolePermis.indexOf(saveStr)>=0){
			  all2 = 1;
			 save=save2;
		 }else{
			 all2 = 0;
			 save=save1;
		 }
		 
		 var edit ="";
		 var edit1 = "<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":edit' />";
		 var edit2 = "<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":edit' checked=true/>";
		 var editStr = data[3]+":edit";
		 if(rolePermis.indexOf(editStr)>=0){
			 all3 = 1;
			 edit=edit2;
		 }else{
			 all3 = 0;
			 edit=edit1;
		 }
		 
		 var del ="";
		 var del1 = "<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":delete' />";
		 var del2 = "<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":delete' checked=true/>";
		 var delStr = data[3]+":delete";
		 if(rolePermis.indexOf(delStr)>=0){
			 all4 = 1;
			 del=del2;
		 }else{
			 all4 = 0;
			 del=del1;
		 }
		 
		 var total ="";
		 var total1 = "<input type='checkbox'  class='checkboxCtrl' group='permissionList["+i+"]' />";
		 var total2 = "<input type='checkbox'  class='checkboxCtrl' group='permissionList["+i+"]' checked=true/>";
		 if(all1 == 1 && all2 == 1 && all3==1 && all4==1 ){			
			 total=total2;
		 }else{			
			 total=total1;
		 }
		 if(rolePermis.indexOf(viewStr)>=0){
			 dataList=new Array(data[2],"<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":view' checked=true />",save,edit,del,total);
		 }else{
			 dataList=new Array(data[2],"<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":view'  />",save,edit,del,total);
		 }
		//dataList=new Array(data[2],"<input type='checkbox' name='permissionList["+i+"]' value='"+data[3]+":view' checked=true />",save,edit,del,total);
		//参数: dataList,id,pid,booleanOpen,order,url,target,hrefTip,hrefStatusText,classStyle,icon,iconOpen
		gridTree.addGirdNode(dataList,data[0],data[1],true,data[4],"#",null,data[2],data[2],null,null,null);
	}
	//var dataList=new Array("系统管理","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />","<input type='checkbox' name='c1' value='1' />");
	//参数: dataList,id,pid,booleanOpen,order,url,target,hrefTip,hrefStatusText,classStyle,icon,iconOpen
	//gridTree.addGirdNode(dataList,10,1,null,3,"#",null,"hello!","状态栏文字",null,null,null);

	

//print	
	gridTree.printTableTreeToElement("gridTreeDiv");		
})

</script>
<input type="hidden" value=<%=list%> id="menuList" />
<input type="hidden" value=<%=permis%> id="rolePermiss" />
<h2 class="contentTitle">修改角色</h2>
<form method="post" action="<%=basePath %>/management/security/role/update" class="required-validate pageForm" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="97">
	<input type="hidden" name="id" value="${role.id }">
	<dl>
		<dt>名称：</dt>
		<dd>
			<input type="text" name="name" class="required" size="30" maxlength="32" alt="请输入角色名称" value="${role.name }"/>
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