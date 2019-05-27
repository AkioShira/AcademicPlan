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
    <%@ include file="/styles/faculty-managment.css" %>
    <%@ include file="/styles/popup.css" %>
    <%@ include file="/styles/message.css" %>
</style>
<html>
<head>
    <meta charset="utf-8">
    <title>Управление видами государственных аттестаций</title>
</head>
<body class="body">
<script type='text/javascript'>
    function deleteRow(idpk){
        document.getElementById('delete_popup').style.display='block';
        var el=document.getElementById('idSertificationDelete');
        el.value = idpk;
        document.getElementById('text-delete').innerHTML = "Удалить вид аттестации?";
    }

    function insertPractic() {
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
        document.getElementById('idSertificationUpdate').value = idpk;
        document.getElementById('nameUpdate').value = name;
    }
</script>
<!-- ОКНО РЕДАКТИРОВАНИЯ ГОС АТТЕСТАЦИЙ-->
<div id="update_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:250px;">
            <div class="top-div">
                Редактирование вида итоговой государственной аттестации
            </div>
            <form action="/updateSertificationType" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:100px;">
                    <input type="text" hidden id="idSertificationUpdate" name="idSertificationUpdate"/>
                    <table class="popup-update-table" style="width: 800px;">
                        <tr>
                            <td style="width: 150px">Наименование вида</td>
                            <td><input type="text"
                                       pattern="^(?![ .])[А-Яа-яA-Za-z ]{1,50}"
                                       title="Наименование вида гос. аттестации должно быть размером от 1 до 50 символов и состоять из букв."
                                       minlength="1" maxlength="50" required="required" id="nameUpdate" name="nameUpdate" class="text-field-popup"/></td>
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
                Добавить вид итоговой государственной аттестации
            </div>
            <form action="/insertSertificationType" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:100px;">
                    <table class="popup-update-table" style="width: 800px;">
                        <tr>
                            <td style="width: 150px">Наименование вида</td>
                            <td><input type="text"
                                       pattern="^(?![ .])[А-Яа-яA-Za-z ]{1,50}"
                                       title="Наименование вида гос. аттестации должно быть размером от 1 до 50 символов и состоять из букв."
                                       minlength="1" maxlength="50" required="required" id="nameInsert" name="nameInsert" class="text-field-popup"/></td>
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
        <form action="/deleteSertificationType" method="POST" id="form-popup1" class="popup-form" style="height:140px;">
            <div id="text-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idSertificationDelete" name="idSertificationDelete"/>
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
    <h2>Управление видами государственных аттестаций</h2>
    <table class="center-table">
        <tr>
            <th>Наименование вида</th>
            <th></th>
        </tr>
        <c:forEach items="${stateList}" var="state">
                <tr>
                    <td>${state.name}</td>
                    <td>
                        <input type="button" class="button red" onclick="deleteRow(${state.idSertificationType});" value="Удалить"/>
                        <input type="button" class="button blue" onclick="updateRow(${state.idSertificationType}, '${state.name}');" value="Редактировать"/>
                    </td>
                </tr>
        </c:forEach>
    </table>
    <p>
        <input type="button" class="button purple" onclick="insertPractic();" value="Добавить"/>
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

