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
    <%@ include file="/styles/department-managment.css" %>
    <%@ include file="/styles/popup.css" %>
    <%@ include file="/styles/message.css" %>
</style>
<html>
<head>
    <meta charset="utf-8">
    <title>Управление кафедрами</title>
</head>
<body class="body">
<script type='text/javascript'>
    function deleteRow(idpk, name){
        document.getElementById('delete_popup').style.display='block';
        var el=document.getElementById('idDepartmentDelete');
        el.value = idpk;
        document.getElementById('text-delete').innerHTML = "Удалить кафедру "+name+"?";
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

    function updateRow(idpk, name, shortName){
        document.getElementById('update_popup').style.display='block';
        document.getElementById('idDapUpdate').value = idpk;
        document.getElementById('nameUpdate').value = name;
        document.getElementById('shortNameUpdate').value = shortName;
    }

    function restoreRow(){
        document.getElementById('restore_popup').style.display='block';
    }

    function restoreDepartment(idpk, name){
        document.getElementById('restore_department_popup').style.display='block';
        var el=document.getElementById('idDepartmentRestore');
        el.value = idpk;
        document.getElementById('text-restore_department_popup').innerHTML = "Восстановить кафедру "+name+"?";
    }

    function restoreAll() {
        document.getElementById('restore_all_popup').style.display='block';
    }

    function clearAll() {
        document.getElementById('clear_all_popup').style.display='block';
    }

    function clearDepartment(idpk, name){
        document.getElementById('clear_popup').style.display='block';
        var el=document.getElementById('idDepartmentClear');
        el.value = idpk;
        document.getElementById('text-clear_department_popup').innerHTML = "Очистить кафедру "+name+" без возможности восстановления? " +
            "(все пользователи и данные, связанные с этой кафедрой, будут удалены)";
    }
</script>

<!-- ОКНО ВОССТАНОВЛЕНИЯ -->
<div id="restore_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Восстановить кафедры
            </div>
            <div class="center-div">
                <table class="center-table">
                    <tr>
                        <th>Имя кафедры</th>
                        <th>Сокращение</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${depListUnvisible}" var="dep">
                        <tr>
                            <td>${dep.name}</td>
                            <td>${dep.shortName}</td>
                            <td>
                                <input type="submit" class="button red" onclick="clearDepartment(${dep.idDepartment}, '${dep.shortName}');" value="Очистить"/>
                                <input type="submit" class="button blue" onclick="restoreDepartment(${dep.idDepartment}, '${dep.shortName}');" value="Восстановить"/>
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
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ОЧИСТКИ ВСЕХ ПОЛЬЗОВАТЕЛЕЙ -->
<div id="clear_all_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:200px;">
            <div class="top-div" style="height:95px;">
                Очистить список удалённых кафедр без возможности восстановления? (все пользователи и данные, связанные с этой кафедрой, будут удалены)
            </div>
            <div class="bottom-div-two">
                <form action="/clearAllDepartments" method="POST">
                    <input type="submit" class="button red" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('clear_all_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('clear_all_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ОЧИСТКИ СТРОКИ -->
<div id="clear_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:200px;">
            <div id="text-clear_department_popup" class="top-div" style="height:95px;">
            </div>
            <div class="bottom-div-two">
                <form action="/clearDepartment" method="POST">
                    <input type="number" hidden id="idDepartmentClear" name="idDepartmentClear"/>
                    <input type="submit" class="button red" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('clear_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('clear_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ВОССТАНОВЛЕНИЯ ВСЕХ КАФЕДР -->
<div id="restore_all_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:140px;">
            <div class="top-div">
                Восстановить всех удалённые кафедры?
            </div>
            <div class="bottom-div-two">
                <form action="/restoreAllDepartments" method="POST">
                    <input type="submit" class="button blue" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('restore_all_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_all_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ВОССТАНОВЛЕНИЯ КАФЕДРЫ -->
<div id="restore_department_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:140px;">
            <div id="text-restore_department_popup" class="top-div">
            </div>
            <div class="bottom-div-two">
                <form action="/restoreDepartment" method="POST">
                    <input type="number" hidden id="idDepartmentRestore" name="idDepartmentRestore"/>
                    <input type="submit" class="button blue" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('restore_department_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_department_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО РЕДАКТИРОВАНИЯ КАФЕДРЫ-->
<div id="update_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:300px;">
            <div class="top-div">
                Редактирование кафедры
            </div>
            <form action="/updateDepartment" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:150px;">
                    <input type="text" hidden id="idDapUpdate" name="idDapUpdate"/>
                    <table class="popup-update-table" style="width: 600px;">
                        <tr>
                            <td>Имя кафедры</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z0-9 ]{4,100}"
                                       title="Имя кафедры должно быть размером от 4 до 100 символов, а
                                            также должно содержать буквы и/или цифры."
                                       minlength="4" maxlength="100" required="required" id="nameUpdate" name="nameUpdate" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Сокращение</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z0-9 ]{1,20}"
                                       title="Сокращение кафедры должно быть размером от 1 до 20 символов, а
                                            также должно содержать буквы и/или цифры."
                                       minlength="1" maxlength="20" required="required" id="shortNameUpdate" name="shortNameUpdate" class="text-field-popup"/></td>
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
<!-- ОКНО ДОБАВЛЕНИЯ КАФЕДРЫ-->
<div id="insert_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:300px;">
            <div class="top-div">
                Добавить кафедру
            </div>
            <form action="/insertDepartment" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:150px;">
                    <table class="popup-update-table" style="width: 600px;">
                        <tr>
                            <td>Имя кафедры</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z0-9 ]{4,100}"
                                       title="Имя кафедры должно быть размером от 4 до 100 символов, а
                                            также должно содержать буквы и/или цифры."
                                       minlength="4" maxlength="100" required="required" id="nameInsert" name="nameInsert" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Сокращение</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z0-9 ]{1,20}"
                                       title="Сокращение кафедры должно быть размером от 1 до 20 символов, а
                                            также должно содержать буквы и/или цифры."
                                       minlength="1" maxlength="10" required="required" id="shortNameInsert" name="shortNameInsert" class="text-field-popup"/></td>
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
<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ СТРОКИ -->
<div id="delete_popup" class="parent_popup">
    <div class="popup">
        <form action="/deleteDepartment" method="POST" id="form-popup1" class="popup-form" style="height:140px;">
            <div id="text-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idDepartmentDelete" name="idDepartmentDelete"/>
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
    <h2>Управление кафедрами</h2>
    <table class="center-table">
        <tr>
            <th>Имя кафедры</th>
            <th>Сокращение</th>
            <th></th>
        </tr>
        <c:forEach items="${depListVisible}" var="dep">
            <tr>
                <td>${dep.name}</td>
                <td>${dep.shortName}</td>
                <td>
                    <c:if test="${dep.idDepartment!=1}">
                        <input type="button" class="button red" onclick="deleteRow(${dep.idDepartment}, '${dep.shortName}');" value="Удалить"/>
                    </c:if>
                    <input type="button" class="button blue" onclick="updateRow(${dep.idDepartment}, '${dep.name}', '${dep.shortName}');" value="Редактировать"/>
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

