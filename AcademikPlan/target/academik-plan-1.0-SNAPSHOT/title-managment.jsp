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
    <title>Управление учебными планами</title>
</head>
<body class="body">
<script type='text/javascript'>
    function restoreRow(){
        document.getElementById('restore_popup').style.display='block';
    }

    function restoreAll() {
        document.getElementById('restore_all_popup').style.display='block';
    }

    function restoreTitle(idpk, name){
        document.getElementById('restore_title_popup').style.display='block';
        var el=document.getElementById('idTitleRestore');
        el.value = idpk;
        document.getElementById('text-restore_title_popup').innerHTML = "Восстановить план '"+name+"'?";
    }

    function deleteRow(idpk, name){
        document.getElementById('delete_popup').style.display='block';
        var el=document.getElementById('idTitleDelete');
        el.value = idpk;
        document.getElementById('text-delete').innerHTML = "Удалить учебный план '"+name+"'?";
    }

    function clearAll() {
        document.getElementById('clear_all_popup').style.display='block';
    }

    function clearTitle(idpk, name){
        document.getElementById('clear_popup').style.display='block';
        var el=document.getElementById('idTitleClear');
        el.value = idpk;
        document.getElementById('text-clear_title_popup').innerHTML = "Очистить план "+name+" без возможности восстановления? ";
    }

    function insertTitle() {
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

    function updateRow(idpk, name, yearCreation, qualification, studyTime, studyLevel, idGroupDirection,
                       idDirection, idProfile, idDepartment){
        document.getElementById('update_popup').style.display='block';
        document.getElementById('idTitleUpdate').value = idpk;
        document.getElementById('nameUpdate').value = name;
        document.getElementById('yearCreationUpdate').value = yearCreation;
        document.getElementById('qualificationUpdate').value = qualification;
        document.getElementById('studyTimeUpdate').value = studyTime;
        document.getElementById('studyLevelUpdate').value = studyLevel;
        document.getElementById('groupDirectionUpdate').value = idGroupDirection;
        document.getElementById('directionUpdate').value = idDirection;
        document.getElementById('profileUpdate').value = idProfile;
        document.getElementById('departmentUpdate').value = idDepartment;
    }
</script>
<!-- ОКНО ВОССТАНОВЛЕНИЯ -->
<div id="restore_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Восстановить план
            </div>
            <div class="center-div">
                <table class="center-table">
                    <tr>
                        <th>Имя</th>
                        <th>Год составления</th>
                        <th>Квалификация</th>
                        <th>Кафедра</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${titleListUnvisible}" var="title">
                        <tr>
                            <td>${title.name}</td>
                            <td>${title.yearCreation}</td>
                            <td>${title.qualification}</td>
                            <td>${departmentMap.get(title.idDepartment)}</td>
                            <td>
                                <input type="submit" class="button red" onclick="clearTitle(${title.idTitle}, '${title.name}');" value="Очистить"/>
                                <input type="submit" class="button blue" onclick="restoreTitle(${title.idTitle}, '${title.name}');" value="Восстановить"/>
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
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ВОССТАНОВЛЕНИЯ ПЛАНА -->
<div id="restore_title_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:140px;">
            <div id="text-restore_title_popup" class="top-div">
            </div>
            <div class="bottom-div-two">
                <form action="/restoreTitle" method="POST">
                    <input type="number" hidden id="idTitleRestore" name="idTitleRestore"/>
                    <input type="submit" class="button blue" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('restore_title_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_title_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ОЧИСТКИ ВСЕХ ПЛАНОВ -->
<div id="clear_all_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:200px;">
            <div class="top-div" style="height:95px;">
                Очистить список удалённых планов без возможности восстановления?
            </div>
            <div class="bottom-div-two">
                <form action="/clearAllTitles" method="POST">
                    <input type="submit" class="button red" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('clear_all_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('clear_all_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ВОССТАНОВЛЕНИЯ ВСЕХ ПЛАНОВ -->
<div id="restore_all_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:140px;">
            <div class="top-div">
                Восстановить все удалённые планы?
            </div>
            <div class="bottom-div-two">
                <form action="/restoreAllTitles" method="POST">
                    <input type="submit" class="button blue" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('restore_all_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('restore_all_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО РЕДАКТИРОВАНИЯ ПЛАНОВ-->
<div id="update_popup" class="parent_popup">
    <div class="popup-big" style="margin: 5% auto;">
        <div class="popup-form" style="height:650px;">
            <div class="top-div">
                Редактировать учебный план
            </div>
            <form action="/updateTitle" autocomplete="off" method="POST">
                <div class="center-div-update" style="height: 500px;">
                    <input type="text" hidden id="idTitleUpdate" name="idTitleUpdate"/>
                    <table class="popup-update-table">
                        <tr>
                            <td>Отображаемое имя</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z0-9 ]{1,15}"
                                       title="Отображаемое имя учебного плана должно быть не более 15 символов и состоять из
                                       букв и/или цифр."
                                       minlength="1" maxlength="15" required="required" id="nameUpdate" name="nameUpdate" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Год составления</td>
                            <td><input type="text"
                                       pattern="[0-9]{4}"
                                       title="Год должен быть в формате ГГГГ."
                                       minlength="4" maxlength="4" required="required" id="yearCreationUpdate" name="yearCreationUpdate" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Квалификация</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z ]{1,20}"
                                       title="Квалификация должна быть не более 20 символов и состоять из букв."
                                       minlength="1" maxlength="20" required="required" id="qualificationUpdate" name="qualificationUpdate" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Время обучения</td>
                            <td><input type="text"
                                       pattern="[1-6]{1}"
                                       title="Время обучения должно быть однозначное число от 1 до 6."
                                       minlength="1" maxlength="1" required="required" id="studyTimeUpdate" name="studyTimeUpdate" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Уровень обучения</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z ]{1,40}"
                                       title="Уровень обучения должен быть не более 40 символов и состоять из букв."
                                       minlength="1" maxlength="40" required="required" id="studyLevelUpdate" name="studyLevelUpdate" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td style="width: 200px">Группа направления подготовки</td>
                            <td>
                                <select id="groupDirectionUpdate" name="groupDirectionUpdate" class="text-field-popup">
                                    <c:forEach items="${groupDirectionList}" var="dir">
                                        <option value="${dir.idGroupDirection}">${dir.number} ${dir.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Направления подготовки</td>
                            <td>
                                <select id="directionUpdate" name="directionUpdate" class="text-field-popup">
                                    <c:forEach items="${directionList}" var="dir">
                                        <option value="${dir.idDirection}">${dir.number} ${dir.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Профиль (направленность)</td>
                            <td>
                                <select id="profileUpdate" name="profileUpdate" class="text-field-popup">
                                    <c:forEach items="${profileList}" var="prof">
                                        <option value="${prof.idProfile}">${prof.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Кафедра</td>
                            <td>
                                <select id="departmentUpdate" name="departmentUpdate" class="text-field-popup">
                                    <c:forEach items="${departmentList}" var="dep">
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
<!-- ОКНО ДОБАВЛЕНИЯ ПЛАНОВ-->
<div id="insert_popup" class="parent_popup">
    <div class="popup-big" style="margin: 5% auto;">
        <div class="popup-form" style="height:650px;">
            <div class="top-div">
                Добавить учебный план
            </div>
            <form action="/insertTitle" autocomplete="off" method="POST">
                <div class="center-div-update" style="height: 500px;">
                    <table class="popup-update-table">
                        <tr>
                            <td>Отображаемое имя</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z0-9 ]{1,15}"
                                       title="Отображаемое имя учебного плана должно быть не более 15 символов и состоять из
                                       букв и/или цифр."
                                       minlength="1" maxlength="15" required="required" id="nameInsert" name="nameInsert" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Год составления</td>
                            <td><input type="text"
                                       pattern="[0-9]{4}"
                                       title="Год должен быть в формате ГГГГ."
                                       minlength="4" maxlength="4" required="required" id="yearCreationInsert" name="yearCreationInsert" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Квалификация</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z ]{1,20}"
                                       title="Квалификация должна быть не более 20 символов и состоять из букв."
                                       minlength="1" maxlength="20" required="required" id="qualificationInsert" name="qualificationInsert" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Время обучения</td>
                            <td><input type="text"
                                       pattern="[1-8]{1}"
                                       title="Время обучения должно быть однозначное число от 1 до 8."
                                       minlength="1" maxlength="1" required="required" id="studyTimeInsert" name="studyTimeInsert" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td>Уровень обучения</td>
                            <td><input type="text"
                                       pattern="^(?![ ])[А-Яа-яA-Za-z ]{1,40}"
                                       title="Уровень обучения должен быть не более 40 символов и состоять из букв."
                                       minlength="1" maxlength="40" required="required" id="studyLevelInsert" name="studyLevelInsert" class="text-field-popup"/></td>
                        </tr>
                        <tr>
                            <td style="width: 200px">Группа направления подготовки</td>
                            <td>
                                <select id="groupDirectionInsert" name="groupDirectionInsert" class="text-field-popup">
                                    <c:forEach items="${groupDirectionList}" var="dir">
                                        <option value="${dir.idGroupDirection}">${dir.number} ${dir.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Направления подготовки</td>
                            <td>
                                <select id="directionInsert" name="directionInsert" class="text-field-popup">
                                    <c:forEach items="${directionList}" var="dir">
                                        <option value="${dir.idDirection}">${dir.number} ${dir.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Профиль (направленность)</td>
                            <td>
                                <select id="profileInsert" name="profileInsert" class="text-field-popup">
                                    <c:forEach items="${profileList}" var="prof">
                                        <option value="${prof.idProfile}">${prof.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Кафедра</td>
                            <td>
                                <select id="departmentInsert" name="departmentInsert" class="text-field-popup">
                                    <c:forEach items="${departmentList}" var="dep">
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
<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ ПЛАНА -->
<div id="delete_popup" class="parent_popup">
    <div class="popup">
        <form action="/deleteTitle" method="POST" id="form-popup1" class="popup-form" style="height:140px;">
            <div id="text-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idTitleDelete" name="idTitleDelete"/>
                <input type="submit" class="button red" value="Подтвердить"/>
                <input type="button" class="button gray" onclick="document.getElementById('delete_popup').style.display='none';" value="Отмена"/>
            </div>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('delete_popup').style.display='none';">X</a></div>
</div>
<!-- ОКНО ПОДТВЕРЖДЕНИЯ ОЧИСТКИ ПЛАНА -->
<div id="clear_popup" class="parent_popup">
    <div class="popup" style="margin: 20% auto;">
        <div class="popup-form" style="height:150px;">
            <div id="text-clear_title_popup" class="top-div" style="height:50px;">
            </div>
            <div class="bottom-div-two">
                <form action="/clearTitle" method="POST">
                    <input type="number" hidden id="idTitleClear" name="idTitleClear"/>
                    <input type="submit" class="button red" value="Подтвердить"/>
                    <input type="button" class="button gray" onclick="document.getElementById('clear_popup').style.display='none';" value="Отмена"/>
                </form>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('clear_popup').style.display='none';">X</a></div>
</div>
<!-- ОСНОВНОЕ ОКНО -->
<div class="top-panel">
    Пользователь: ${sessionUser.login}
    <a href="<c:url value='/plans' />">Назад</a>
</div>
<div class="center-block">
    <h2>Управление учебными планами</h2>
    <table class="center-table">
        <tr>
            <th>Имя</th>
            <th>Год составления</th>
            <th>Квалификация</th>
            <th>Кафедра</th>
            <th></th>
        </tr>
        <c:forEach items="${titleListVisible}" var="title">
                <tr>
                    <td>${title.name}</td>
                    <td>${title.yearCreation}</td>
                    <td>${title.qualification}</td>
                    <td>${departmentMap.get(title.idDepartment)}</td>
                    <td>
                        <input type="button" class="button red" onclick="deleteRow(${title.idTitle}, '${title.name}');" value="Удалить"/>
                        <input type="button" class="button blue" onclick="updateRow(${title.idTitle}, '${title.name}',
                            ${title.yearCreation}, '${title.qualification}', ${title.studyTime}, '${title.studyLevel}',
                            ${title.idGroupDirection}, ${title.idDirection}, ${title.idProfile}, ${title.idDepartment});" value="Редактировать"/>
                    </td>
                </tr>
        </c:forEach>
    </table>
    <p>
        <input type="button" class="button purple" onclick="insertTitle();" value="Добавить"/>
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

