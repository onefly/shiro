<%@page import="com.hxhk.security.entity.main.Organization"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%!
	public String tree(Organization organization, String basePath) {
		if (organization.getChildren().isEmpty()) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("<ul>" + "\n");
		for(Organization o : organization.getChildren()) {
			buffer.append("<li><a href=\"" + basePath + "/management/security/organization/list/" + o.getId() + "\" target=\"ajax\" rel=\"jbsxBox2organization\">" + o.getName() + "</a>" + "\n");
			buffer.append(tree(o, basePath));
			buffer.append("</li>" + "\n");
		}
		buffer.append("</ul>" + "\n");
		return buffer.toString();
	}
%>
<%
String basePath2 = request.getContextPath();
	Organization organization2 = (Organization)request.getAttribute("organization");
%>
		    <ul class="tree treeFolder expand">
					<li><a href="<%=basePath2 %>/management/security/organization/list/${organization.id}" target="ajax" rel="jbsxBox2organization">${organization.name }</a>
						<%=tree(organization2, basePath2) %>
					</li>
			     </ul>
				
