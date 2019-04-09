<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 02.04.2019
  Time: 23:13
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style><%@ include file="/styles/user-managment.css" %></style>
<html>
<head>
    <meta charset="utf-8">
    <title>Документ без названия</title>
</head>
<body class="body">
<div class="top-panel">
    Пользователь: ${login}
    <a href="<c:url value='/plans/admin' />">Назад</a>
</div>
<div class="center-block">
    <h2>Управление пользователями</h2>
    <table>
        <tr>
            <th>Логин</th>
            <th>Пароль</th>
            <th>Доступ</th>
            <th>Кафедра</th>
            <th></th>
        </tr>
        <c:forEach items="${userList}" var="user">
            <tr>
                <td>${user.login}</td>
                <td>${user.password}</td>
                <td>${user.role}</td>
                <td>${depList.get(1).shortName}</td>
                <td>
                    <input type="button" class="button red" value="Удалить"/>
                    <input type="button" class="button blue" value="Редактировать"/>
                </td>
            </tr>
        </c:forEach>
    </table>
    <p>
        <input type="button" class="button purple" value="Добавить"/>
        <input type="button" class="button gray" value="Восстановить"/>
    </p>
</div>
</body>
</html>

