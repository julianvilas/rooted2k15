<%-- 
    Document   : success
    Created on : Dec 15, 2008, 4:08:53 AM
    Author     : eswar@vaannila.com
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rooted2015 Struts1 example</title>
        <link rel="stylesheet" href="css/dumb.css"/>
    </head>
    <body>
        <div class="center box">
        <img src="img/rootedcon-logo1.png">
        <h1>Login Success. Welcome <bean:write name="LoginForm" property="userName"></bean:write></h1>
        </div>
    </body>
</html>
