<%@ page import="data.dao.mariaDB.DepartmentMariaDb" %><%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 02.04.2019
  Time: 23:13
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    <%@ include file="/styles/user-managment.css" %>
    <%@ include file="/styles/popup.css" %>
</style>
<html>
<head>
    <meta charset="utf-8">
    <title>Управление пользователями</title>
</head>
<body class="body">
<script>
    function deleteRow(idpk, login){
        document.getElementById('delete_popup').style.display='block';
        var el=document.getElementById('idUser');
        el.value = idpk;
        document.getElementById('text-delete').innerHTML = "Удалить пользователя "+login+"?";
    }

    function restoreRow(){
        document.getElementById('restore_popup').style.display='block';
    }
</script>
<!-- ОКНО ВОССТАНОВЛЕНИЯ -->
<div id="restore_popup" class="parent_popup">
    <div class="popup">
        <form action="/restoreUser" method="POST" class="popup-form" style="height:450px;">
            <div class="top-div">
                Восстановить пользователей
            </div>
            <div class="center-div">

            </div>
            <div class="bottom-div">
                <input type="submit" class="button blue" value="Восстановить все"/>
                <input type="submit" class="button red" value="Очистить все"/>
                <input type="button" class="button gray" onclick="document.getElementById('delete_popup').style.display='none';" value="Отмена"/>
            </div>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ СТРОКИ -->
<div id="delete_popup" class="parent_popup">
    <div class="popup">
        <form action="/deleteUser" method="POST" id="form-popup1" class="popup-form" style="height:150px;">
            <table class="popup-table">
                <tr>
                    <td id="text-delete"></td>
                </tr>
                <tr><td></td></tr>
                <tr><td></td></tr>
                <tr>
                    <td>
                    <table style="margin: 0 auto;">
                        <tr>
                            <td>
                                <input type="button" class="button gray" onclick="document.getElementById('delete_popup').style.display='none';" value="Отмена"/>
                            </td>
                            <td>
                                <input type="number" hidden id="idUser" name="idUser"/>
                                <input type="submit" class="button red" value="Подтвердить"/>
                            </td>
                        </tr>
                    </table>
                    </td>
                </tr>
            </table>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('delete_popup').style.display='none';">X</a></div>
</div>
<!-- ОСНОВНОЕ ОКНО -->
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
                <td>${roleList.get(user.idRole-1).name}</td>
                <td>${depList.get(user.idDepartment-1).shortName}</td>
                <td>
                    <c:if test="${user.idRole!=1}">
                        <input type="button" class="button red" onclick="deleteRow(${user.idUser}, '${user.login}');" value="Удалить"/>
                    </c:if>
                    <input type="button" class="button blue" value="Редактировать"/>
                </td>
            </tr>
        </c:forEach>
    </table>
    <p>
        <input type="button" class="button purple" value="Добавить"/>
        <input type="button" class="button gray" onclick="restoreRow();" value="Восстановить"/>
    </p>
</div>
</body>
</html>

