<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 30.03.2019
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style><%@ include file="/styles/title.css" %>
    <%@ include file="/styles/message.css" %>
    <%@ include file="/styles/popup.css" %></style>
<html>
<head>
    <meta charset="utf-8">
    <title>Учебные планы </title>
</head>
<script type='text/javascript'>
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

    function showPracts(){
        document.getElementById('pract_popup').style.display='block';
    }

    function deletePract(idpk, name){
        document.getElementById('delete_popup').style.display='block';
        var el=document.getElementById('idPractDelete');
        el.value = idpk;
        document.getElementById('text-delete').innerHTML = "Удалить практику '"+name+"'?";
    }

    function addPract() {
        document.getElementById('insert_popup').style.display='block';
    }
</script>
<body>
<div class="wrapper">
    <div class = "menu">
        <ul>
            <li><a >ТИТУЛ</a></li>
            <li><a href="<c:url value='/plans' />">Назад</a></li>
        </ul>
    </div>

    <div style="height: calc(100% - (120px));overflow: auto;">
        <div class="center-block custom-scrollbar">
            <form action="/updateTitlePage" method="POST">
                <input type="text" hidden id="idTitle" name="idTitle" value="${title.idTitle}"/>
            <div class="content-block">
                <div style="font-size: 14px;">
                    <table style="width: 100%;">
                        <tr style="text-align:center;">
                            <td style="font-weight: bold;" colspan="2">
                                ${titleContent.get(0).value} <br>
                                ${titleContent.get(1).value}
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 100px">
                                <h4>${titleContent.get(2).value}</h4>
                                И.о. ректора _____ ${titleContent.get(3).value}<br>
                                "__"____ <input type="text" pattern="[0-9]{4}"
                                                title="Год должен быть в формате ГГГГ."
                                                minlength="4" maxlength="4" style="width: 60px" class="text-field"
                                                required="required" name="yearCreation" value="${title.yearCreation}"/> г.<br>
                                ${titleContent.get(4).value} ___.___.${title.yearCreation}г. №__
                            </td>
                            <td style="text-align: right; padding-right: 100px">
                                ${titleContent.get(5).value}
                                    <p>
                                        <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z ]{1,20}"
                                               title="Квалификация должна быть не более 20 символов и состоять из букв."
                                               minlength="1" maxlength="20" style="width: 200px" class="text-field" required="required" name="qualification" value="${title.qualification}"/>
                                    </p><br>
                                ${titleContent.get(6).value} <p>
                                    <input type="text" pattern="[1-8]{1}"
                                           title="Время обучения должно быть однозначное число от 1 до 8."
                                           minlength="1" style="width: 40px" class="text-field" required="required" name="studyTime" value="${title.studyTime}"/>
                                    г.</p><br>
                                ${titleContent.get(7).value} <p>среднего общего образования</p><br>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align:center;padding-top: 20px;">
                                <h3 style="margin-top:10px; display:inline-block;">${titleContent.get(8).value}</h3>
                                <h4 style="font-style:italic; display:inline-block;"> ${titleContent.get(9).value}</h4>
                                <p><input type="text" pattern="[0-9]{4}"
                                          title="Год должен быть в формате ГГГГ."
                                          minlength="4" maxlength="4" style="width: 60px" class="text-field" required="required" name="yearReception" value="${title.yearReception}"/></p>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 150px; font-size: 12px;">${titleContent.get(10).value}</td>
                            <td><p><input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z ]{1,40}"
                                          title="Уровень обучения должен быть не более 40 символов и состоять из букв."
                                          minlength="1" maxlength="40" style="width: 400px" class="text-field" required="required" name="studyLevel" value="${title.studyLevel}"/></p></td>
                        </tr>
                        <tr>
                            <td style="padding-left: 150px; font-size: 12px;">${titleContent.get(11).value}</td>
                            <td><p>
                                <select id="groupDirection" name="groupDirection" class="text-field">
                                    <c:forEach items="${groupDirectionList}" var="dir">
                                        <option value="${dir.idGroupDirection}">${dir.number} ${dir.name}</option>
                                    </c:forEach>
                                </select>
                            </p></td>
                        </tr>
                        <tr>
                            <td style="padding-left: 150px; font-size: 12px;">${titleContent.get(12).value}</td>
                            <td><p>
                                <select id="direction" name="direction" class="text-field">
                                    <c:forEach items="${directionList}" var="dir">
                                        <option value="${dir.idDirection}">${dir.number} ${dir.name}</option>
                                    </c:forEach>
                                </select>
                            </p></td>
                        </tr>
                        <tr>
                            <td style="padding-left: 150px; font-size: 12px;">${titleContent.get(13).value}</td>
                            <td><p>
                                <select id="profile" name="profile" class="text-field">
                                    <c:forEach items="${profileList}" var="prof">
                                        <option value="${prof.idProfile}">${prof.name}</option>
                                    </c:forEach>
                                </select>
                            </p></td>
                        </tr>
                        <tr>
                            <td style="padding-left: 150px; font-size: 12px;">${titleContent.get(14).value}</td>
                            <td><p><input type="text" maxlength="20" style="width: 200px" class="text-field" required="required" name="formEducation" value="${title.formEducation}"/></p></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="font-size: 10px;">${titleContent.get(15).value}</td>
                        </tr>
                    </table>
                </div>
                <div style = "width: 90%; margin: 0 auto;">
                    <h4 style="text-align: center;">${titleContent.get(18).value}</h4>
                    <!--ГРАФИК УЧЕБНОГО ПРОЦЕССА -->
                    <table border="1" style="width:100%">
                        <tr>
                            <td rowspan="4" class="rotatable">КУРС</td>
                            <td colspan="4">${titleShedules.get(0).value}</td>
                            <td colspan="5">${titleShedules.get(1).value}</td>
                            <td colspan="4">${titleShedules.get(2).value}</td>
                            <td colspan="4">${titleShedules.get(3).value}</td>
                            <td colspan="5">${titleShedules.get(4).value}</td>
                            <td colspan="4">${titleShedules.get(5).value}</td>
                            <td colspan="4">${titleShedules.get(6).value}</td>
                            <td colspan="4">${titleShedules.get(7).value}</td>
                            <td colspan="5">${titleShedules.get(8).value}</td>
                            <td colspan="4">${titleShedules.get(9).value}</td>
                            <td colspan="4">${titleShedules.get(10).value}</td>
                            <td colspan="5">${titleShedules.get(11).value}</td>
                        </tr>
                        <tr>
                            <c:forEach var = "i" begin = "1" end = "52">
                                <td><c:out value = "${i}"/></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <c:forEach items="${row0}" var="row">
                                <td>${row}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <c:forEach items="${row1}" var="row">
                                <td>${row}</td>
                            </c:forEach>
                        </tr>

                        <c:forEach var = "i" begin = "0" end = "${title.studyTime-1}">
                        <tr>
                            <td>${courses[i]}</td>
                            <c:forEach items="${sheduleList.get(i)}" var="shedule">
                                <td><input type="text" pattern="К|СК|С|П|Н|Г|Д"
                                           title="В графике учебного процесса должны быть только буквы представленные в обозначениях."
                                           maxlength="2" class="text-field-n" name="shedule${i+1}" value="${shedule.label}"/></td>
                            </c:forEach>
                        </tr>
                        </c:forEach>
                    </table>
                    <h4>${titleContent.get(16).value}</h4>
                    <p style="text-align: center; text-decoration: none;">${titleContent.get(17).value}</p>
                </div>
                <!-- Сводные данные о бюджете времени -->
                <div style="width: 500px; float: left; padding-top: 10px; padding-left: 60px;">
                    <h4 style="text-align: center;">${titleContent.get(19).value}</h4>
                    <table border="1" style="font-size: 14px; text-align: center;">
                        <tr style="height: 100px;">
                        <c:forEach items="${titleBudget}" var="budget">
                            <td class="rotatable">${budget.value}</td>
                        </c:forEach>
                        </tr>
                        <c:forEach var = "i" begin = "0" end = "${title.studyTime-1}">
                            <tr>
                                <td>${courses[i]}</td>
                                <td>${budgets.get(i).theory}</td>
                                <td>${budgets.get(i).exam}</td>
                                <td>${budgets.get(i).practic}</td>
                                <td>${budgets.get(i).qualification}</td>
                                <td>${budgets.get(i).stateExam}</td>
                                <td>${budgets.get(i).holidays}</td>
                                <td>${budgets.get(i).all}</td>
                            </tr>
                        </c:forEach>
                        <tr style="font-weight: bold;">
                            <td>Всего</td>
                            <td>${budgets.get(title.studyTime).theory}</td>
                            <td>${budgets.get(title.studyTime).exam}</td>
                            <td>${budgets.get(title.studyTime).practic}</td>
                            <td>${budgets.get(title.studyTime).qualification}</td>
                            <td>${budgets.get(title.studyTime).stateExam}</td>
                            <td>${budgets.get(title.studyTime).holidays}</td>
                            <td>${budgets.get(title.studyTime).all}</td>
                        </tr>
                    </table>
                </div>
                <!-- Таблица практики -->
                <div style="width: 350px; float: left; padding-top: 10px;">
                    <h4 style="text-align: center;">${titleContent.get(20).value}</h4>
                    <table border="1" style="font-size: 14px; text-align: center;">
                        <tr style="height: 100px;">
                            <c:forEach items="${titlePractics}" var="pract">
                                <td>${pract.value}</td>
                            </c:forEach>
                        </tr>
                        <c:forEach items="${practList}" var="pract" varStatus="status">
                        <tr>
                            <td>
                                <select id="practType${status.count}" name="practType${status.count}" class="text-field" style="font-size: 12px">
                                    <c:forEach items="${practTypes}" var="type">
                                        <option value="${type.idPractType}">${type.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><input type="text" pattern="[0-9]{1,2}"
                                       title="Семестр должен состоять из цифр."
                                       required="required" maxlength="2" class="text-field-n" name="pract${status.count}" value="${pract.semester}"/></td>
                            <td><input type="text" pattern="[0-9]{1,2}"
                                       title="Недели должны состоять из цифр."
                                       required="required" maxlength="2" class="text-field-n" name="pract${status.count}" value="${pract.week}"/></td>
                        </tr>
                        </c:forEach>

                    </table>
                </div>
                <!-- Таблица гос аттестации -->
                <div style="width: 500px; float: left; padding-top: 10px;">
                    <h4 style="text-align: center;">${titleContent.get(21).value}</h4>
                    <table border="1" style="font-size: 14px; text-align: center;">
                        <tr style="height: 100px;">
                            <c:forEach items="${titleState}" var="state">
                                <td>${state.value}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td>Государственная итоговая аттестация</td>
                            <td>Государственный экзамен</td>
                            <td><input type="text" pattern="[0-9]{1,2}"
                                       title="Семестр должен состоять из цифр."
                                       required="required" maxlength="2" style="width: 20px" class="text-field-n" name="state" value="${stateList.get(0).semester}"/></td>
                        </tr>
                        <tr>
                            <td>Государственная итоговая аттестация</td>
                            <td>Выпускная квалификационная работа</td>
                            <td><input type="text" pattern="[0-9]{1,2}"
                                       title="Семестр должен состоять из цифр."
                                       required="required" maxlength="2" style="width: 20px" class="text-field-n" name="state" value="${stateList.get(1).semester}"/></td>
                        </tr>
                    </table>
                </div>
                <div style = "width: 100%; height: 100px; float: left;">
                    <input type="submit" value="Сохранить" class="button" style="float: right; margin: 50px 50px 10px 10px;"/>
                </div>
            </div>
            </form>
        </div>
    </div>
    <div class="toolbar">
        <form>
            <input type="button" onclick="showPracts();" value="Редактировать практики" class="button green" style="width: 180px;"/>
        </form>
        <form action="/toPdf" method="POST">
            <input type="submit" value="Экспорт в PDF" class="button gray"/>
        </form>
    </div>
</div>

<!-- РЕДАКТИРОВАТЬ ПРАКТИКИ -->
<div id="pract_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Редактировать практики
            </div>
            <div class="center-div">
                <table class="center-table">
                    <tr>
                        <th>Название практики</th>
                        <th>Семестр</th>
                        <th>Недели</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${practList}" var="pract" varStatus="status">
                        <tr>
                            <td>${typeMap.get(pract.idPractType)}</td>
                            <td>${pract.semester}</td>
                            <td>${pract.week}</td>
                            <td>
                                <c:if test="${status.count!=1}">
                                    <input type="button" class="button red button-little" onclick="deletePract(${pract.idPract}, '${typeMap.get(pract.idPractType)}');" value="Удалить"/>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
            <div style = "padding: 20px 250px 0px 250px;">
                <c:if test="${practList.size()<=6}">
                    <input type="button" class="button blue button-little" onclick="addPract();" value="Добавить" name="restore-all"/>
                </c:if>
                <input type="button" class="button gray button-little" onclick="document.getElementById('pract_popup').style.display='none';" value="Отмена"/>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('pract_popup').style.display='none';">X</a></div>
</div>

<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ СТРОКИ -->
<div id="delete_popup" class="parent_popup">
    <div class="popup">
        <form action="/deletePract" method="POST" id="form-popup1" class="popup-form" style="height:140px;">
            <div id="text-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idPractDelete" name="idPractDelete"/>
                <input type="submit" class="button red button-little" value="Подтвердить"/>
                <input type="button" class="button gray button-little" onclick="document.getElementById('delete_popup').style.display='none';" value="Отмена"/>
            </div>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('delete_popup').style.display='none';">X</a>
    </div>
</div>
<!-- ОКНО ДОБАВЛЕНИЯ ПРАКТИКИ-->
<div id="insert_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:250px;">
            <div class="top-div">
                Добавить практику
            </div>
            <form action="/insertPract" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:100px;">
                    <table class="center-table" style="width: 600px;">
                        <tr>
                            <td style="width: 150px; font-size: 16px;">Название практики</td>
                            <td>
                                <select id="practInsert" name="practInsert" class="text-field" style="width: 90%; height: 30px;">
                                    <c:forEach items="${practTypes}" var="type">
                                        <option value="${type.idPractType}">${type.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="bottom-div-zero">
                    <input type="submit" class="button green button-little" value="Сохранить" name="insert"/>
                    <input type="button" class="button gray button-little" onclick="document.getElementById('insert_popup').style.display='none';" value="Отмена"/>
                </div>
            </form>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('insert_popup').style.display='none';">X</a></div>
</div>
<div id="snackbar"><c:out value="${sessionScope.erMessage}"/></div>
<c:if test="${sessionScope.erMessage!=null}">
    <script>showErMessage();</script>
</c:if>
<div id="snackbar1"><c:out value="${sessionScope.message}"/></div>
<c:if test="${sessionScope.message!=null}">
    <script>showMessage();</script>
</c:if>
<script>
    document.getElementById('groupDirection').value = ${title.idGroupDirection};
    document.getElementById('direction').value = ${title.idDirection};
    document.getElementById('profile').value = ${title.idProfile};
    <c:forEach items="${practList}" var="pract" varStatus="status">
        document.getElementById('practType${status.count}').value = ${pract.idPractType};
    </c:forEach>
</script>
</body>
</html>
