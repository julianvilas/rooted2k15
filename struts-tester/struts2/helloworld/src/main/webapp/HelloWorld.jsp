<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rooted2015 Struts2 example</title>
<link rel="stylesheet" href="css/dumb.css"/>
</head>
<body>
<div class="center box">
<img src="img/rootedcon-logo1.png">
<h2><s:property value="messageStore.message" /></h2>
<p>
	The value of the 'userName' param is: <b><s:property value="userName" /></b>
</p>
</div>
</body>
</html>