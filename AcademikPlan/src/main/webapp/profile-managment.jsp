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
    <%@ include file="/styles/faculty-managment.css" %>
    <%@ include file="/styles/popup.css" %>
    <%@ include file="/styles/message.css" %>
</style>
<html>
<head>
    <meta charset="utf-8">
    <title>Управление профилями (направленность)</title>
</head>
<body class="body">
<script type='text/javascript'>
    function deleteRow(idpk){
        document.getElementById('delete_popup').style.display='block';
        var el=document.getElementById('idProfileDelete');
        el.value = idpk;
        document.getElementById('text-delete').innerHTML = "Удалить профиль?";
    }

    function insertProfile() {
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

    function updateRow(idpk, name){
        document.getElementById('update_popup').style.display='block';
        document.getElementById('idProfileUpdate').value = idpk;
        document.getElementById('nameUpdate').value = name;
    }
</script>
<!-- ОКНО РЕДАКТИРОВАНИЯ ПРОФИЛЯ-->
<div id="update_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:250px;">
            <div class="top-div">
                Редактирование профиля
            </div>
            <form action="/updateProfile" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:100px;">
                    <input type="text" hidden id="idProfileUpdate" name="idProfileUpdate"/>
                    <table class="popup-update-table" style="width: 800px;">
                        <tr>
                            <td style="width: 150px">Имя профиля</td>
                            <td><input type="text"
                                       pattern="^(?![ .])[А-Яа-яA-Za-z0-9. ]{5,100}"
                                       title="Имя профиля должно быть размером от 5 до 100 символов, а
                                            также должно содержать буквы и/или цифры."
                                       minlength="5" maxlength="100" required="required" id="nameUpdate" name="nameUpdate" class="text-field-popup"/></td>
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
<!-- ОКНО ДОБАВЛЕНИЯ ПРОФИЛЯ-->
<div id="insert_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:250px;">
            <div class="top-div">
                Добавить профиль
            </div>
            <form action="/insertProfile" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:100px;">
                    <table class="popup-update-table" style="width: 800px;">
                        <tr>
                            <td style="width: 150px">Имя профиля</td>
                            <td><input type="text"
                                       pattern="^(?![ .])[А-Яа-яA-Za-z0-9. ]{5,100}"
                                       title="Имя профиля должно быть размером от 5 до 100 символов, а
                                            также должно содержать буквы и/или цифры."
                                       minlength="5" maxlength="100" required="required" id="nameInsert" name="nameInsert" class="text-field-popup"/></td>
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
<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ ПРОФИЛЯ -->
<div id="delete_popup" class="parent_popup">
    <div class="popup">
        <form action="/deleteProfile" method="POST" id="form-popup1" class="popup-form" style="height:140px;">
            <div id="text-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idProfileDelete" name="idProfileDelete"/>
                <input type="submit" class="button red" value="Подтвердить"/>
                <input type="button" class="button gray" onclick="document.getElementById('delete_popup').style.display='none';" value="Отмена"/>
            </div>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('delete_popup').style.display='none';">X</a>
    </div>
</div>
<!-- ОСНОВНОЕ ОКНО -->
<div class="top-panel">
    Пользователь: ${sessionUser.login}
    <a href="<c:url value='/plans/admin' />">Назад</a>
</div>
<div class="center-block">
    <h2>Управление профилями</h2>
    <table class="center-table">
        <tr>
            <th>Имя профиля (направленности)</th>
            <th></th>
        </tr>
        <c:forEach items="${profileList}" var="profile">
                <tr>
                    <td>${profile.name}</td>
                    <td>
                        <input type="button" class="button red" onclick="deleteRow(${profile.idProfile});" value="Удалить"/>
                        <input type="button" class="button blue" onclick="updateRow(${profile.idProfile}, '${profile.name}');" value="Редактировать"/>
                    </td>
                </tr>
        </c:forEach>
    </table>
    <p>
        <input type="button" class="button purple" onclick="insertProfile();" value="Добавить"/>
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

