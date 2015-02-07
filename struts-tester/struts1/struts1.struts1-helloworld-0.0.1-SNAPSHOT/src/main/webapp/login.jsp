<%-- 
    Document   : login
    Created on : Dec 15, 2008, 4:03:55 AM
    Author     : eswar@vaannila.com
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
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
        <div style="color:red">
            <html:errors />
        </div>
        <html:form action="/Login">
            <label>User Name : </label><html:text name="LoginForm" property="userName" /> <br>
            <label>Password  : </label><html:password name="LoginForm" property="password" /> <br>
            <br>
            <html:submit value="Login" />
        </html:form>
        </div>
    </body>
</html>
