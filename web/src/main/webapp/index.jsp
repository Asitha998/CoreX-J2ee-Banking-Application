<%--
  Created by IntelliJ IDEA.
  User: Asitha
  Date: 7/9/2025
  Time: 7:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Redirecting...</title>
</head>
<body>
<%--redoirect to login.jsp--%>
<%
    response.setHeader("Refresh", "0; URL=login.jsp");
%>
</body>
</html>
