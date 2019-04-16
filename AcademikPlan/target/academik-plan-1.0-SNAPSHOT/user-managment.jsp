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

    function restoreAll() {
        document.getElementById('restore_all_popup').style.display='block';
    }

    function restoreUser(idpk, login){
        document.getElementById('restore_user_popup').style.display='block';
        var el=document.getElementById('idUserRestore');
        el.value = idpk;
        document.getElementById('text-restore_user_popup').innerHTML = "Восстановить пользователя "+login+"?";
    }

    function clearAll() {
        document.getElementById('clear_all_popup').style.display='block';
    }

    function clearUser(idpk, login){
        document.getElementById('clear_popup').style.display='block';
        var el=document.getElementById('idUserClear');
        el.value = idpk;
        document.getElementById('text-clear_user_popup').innerHTML = "Очистить пользователя "+login+" без возможности восстановления?";
    }

    function updateUser(idpk, login){
        document.getElementById('update_popup').style.display='block';
    }
</script>
<!-- ОКНО ВОССТАНОВЛЕНИЯ -->
<div id="restore_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Восстановить пользователей
            </div>
            <div class="center-div">
                <table>
                    <tr>
                        <th>Логин</th>
                        <th>Пароль</th>
                        <th>Доступ</th>
                        <th>Кафедра</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${userListUnvisible}" var="user">
                        <tr>
                            <td>${user.login}</td>
                            <td>${user.password}</td>
                            <td>${roleList.get(user.idRole-1).name}</td>
                            <td>${depList.get(user.idDepartment-1).shortName}</td>
                            <td>
                                <input type="submit" class="button red" onclick="clearUser(${user.idUser}, '${user.login}');" value="Очистить"/>
                                <input type="submit" class="button blue" onclick="restoreUser(${user.idUser}, '${user.login}');" value="Восстановить"/>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="bottom-div-two">
                <input type="submit" class="button blue" onclick="restoreAll();" value="Восстановить все" name="restore-all"/>
                <input type="submit" class="button red"  onclick="clearAll();" value="Очистить все" name="clear-all"/>
                <input type="button" class="button gray" onclick="document.getElementById('restore_popup').style.display='none';" value="Отмена"/>

            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО РЕДАКТИРОВАНИЯ -->
<div id="update_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Редактирование пользователя
            </div>
            <div class="center-div">

            </div>
            <div class="bottom-div-two">
                <input type="submit" class="button green" value="Сохранить" name="update"/>
                <input type="button" class="button gray" onclick="document.getElementById('restore_popup').style.display='none';" value="Отмена"/>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ВОССТАНОВЛЕНИЯ ВСЕХ ПОЛЬЗОВАТЕЛЕЙ -->
<div id="restore_all_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:130px;">
            <div class="top-div">
                Восстановить всех удалённых пользователей?
            </div>
            <div class="bottom-div-two">
                <form action="/restoreAllUsers" method="POST">
                    <input type="submit" class="button blue" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('restore_all_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_all_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ОЧИСТКИ ВСЕХ ПОЛЬЗОВАТЕЛЕЙ -->
<div id="clear_all_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:130px;">
            <div class="top-div">
                Очистить список удалённых пользователей без возможности восстановления?
            </div>
            <div class="bottom-div-two">
                <form action="/clearAllUsers" method="POST">
                    <input type="submit" class="button red" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('clear_all_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('clear_all_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ВОССТАНОВЛЕНИЯ ПОЛЬЗОВАТЕЛЯ -->
<div id="restore_user_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:130px;">
            <div id="text-restore_user_popup" class="top-div">
            </div>
            <div class="bottom-div-two">
                <form action="/restoreUser" method="POST">
                    <input type="number" hidden id="idUserRestore" name="idUserRestore"/>
                    <input type="submit" class="button blue" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('restore_user_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_user_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ОЧИСТКИ СТРОКИ -->
<div id="clear_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:130px;">
            <div id="text-clear_user_popup" class="top-div">
            </div>
            <div class="bottom-div-two">
                <form action="/clearUser" method="POST">
                    <input type="number" hidden id="idUserClear" name="idUserClear"/>
                    <input type="submit" class="button red" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('clear_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('clear_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ СТРОКИ -->
<div id="delete_popup" class="parent_popup">
    <div class="popup">
        <form action="/deleteUser" method="POST" id="form-popup1" class="popup-form" style="height:130px;">
            <div id="text-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idUser" name="idUser"/>
                <input type="submit" class="button red" value="Подтвердить"/>
                <input type="button" class="button gray" onclick="document.getElementById('delete_popup').style.display='none';" value="Отмена"/>
            </div>
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
        <c:forEach items="${userListVisible}" var="user">
            <tr>
                <td>${user.login}</td>
                <td>${user.password}</td>
                <td>${roleList.get(user.idRole-1).name}</td>
                <td>${depList.get(user.idDepartment-1).shortName}</td>
                <td>
                    <c:if test="${user.idRole!=1}">
                        <input type="button" class="button red" onclick="deleteRow(${user.idUser}, '${user.login}');" value="Удалить"/>
                    </c:if>
                    <input type="button" class="button blue" onclick="updateUser(${user.idUser}, '${user.login}');" value="Редактировать"/>
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

