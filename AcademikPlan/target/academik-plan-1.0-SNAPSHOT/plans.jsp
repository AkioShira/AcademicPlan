<%--
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
    Пользователь: ${login}

    <a class="top-button" href="<c:url value='/logout' />">Выйти</a>
    <c:if test = "${role == 1}">
        <a class="top-button" href="<c:url value='/plans/admin' />">Панель администратора</a>
    </c:if>
</div>
<div class="center-block">
    <h2>УЧЕБНЫЕ ПЛАНЫ ПО КАФЕДРЕ</h2>
    <p>Кафедра специализированные компьютерные системы</p>
    <input type="button" class="button blue" value="Бакалавр"/>
    <input type="button" class="button purple" value="Магистр"/>
    <p>Кафедра радиофизики и электроники</p>
    <input type="button" class="button red" value="Бакалавр"/>
    <input type="button" class="button orange" value="Магистр"/>
    <p>Кафедра финансов</p>
    <input type="button" class="button green" value="Бакалавр"/>
    <input type="button" class="button gray" value="Магистр"/>
</div>
</body>
</html>
