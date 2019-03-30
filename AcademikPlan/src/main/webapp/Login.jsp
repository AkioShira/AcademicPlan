<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 26.03.2019
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<ul>
    <c:forEach items="${name}" var="value">
        <li><c:out value="${value}"/></li>
    </c:forEach>
</ul>
</body>
</html>
