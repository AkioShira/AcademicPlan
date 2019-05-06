<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="data.model.Department" %><%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 30.03.2019
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style><%@ include file="/styles/plans.css" %></style>
<html>
<head>
    <meta charset="utf-8">
    <title>Учебные планы по кафедре</title>
</head>
<body class="body">
<div class="top-panel">
    Пользователь: ${sessionUser.login}
    <a class="top-button" href="<c:url value='/logout' />">Выйти</a>
    <c:if test = "${sessionUser.idRole == 1}">
        <a class="top-button" href="<c:url value='/plans/admin' />">Панель администратора</a>
    </c:if>
</div>
<div class="center-block">

    <h2>УЧЕБНЫЕ ПЛАНЫ</h2>
    <% List<String> colors = new ArrayList<String>(Arrays.asList("blue", "purple", "red", "orange", "green", "gray"));
    int i = 0;
    %>

    <c:if test="${departmentUser.idDepartment == 1}">
        <c:forEach items="${facList}" var="faculty">
        <p style="padding-top: 20px; font-weight: bold;">Факультет: <c:out value="${faculty.name}"/></p>

            <c:forEach items="${depList}" var="department">
                <c:if test="${department.idFaculty == faculty.idFaculty}">
                    <p>Кафедра: <c:out value="${department.name}"/></p>
                    <div class="button-block">
                        <input type="button" class="button <%=colors.get(i++)%>" value="Бакалавр"/>
                        <% if(i>colors.size()-1) i=0; %>
                        <input type="button" class="button <%=colors.get(i++)%>" value="Магистр"/>
                        <% if(i>colors.size()-1) i=0; %>
                    </div>
                </c:if>
            </c:forEach>
        </c:forEach>
    </c:if>
    <c:if test="${departmentUser.idDepartment != 1}">
        <p style="padding-top: 20px; font-weight: bold;">Факультет: <c:out value="${facultyUser.name}"/></p>
        <p><c:out value="${departmentUser.name}"/></p>
        <div class="button-block">
            <input type="button" class="button blue" value="Бакалавр"/>
            <input type="button" class="button purple" value="Магистр"/>
        </div>
    </c:if>
</div>
</body>
</html>
