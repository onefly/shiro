<%@page import="com.hxhk.security.entity.main.Module"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%!
	public String tree(Module module, String basePath) {
		if (module.getChildren().isEmpty()) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("<ul>" + "\n");
		for(Module o : module.getChildren()) {
			buffer.append("<li id=\"li_" + o.getId() + "\"><a href=\"" + basePath + "/management/security/module/list/" + o.getId() + "\" target=\"ajax\" rel=\"jbsxBox2module\">" + o.getName() + "</a>" + "\n");
			buffer.append(tree(o, basePath));
			buffer.append("</li>" + "\n");
		}
		buffer.append("</ul>" + "\n");
		return buffer.toString();
	}
%>
<%
String basePath1 = request.getContextPath();
	Module module2 = (Module)request.getAttribute("module");
	Long id = (Long)request.getAttribute("id");
%>

<ul class="tree treeFolder expand" id="rootul">
			<li id="li_${module.id}"><a href="<%=basePath1%>/management/security/module/list/${module.id}" target="ajax" rel="jbsxBox2module">${module.name }</a>
				
					<%=tree(module2, basePath1) %>
			</li>
			     </ul>	
