<%--
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
    <%@ include file="/styles/message.css" %>
</style>
<html>
<head>
    <meta charset="utf-8">
    <title>Управление пользователями</title>
</head>
<body class="body">
<script type='text/javascript'>
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

    function updateUser(idpk, login, password, iddep, idrole){
        document.getElementById('update_popup').style.display='block';
        document.getElementById("roleUserTr").style.visibility = "visible";
        document.getElementById("depUserTr").style.visibility = "visible";
        document.getElementById('idUserUpdate').value = idpk;
        document.getElementById('loginUserUpdate').value = login;
        document.getElementById('passwordUserUpdate').value = password;
        document.getElementById("departmentUserUpdate").value = iddep;
        document.getElementById("roleUserUpdate").value = idrole;
        if(idrole == 1){
            document.getElementById("roleUserTr").style.visibility = "hidden";
            document.getElementById("depUserTr").style.visibility = "hidden";
        }
    }

    function insertUser() {
        document.getElementById('insert_popup').style.display='block';
    }

    function showErMessage() {
        var x = document.getElementById("snackbar");
        x.className = "show";
        setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
    }

    function showMessage() {
        var x = document.getElementById("snackbar1");
        x.className = "show";
        setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
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
                <table class="center-table">
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
                            <td>${roleMap.get(user.idRole)}</td>
                            <td>${depMap.get(user.idDepartment)}</td>
                            <td>
                                <input type="submit" class="button red" onclick="clearUser(${user.idUser}, '${user.login}');" value="Очистить"/>
                                <input type="submit" class="button blue" onclick="restoreUser(${user.idUser}, '${user.login}');" value="Восстановить"/>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="bottom-div-one">
                <input type="submit" class="button blue" onclick="restoreAll();" value="Восстановить все" name="restore-all"/>
                <input type="submit" class="button red"  onclick="clearAll();" value="Очистить все" name="clear-all"/>
                <input type="button" class="button gray" onclick="document.getElementById('restore_popup').style.display='none';" value="Отмена"/>

            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО РЕДАКТИРОВАНИЯ ПОЛЬЗОВАТЕЛЕЙ-->
<div id="update_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:400px;">
            <div class="top-div">
                Редактирование пользователя
            </div>
            <form action="/updateUser" autocomplete="off" method="POST">
                <div class="center-div-update">

                    <input type="text" hidden id="idUserUpdate" name="idUserUpdate"/>
                    <table class="popup-update-table">
                        <tr>
                            <td>Логин</td>
                            <td><input type="text"
                                       pattern="[A-Za-z0-9]{4,20}"
                                       title="Имя пользователя должно быть размером от 4 до 20 символов, а
                                            также должно содержать латинские буквы и/или цифры."
                                       minlength="4" maxlength="20" required="required" id="loginUserUpdate" name="loginUserUpdate" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Пароль</td>
                            <td><input type="text"
                                       pattern="[A-Za-z0-9]{4,20}"
                                       title="Пароль должен быть размером от 4 до 20 символов, а
                                            также должен содержать латинские буквы и/или цифры."
                                       minlength="4" maxlength="20" required="required" id="passwordUserUpdate" name="passwordUserUpdate" class="text-field-popup"/></td>
                        </tr>
                        <tr id="roleUserTr">
                            <td>Роль</td>
                            <td>
                                <select id="roleUserUpdate" name="roleUserUpdate" class="text-field-popup">
                                    <c:forEach items="${roleList}" var="role">
                                        <c:if test="${role.idRole!=1}">
                                            <option value="${role.idRole}">${role.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr id="depUserTr">
                            <td>Кафедра</td>
                            <td>
                                <select id="departmentUserUpdate" name="departmentUserUpdate" class="text-field-popup">
                                    <c:forEach items="${depList}" var="dep">
                                        <option value="${dep.idDepartment}">${dep.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="bottom-div-zero">
                    <input type="submit" class="button green" value="Сохранить" name="update"/>
                    <input type="button" class="button gray" onclick="document.getElementById('update_popup').style.display='none';" value="Отмена"/>
                </div>
            </form>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('update_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ДОБАВЛЕНИЯ ПОЛЬЗОВАТЕЛЕЙ-->
<div id="insert_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:400px;">
            <div class="top-div">
                Добавить пользователя
            </div>
            <form action="/insertUser" autocomplete="off" method="POST">
                <div class="center-div-update">
                    <table class="popup-update-table">
                        <tr>
                            <td>Логин</td>
                            <td><input type="text"
                                       pattern="[A-Za-z0-9]{4,20}"
                                       title="Имя пользователя должно быть размером от 4 до 20 символов, а
                                            также должно содержать латинские буквы и/или цифры."
                                       minlength="4" maxlength="20" required="required" id="loginUserInsert" name="loginUserInsert" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Пароль</td>
                            <td><input type="text"
                                       pattern="[A-Za-z0-9]{4,20}"
                                       title="Пароль должен быть размером от 4 до 20 символов, а
                                            также должен содержать латинские буквы и/или цифры."
                                       minlength="4" maxlength="20" required="required" id="passwordUserInsert" name="passwordUserInsert" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Роль</td>
                            <td>
                                <select id="roleUserInsert" name="roleUserInsert" class="text-field-popup">
                                    <c:forEach items="${roleList}" var="role">
                                        <c:if test="${role.idRole!=1}">
                                            <option value="${role.idRole}">${role.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Кафедра</td>
                            <td>
                                <select id="departmentUserInsert" name="departmentUserInsert" class="text-field-popup">
                                    <c:forEach items="${depList}" var="dep">
                                        <option value="${dep.idDepartment}">${dep.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="bottom-div-zero">
                    <input type="submit" class="button green" value="Сохранить" name="insert"/>
                    <input type="button" class="button gray" onclick="document.getElementById('insert_popup').style.display='none';" value="Отмена"/>
                </div>
            </form>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('insert_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ВОССТАНОВЛЕНИЯ ВСЕХ ПОЛЬЗОВАТЕЛЕЙ -->
<div id="restore_all_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:140px;">
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
        <div class="popup-form" style="height:140px;">
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
        <div class="popup-form" style="height:140px;">
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
        <div class="popup-form" style="height:140px;">
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
        <form action="/deleteUser" method="POST" id="form-popup1" class="popup-form" style="height:140px;">
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
    Пользователь: ${sessionUser.login}
    <a href="<c:url value='/plans/admin' />">Назад</a>
</div>
<div class="center-block">
    <h2>Управление пользователями</h2>
    <table class="center-table">
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
                <td>${roleMap.get(user.idRole)}</td>
                <td>${depMap.get(user.idDepartment)}</td>
                <td>
                    <c:if test="${user.idRole!=1}">
                        <input type="button" class="button red" onclick="deleteRow(${user.idUser}, '${user.login}');" value="Удалить"/>
                    </c:if>
                    <input type="button" class="button blue" onclick="updateUser(${user.idUser}, '${user.login}', '${user.password}',
                        ${user.idDepartment}, ${user.idRole});" value="Редактировать"/>
                </td>
            </tr>
        </c:forEach>
    </table>
    <p>
        <input type="button" class="button purple" onclick="insertUser();" value="Добавить"/>
        <input type="button" class="button gray" onclick="restoreRow();" value="Восстановить"/>
    </p>
</div>
<div id="snackbar"><c:out value="${sessionScope.erMessage}"/></div>
<c:if test="${sessionScope.erMessage!=null}">
    <script>showErMessage();</script>
</c:if>
<div id="snackbar1"><c:out value="${sessionScope.message}"/></div>
<c:if test="${sessionScope.message!=null}">
    <script>showMessage();</script>
</c:if>
</body>
</html>

