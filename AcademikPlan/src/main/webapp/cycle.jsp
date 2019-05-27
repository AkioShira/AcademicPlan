<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 30.03.2019
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style><%@ include file="/styles/title.css" %>
<%@ include file="/styles/cycle.css" %>
    <%@ include file="/styles/message.css" %>
    <%@ include file="/styles/popup.css" %></style>
<fmt:setLocale value="en_US"/>
<html>
<head>
    <meta charset="utf-8">
    <title>Цикл</title>
</head>
<script type='text/javascript'>
    function deleteSubject(idpk, name){
        document.getElementById('delete_subject_popup').style.display='block';
        var el=document.getElementById('idSubjectDelete');
        el.value = idpk;
        document.getElementById('text-subject-delete').innerHTML = "Удалить дисциплину '"+name+"'?";
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
                <form action="/plans" method="GET">
                    <input type="submit" value="Назад" class="button menu" style="width: 100px;"/>
                </form>
            </li>
        </ul>
    </div>

    <div style="height: calc(100% - (120px));overflow: auto;">
        <div class="center-block custom-scrollbar">
            <form action="/updateCyclePage" method="POST">
                <input type="text" hidden id="idCycle" name="idCycle" value="${cycle.idCycle}"/>
                <div class="content-block" style="width: ${1600 + title.studyTime*100}px; padding-bottom: 130px;">
                    <table class = "cycle-table">
                        <tr>
                            <td rowspan="4" style="width: 100px; max-width: 100px;">${cycleContent.get(0).value}</td>
                            <td rowspan="4" style="max-width: 200px">${cycleContent.get(1).value}</td>
                            <td rowspan="4" style="max-width: 100px" class="rotatable">${cycleContent.get(2).value}</td>
                            <td rowspan="4" style="max-width: 30px" class="rotatable">${cycleContent.get(3).value}</td>
                            <td rowspan="4" style="max-width: 30px" class="rotatable">${cycleContent.get(4).value}</td>
                            <td rowspan="4" style="max-width: 30px" class="rotatable">${cycleContent.get(5).value}</td>
                            <td rowspan="4" style="max-width: 30px" class="rotatable">${cycleContent.get(6).value}</td>
                            <td colspan="7" style="max-width: 290px">${cycleContent.get(7).value}</td>
                            <td colspan="${title.studyTime*8}">
                                ${cycleContent.get(8).value}
                            </td>
                            <td rowspan="4"></td>
                        </tr>
                        <tr>
                            <td colspan="4">Аудиторные</td>
                            <td colspan="3">Самост.</td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime}">
                                <td colspan="8">${i} Курс</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td rowspan="2">${cycleContent.get(9).value}</td>
                            <td rowspan="2">${cycleContent.get(10).value}</td>
                            <td rowspan="2">${cycleContent.get(11).value}</td>
                            <td rowspan="2">${cycleContent.get(12).value}</td>
                            <td rowspan="2">${cycleContent.get(13).value}</td>
                            <td rowspan="2">${cycleContent.get(14).value}</td>
                            <td rowspan="2">${cycleContent.get(15).value}</td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="4">${i} (18)</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td>${cycleContent.get(16).value}</td>
                                <td>${cycleContent.get(17).value}</td>
                                <td>${cycleContent.get(18).value}</td>
                                <td>${cycleContent.get(19).value}</td>
                            </c:forEach>
                        </tr>
                        <tr style="background-color: #e0ecf9">
                            <td style="text-align: left">
                                <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9 ]{1,10}"
                                       title="Код цикла должен быть не более 10 символов и состоять из букв и/или цифр."
                                       minlength="1" maxlength="10" style="background-color: #e0ecf9; width: 50px; font-size: 16px;" class="text-field-n"
                                       required="required" name="shortNameCycleInsert" value="${cycle.shortName}"/>
                            </td>
                            <td colspan="${title.studyTime*8+14}">
                                <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9,.- ]{1,80}"
                                       title="Название цикла должно быть не более 80 символов и состоять из букв и/или цифр."
                                       minlength="1" maxlength="80" style="background-color: #e0ecf9; width: 800px; font-size: 16px; float: left;" class="text-field-n"
                                       required="required" name="nameCycleInsert" value="${cycle.name}"/>
                            </td>
                        </tr>
                        <c:forEach items="${partList}" var="part" varStatus="status">
                            <tr style="background-color: #e0ecf9">
                                <td style="text-align: left; ">${cycle.shortName}.
                                    <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9 ]{1,10}"
                                           title="Код части должен быть не более 10 символов и состоять из букв и/или цифр."
                                           minlength="1" maxlength="10" style="background-color: #e0ecf9; float: none; width: 50px; " class="text-field-n"
                                           required="required" name="part${status.count}" value="${part.shortName}"/>
                                </td>
                                <td colspan="${title.studyTime*8+14}">
                                    <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9,.- ]{1,80}"
                                           title="Название части должно быть не более 80 символов и состоять из букв и/или цифр."
                                           minlength="1" maxlength="80" style="background-color: #e0ecf9; width: 800px; float: left;" class="text-field-n"
                                           required="required" name="part${status.count}" value="${part.name}"/>
                                </td>
                            </tr>
                            <c:forEach items="${subjectList}" var="subject" varStatus="sstatus">
                                <c:if test="${subject.idPart == part.idPart}">
                                    <!-- Подсчет -->
                                    <c:set var = "allaud" value = "${subject.lec*18 + subject.lab*18 + subject.pract*18}"/>
                                    <c:set var = "allself" value = "${subject.self*18 + subject.bsr}"/>
                                    <c:set var = "all" value = "${allaud+allself}"/>
                                    <tr>
                                        <!-- Код дисциплины -->
                                        <td style="text-align: left">
                                            ${cycle.shortName}.${part.shortName}
                                            <input type="text" pattern="\d{1,2}\.?\d{0,1}"
                                                   title="Неверно введен код дисциплины."
                                                   minlength="1" maxlength="4" style="width: 40px;" class="text-field-n"
                                                   required="required" name="subject-${part.idPart}-${sstatus.count}"
                                                   value="<fmt:formatNumber type="number" groupingUsed="false"  value="${subject.number}" />" />
                                        </td>
                                        <!-- Название дисциплины -->
                                        <td>
                                            <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9,.- ]{1,80}"
                                                   title="Название дисциплины должно быть не более 80 символов и состоять из букв и/или цифр."
                                                   minlength="1" maxlength="80" style="width: 400px" class="text-field-n"
                                                   required="required" name="subject-${part.idPart}-${sstatus.count}" value="${subject.name}"/>
                                        </td>
                                        <!-- Шифр кафедры -->
                                        <td>
                                            <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9,.- ]{1,10}"
                                                   title="Шифр кафедры должен быть не более 10 символов и состоять из букв и/или цифр."
                                                   minlength="1" maxlength="10" style="width: 50px" class="text-field-n"
                                                   required="required" name="subject-${part.idPart}-${sstatus.count}" value="${subject.depart}"/>
                                        </td>
                                        <!-- з.е -->
                                        <td>
                                            <fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2" value="${all/36}" />
                                        </td>
                                        <!-- Экзамен -->
                                        <td>
                                            <input type="text" pattern="[0-9]{1}"
                                                   title="В колонке экзамена должны быть цифры с номером семестра."
                                                   maxlength="1" style="width: 10px" class="text-field-n"
                                                   required="required" name="subject-${part.idPart}-${sstatus.count}" value="${subject.exams}"/>
                                        </td>
                                        <!-- Зачет -->
                                        <td>
                                            <input type="text" pattern="[0-9]{1}"
                                                   title="В колонке зачетов должны быть цифры с номером семестра."
                                                   maxlength="1" style="width: 10px" class="text-field-n"
                                                   required="required" name="subject-${part.idPart}-${sstatus.count}" value="${subject.credits}"/>
                                        </td>
                                        <!-- Общий объем -->
                                        <td>
                                            <fmt:formatNumber type="number" groupingUsed="false" value="${all}" />
                                        </td>
                                        <!-- Всего ауд. -->
                                        <td>
                                            <fmt:formatNumber type="number" groupingUsed="false" value="${allaud}" />
                                        </td>
                                        <!-- Лек. -->
                                        <td>
                                            <fmt:formatNumber type="number" groupingUsed="false" value="${subject.lec*18}" />
                                        </td>
                                        <!-- Лаб. -->
                                        <td>
                                            <fmt:formatNumber type="number" groupingUsed="false" value="${subject.lab*18}" />
                                        </td>
                                        <!-- Пр. -->
                                        <td>
                                            <fmt:formatNumber type="number" groupingUsed="false" value="${subject.pract*18}" />
                                        </td>
                                        <!-- Всего самост. -->
                                        <td>
                                            <fmt:formatNumber type="number" groupingUsed="false" value="${allself}" />
                                        </td>
                                        <!-- Кср. -->
                                        <td>
                                            <fmt:formatNumber type="number" groupingUsed="false" value="${subject.self*18}" />
                                        </td>
                                        <!-- Бср. -->
                                        <td><input type="text" pattern="[0-9]{1,2}"
                                                   title="В колонке БСР должно быть целое число не менее одного и не более двух символов."
                                                   maxlength="2" style="width: 20px" class="text-field-n"
                                                   required="required" name="subject-${part.idPart}-${sstatus.count}" value="${subject.bsr}"/>
                                        </td>
                                        <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                            <c:if test="${subject.exams==i || subject.credits==i}">
                                                <td>
                                                    <input type="text" pattern="\d{1}\.?\d{0,1}"
                                                           title="Количество лекций в неделю имеет неверное значение."
                                                           maxlength="3" style="width: 20px; font-size: 12px;" class="text-field-n"
                                                           required="required" name="subject-${part.idPart}-${sstatus.count}"
                                                           value="<fmt:formatNumber type="number" groupingUsed="false" value="${subject.lec}" />"/>
                                                </td>
                                                <td><input type="text" pattern="\d{1}\.?\d{0,1}"
                                                           title="Количество лабораторных занятий в неделю имеет неверное значение."
                                                           maxlength="3" style="width: 20px; font-size: 12px;" class="text-field-n"
                                                           required="required" name="subject-${part.idPart}-${sstatus.count}"
                                                           value="<fmt:formatNumber type="number" groupingUsed="false" value="${subject.lab}" />"/>
                                                </td>
                                                <td><input type="text" pattern="\d{1}\.?\d{0,1}"
                                                           title="Количество практических занятий в неделю имеет неверное значение."
                                                           maxlength="3" style="width: 20px; font-size: 12px;" class="text-field-n"
                                                           required="required" name="subject-${part.idPart}-${sstatus.count}"
                                                           value="<fmt:formatNumber type="number" groupingUsed="false" value="${subject.pract}" />"/></td>
                                                <td><input type="text" pattern="\d{1}\.?\d{0,1}"
                                                           title="Количество самостоятельных занятий в неделю имеет неверное значение."
                                                           maxlength="3" style="width: 20px; font-size: 12px;" class="text-field-n"
                                                           required="required" name="subject-${part.idPart}-${sstatus.count}"
                                                           value="<fmt:formatNumber type="number" groupingUsed="false" value="${subject.self}" />"/></td>
                                            </c:if>
                                            <c:if test="${subject.exams!=i && subject.credits!=i}">
                                                <c:forEach var = "j" begin = "1" end = "4">
                                                    <td style="color: #999999">0</td>
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>
                                        <td>
                                            <input type="button" class="button red button-table" onclick="deleteSubject(${subject.idSubject}, '${subject.name}');" value="Удалить"/>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            <tr>
                                <td></td>
                                <td><b>Итого по части</b></td>
                                <td></td>
                                <c:set var = "sumListShow" value = "${sumList.get(status.count-1)}"/>
                                <c:forEach var = "j" begin = "1" end = "${title.studyTime*8+11}">
                                    <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumListShow.get(j-1)}" /></td>
                                </c:forEach>
                                <td></td>
                            </tr>
                        </c:forEach>
                        <tr style="background-color: #e0ecf9">
                            <td></td>
                            <td><b>ИТОГО ПО ЦИКЛУ</b></td>
                            <td></td>
                            <c:forEach var = "j" begin = "1" end = "${title.studyTime*8+11}">
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAllList.get(j-1)}" /></td>
                            </c:forEach>
                            <td></td>
                        </tr>
                    </table>


                    <div style = "width: 100%; height: 100px; float: left;">
                        <input type="submit" value="Сохранить" class="button" style="float: right; margin: 50px 50px 10px 10px;"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="toolbar">
        <form>
            <input type="button" onclick="document.getElementById('part_popup').style.display='block';" value="Редактировать части" class="button green"/>
        </form>
        <form>
            <input type="button" onclick="document.getElementById('subject_popup').style.display='block';" value="Добавить предмет" class="button blue"/>
        </form>
        <form action="/toPdf" method="POST">
            <input type="submit" value="Экспорт в PDF" class="button gray"/>
        </form>

    </div>
</div>

<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ ЧАСТИ -->
<div id="delete_subject_popup" class="parent_popup">
    <div class="popup">
        <form action="/deleteSubject" method="POST" class="popup-form" style="height:140px;">
            <div id="text-subject-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idSubjectDelete" name="idSubjectDelete"/>
                <input type="submit" class="button red button-little" value="Подтвердить"/>
                <input type="button" class="button gray button-little" onclick="document.getElementById('delete_subject_popup').style.display='none';" value="Отмена"/>
            </div>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('delete_subject_popup').style.display='none';">X</a>
    </div>
</div>

<%@ include file="/cycle-part.jsp" %>

<!-- ДОБАВИТЬ ПРЕДМЕТ -->
<div id="subject_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:300px;">
            <div class="top-div">
                Добавить предмет
            </div>
            <form action="/insertSubject" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:150px;">
                    <table class="center-table" style="width: 600px;">
                        <tr>
                            <td style="width: 150px; font-size: 16px;">Часть</td>
                            <td>
                                <select name="partSubject" class="text-field" style="width: 400px">
                                    <c:forEach items="${partList}" var="part">
                                        <option value="${part.idPart}">${part.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                        <tr style="background-color: white;">
                            <td style="width: 150px; font-size: 16px; ">Имя дисциплины</td>
                            <td>
                                <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9,.- ]{1,80}"
                                       title="Название дисциплины должно быть не более 80 символов и состоять из букв и/или цифр."
                                       minlength="1" maxlength="80" style="width: 400px" class="text-field" required="required" name="nameSubject" value=""/>
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 150px; font-size: 16px; ">Шифр кафедры</td>
                            <td>
                                <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9,.- ]{1,10}"
                                       title="Шифр кафедры должен быть не более 10 символов и состоять из букв и/или цифр."
                                       minlength="1" maxlength="10" style="width: 400px" class="text-field"
                                       required="required" name="departSubject" value=""/>
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="bottom-div-zero">
                    <input type="submit" class="button green button-little" value="Сохранить" name="insert"/>
                    <input type="button" class="button gray button-little" onclick="document.getElementById('subject_popup').style.display='none';" value="Отмена"/>
                </div>
            </form>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('subject_popup').style.display='none';">X</a></div>
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
