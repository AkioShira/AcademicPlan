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
    <% List<String> colors = new ArrayList<String>(Arrays.asList("b1"));

    int i = 0;
    boolean isEmpty = false;
    %>

    <c:if test="${departmentUser.idDepartment == 1}">
        <c:forEach items="${facList}" var="faculty">
        <p style="padding-top: 20px; font-weight: bold;">Факультет: <c:out value="${faculty.name}"/></p>

            <c:forEach items="${depList}" var="department">
                <c:if test="${department.idFaculty == faculty.idFaculty}">
                    <p>Кафедра: <c:out value="${department.name}"/></p>
                    <div class="button-block" style="font-size: 12px">
                        <c:forEach items="${titleList}" var="title">
                            <c:if test="${department.idDepartment == title.idDepartment}">
                                <form action="/title" method="POST">
                                    <input type="number" hidden id="idTitle" name="idTitle" value="${title.idTitle}"/>
                                    <input type="submit" class="button <%=colors.get(i++)%>" value="${title.name}"/>
                                </form>
                                <% if(i>colors.size()-1) i=0; isEmpty = true; %>
                            </c:if>
                        </c:forEach>
                        <% if(!isEmpty) { %>
                        На этой кафедре пока нет учебных планов
                        <% } else {isEmpty = false;}%>
                    </div>
                </c:if>
            </c:forEach>
        </c:forEach>
    </c:if>
    <c:if test="${departmentUser.idDepartment != 1}">
        <p style="padding-top: 20px; font-weight: bold;">Факультет: <c:out value="${facultyUser.name}"/></p>
        <p><c:out value="${departmentUser.name}"/></p>
        <div class="button-block">
            <c:forEach items="${userTitleList}" var="title">
                <form action="/title" method="POST">
                    <input type="number" hidden id="idTitle" name="idTitle" value="${title.idTitle}"/>
                    <input type="submit" class="button <%=colors.get(i++)%>" value="${title.name}"/>
                </form>
                <% if(i>colors.size()-1) i=0; isEmpty = true; %>
            </c:forEach>
            <% if(!isEmpty) { %>
            На этой кафедре пока нет учебных планов
            <% } else {isEmpty = false;}%>
        </div>
    </c:if>
    <c:if test = "${sessionUser.idRole <=2}">
        <p style="padding-top: 30px;"><a class="top-button" href="/plans/title-managment">Управление учебными планами</a></p>
    </c:if>


</div>
</body>
</html>
