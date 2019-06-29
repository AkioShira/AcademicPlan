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
    <title>Титул </title>
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


</script>
<body>
<div class="wrapper">
    <div class = "menu">
        <ul>
            <li>
                <form action="/title" method="POST">
                    <input type="text" hidden name="idTitle" value="${title.idTitle}"/>
                    <input type="submit" value="ТИТУЛ" class="button menu" style="width: 100px;"/>
                </form>
            </li>
            <c:forEach items="${cycleList}" var="cycle">
                <li>
                    <form action="/cycle" method="POST">
                        <input type="text" hidden name="idCycle" value="${cycle.idCycle}"/>
                        <input type="submit" value="${cycle.shortName}" class="button menu" style="width: 100px;"/>
                    </form>
                </li>
            </c:forEach>
            <li>
                <form action="/result" method="GET">
                    <input type="submit" value="ИТОГ" class="button menu" style="width: 100px;"/>
                </form>
            </li>
            <li>
                <form action="/plans" method="GET">
                    <input type="submit" value="Назад" class="button menu" style="width: 100px;"/>
                </form>
            </li>
        </ul>
    </div>

    <div class="toolbar">
        <form>
            <input type="button" onclick="showControl();" value="Контроль версий" class="button purple" style="width: 180px;"/>
        </form>
        <form>
            <input type="button" onclick="showCycle();" value="Редактировать циклы" class="button green" style="width: 180px;"/>
        </form>
        <form>
            <input type="button" onclick="showPracts();" value="Редактировать практики" class="button green" style="width: 180px;"/>
        </form>
        <form>
            <input type="button" onclick="showSertification();" value="Редактировать аттестации" class="button green" style="width: 180px;"/>
        </form>
        <form action="/toPdf" method="POST">
            <input type="submit" value="Экспорт в PDF" class="button gray"/>
        </form>
    </div>

    <div style="height: calc(100% - (120px));overflow: auto;">
        <div class="center-block custom-scrollbar">
            <form action="/updateTitlePage" method="POST">
                <input type="text" hidden id="idTitle" name="idTitle" value="${title.idTitle}"/>
            <div class="content-block" style="padding-bottom: 400px;">
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
                                И.о. ректора _____ <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z,.- ]{1,50}"
                                                          title="Имя ректора должно быть не более 50 символов и состоять из букв."
                                                          minlength="1" maxlength="50" style="width: 200px;" class="text-field"
                                                          required="required" name="rectorName" value="${name.rectorName}"/><br>
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
                                    ${title.studyTime}
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
                        <c:forEach items="${stateList}" var="state" varStatus="status">
                        <tr>
                            <td>Государственная итоговая аттестация</td>
                            <td>
                                <select id="stateType${status.count}" name="stateType${status.count}" class="text-field" style="font-size: 12px">
                                    <c:forEach items="${stateTypes}" var="type">
                                        <option value="${type.idSertificationType}">${type.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><input type="text" pattern="[0-9]{1,2}"
                                       title="Семестр должен состоять из цифр."
                                       required="required" maxlength="2" style="width: 20px" class="text-field-n" name="state${status.count}" value="${state.semester}"/></td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
                <div style = "width: 100%; height: 100px; float: left;">
                    <input type="submit" value="Сохранить" class="button" style="float: right; margin: 50px 50px 10px 10px;"/>
                </div>
            </div>
            </form>
        </div>
    </div>

</div>

<%@ include file="/title-pract.jsp" %>
<%@ include file="/title-sertification.jsp" %>
<%@ include file="/title-cycle.jsp" %>
<%@ include file="/title-control.jsp" %>

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
    <c:forEach items="${stateList}" var="state" varStatus="status">
        document.getElementById('stateType${status.count}').value = ${state.idSertificationType};
    </c:forEach>
</script>
</body>
</html>
