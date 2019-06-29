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
    <title>Итог</title>
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

        <form action="/toPdf" method="POST">
            <input type="submit" value="Экспорт в PDF" class="button gray"/>
        </form>

        <form>
            <input type="button" onclick="showAnalyze()" value="Анализ" class="button purple"/>
        </form>
    </div>

    <div style="height: calc(100% - (120px));overflow: auto;">
        <div class="center-block custom-scrollbar">
            <form action="/updateResultPage" method="POST">
                <input type="text" hidden name="idTitle" value="${title.idTitle}"/>
                <div class="content-block" style="width: ${1100 + title.studyTime*100}px; padding-bottom: 130px;">
                    <table class = "cycle-table">
                        <tr>
                            <td rowspan="4" style="width: 400px; max-width: 400px;" colspan="2"></td>
                            <td rowspan="4" style="max-width: 30px" class="rotatable">${cycleContent.get(3).value}</td>
                            <td rowspan="4" style="max-width: 30px" class="rotatable">${cycleContent.get(6).value}</td>
                            <td colspan="7" style="max-width: 290px">${cycleContent.get(7).value}</td>
                            <td colspan="${title.studyTime*8}">
                                ${cycleContent.get(8).value}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">Аудиторные</td>
                            <td colspan="3">Самост.</td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime}">
                                <td colspan="4">${i} Курс</td>
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
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2-1}">
                                <td colspan="2">${i} (18)</td>
                            </c:forEach>
                            <td colspan="2">${title.studyTime*2} (9)</td>
                        </tr>
                        <tr>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td>Ауд.</td>
                                <td>Сам.</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td style="text-align: left" colspan="${title.studyTime*4+14}">
                                <b>Б${countCycle+1} Физическая культура</b>
                            </td>
                        </tr>
                        <!-- физ культура 1 -->
                        <tr>
                            <td style="text-align: left" colspan="2">Б${countCycle+1}.1 ${physicalList.get(0).name}</td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2" value="${(sumAudPhysical.get(0)+physicalList.get(0).bsr)/36}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+physicalList.get(0).bsr}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)}" /></td>
                            <td></td>
                            <td></td>
                            <td>${physicalList.get(0).bsr}</td>
                            <td></td>
                            <td>
                                <input type="text" pattern="[0-9]{1,3}"
                                       title="В колонке БСР должно быть целое число не менее одного и не более трех символов."
                                       maxlength="3" style="width: 30px" class="text-field-n"
                                       required="required" name="physical" value="${physicalList.get(0).bsr}"/>
                            </td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td><input type="text" pattern="\d{1}\.?\d{0,1}"
                                           title="Количество недель в аудировании должно быть числом."
                                           maxlength="3" style="width: 20px; font-size: 12px;" class="text-field-n"
                                           required="required" name="physical0"
                                           value="<fmt:formatNumber type="number" groupingUsed="false" value="${physicalList.get(0).week.get(i-1)}" />"/></td>
                                <td></td>
                            </c:forEach>
                        </tr>
                        <!-- физ культура 2 -->
                        <tr>
                            <td style="text-align: left" colspan="2">Б${countCycle+1}.2 ${physicalList.get(1).name}</td>
                            <td>-</td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2" value="${sumAudPhysical.get(1)+physicalList.get(1).bsr}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(1)}" /></td>
                            <td></td>
                            <td></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(1)}" /></td>
                            <td>${physicalList.get(1).bsr}</td>
                            <td></td>
                            <td>
                                <input type="text" pattern="[0-9]{1,3}"
                                       title="В колонке БСР должно быть целое число не менее одного и не более трех символов."
                                       maxlength="3" style="width: 30px" class="text-field-n"
                                       required="required" name="physical" value="${physicalList.get(1).bsr}"/>
                            </td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td><input type="text" pattern="\d{1}\.?\d{0,1}"
                                           title="Количество недель в аудировании должно быть числом."
                                           maxlength="3" style="width: 20px; font-size: 12px;" class="text-field-n"
                                           required="required" name="physical1"
                                           value="<fmt:formatNumber type="number" groupingUsed="false" value="${physicalList.get(1).week.get(i-1)}" />"/></td>
                                <td></td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td style="text-align: left" rowspan="3">
                                Теоретическая подготовка
                            </td>
                            <td>Всего</td>
                            <!-- ze -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2"
                                                  value="${(sumAudPhysical.get(0)+physicalList.get(0).bsr)/36+sumWithoutPFK.get(0)}" /></td>
                            <!-- Общий объём -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+physicalList.get(0).bsr
                                            +sumAudPhysical.get(1)+physicalList.get(1).bsr+sumWithoutPFK.get(3)}" /></td>
                            <!-- Всего -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+sumAudPhysical.get(1)+sumWithoutPFK.get(4)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+sumWithoutPFK.get(5)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(6)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(7)+sumAudPhysical.get(1)}" /></td>
                            <!-- Всего -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(8)+physicalList.get(0).bsr+physicalList.get(1).bsr}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(9)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(10)+physicalList.get(0).bsr+physicalList.get(1).bsr}" /></td>

                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudList.get(i-1)}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumSelfList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td>без ПФК*</td>
                            <!-- ze -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2"
                                                  value="${(sumAudPhysical.get(0)+physicalList.get(0).bsr)/36+sumWithoutPFK.get(0)}" /></td>
                            <!-- Общий объём -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+physicalList.get(0).bsr+sumWithoutPFK.get(3)}" /></td>
                            <!-- Всего -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+sumWithoutPFK.get(4)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+sumWithoutPFK.get(5)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(6)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(7)}" /></td>
                            <!-- Всего -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(8)+physicalList.get(0).bsr}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(9)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(10)+physicalList.get(0).bsr}" /></td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="2"><fmt:formatNumber type="number" groupingUsed="false" value="${sumList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td>з.е</td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumZE}" /></td>
                            <td colspan="8"></td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="2"><fmt:formatNumber type="number" groupingUsed="false" value="${sumZeList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <!-- Практика -->
                        <tr>
                            <td style="text-align: left" colspan="${11}">
                                <b>Б${countCycle+2} Практическая подготовка</b>
                            </td>
                            <td colspan="${title.studyTime*4}">з.е.</td>
                        </tr>
                        <c:forEach items="${practList}" var="pract" varStatus="status">
                            <tr>
                                <td style="text-align: left" colspan="2">Б${countCycle+2}.${status.count} ${typeMap.get(pract.idPractType)}</td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${pract.week*54/36}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${pract.week*54}" /></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${pract.week*54}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${pract.week*54}" /></td>
                                <td></td>
                                <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                    <c:if test="${pract.semester == i}">
                                        <td colspan="2"><fmt:formatNumber type="number" groupingUsed="false" value="${pract.week*54/36}" /></td>
                                    </c:if>
                                    <c:if test="${pract.semester != i}">
                                        <td colspan="2"></td>
                                    </c:if>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td style="text-align: left" colspan="2">Всего</td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumPract.get(0)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumPract.get(1)}" /></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumPract.get(2)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumPract.get(3)}" /></td>
                            <td></td>
                            <td colspan="${title.studyTime*4}"></td>
                        </tr>
                        <!-- Гос аттестация -->
                        <tr>
                            <td style="text-align: left" colspan="${11}">
                                <b>Б${countCycle+3} Государственная итоговая аттестация</b>
                            </td>
                            <td colspan="${title.studyTime*4}">з.е.</td>
                        </tr>
                        <c:forEach items="${stateList}" var="state" varStatus="status">
                            <tr>
                                <td style="text-align: left" colspan="2">Б${countCycle+3}.${status.count} ${stateMap.get(state.idSertificationType)}</td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${state.ze}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${state.ze*36}" /></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${state.ze*36}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${state.ze*36}" /></td>
                                <td></td>
                                <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                    <c:if test="${state.semester == i}">
                                        <td colspan="2">
                                            <input type="text" pattern="\d{1}\.?\d{0,1}"
                                                   title="Зачетная единица должна быть числом."
                                                   maxlength="3" style="width: 20px; font-size: 12px;" class="text-field-n"
                                                   required="required" name="state${status.count-1}"
                                                   value="<fmt:formatNumber type="number" groupingUsed="false" value="${state.ze}" />"/>
                                            </td>
                                    </c:if>
                                    <c:if test="${state.semester != i}">
                                        <td colspan="2"></td>
                                    </c:if>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td style="text-align: left" colspan="2">Всего</td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumState.get(0)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumState.get(1)}" /></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumState.get(2)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumState.get(3)}" /></td>
                            <td></td>
                            <td colspan="${title.studyTime*4}"></td>
                        </tr>
                        <tr>
                            <td rowspan="2">Подготовка бакалавра:</td>
                            <td>всего**</td>
                            <!-- ze -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2"
                                                  value="${(sumAudPhysical.get(0)+physicalList.get(0).bsr)/36+sumWithoutPFK.get(0)+
                                                  sumPract.get(0)+sumState.get(0)}" /></td>
                            <!-- Общий объём -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+physicalList.get(0).bsr
                                            +sumAudPhysical.get(1)+physicalList.get(1).bsr+sumWithoutPFK.get(3)+sumPract.get(1)+sumState.get(1)}" /></td>
                            <!-- Всего -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+sumAudPhysical.get(1)+sumWithoutPFK.get(4)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+sumWithoutPFK.get(5)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(6)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(7)+sumAudPhysical.get(1)}" /></td>
                            <!-- Всего -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(8)+physicalList.get(0).bsr+physicalList.get(1).bsr
                                            +sumPract.get(2)+sumState.get(2)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(9)+sumPract.get(3)+sumState.get(3)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(10)+physicalList.get(0).bsr+physicalList.get(1).bsr}" /></td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td rowspan="2" colspan="2"><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2"
                                          value="${sumZeList.get(i-1)+sumPract.get(i+3)+sumState.get(i+3)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td>без ПФК</td>
                            <!-- ze -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2"
                                                  value="${(sumAudPhysical.get(0)+physicalList.get(0).bsr)/36+sumWithoutPFK.get(0)+
                                                  sumPract.get(0)+sumState.get(0)}" /></td>
                            <!-- Общий объём -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+physicalList.get(0).bsr
                                            +sumWithoutPFK.get(3)+sumPract.get(1)+sumState.get(1)}" /></td>
                            <!-- Всего -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+sumWithoutPFK.get(4)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudPhysical.get(0)+sumWithoutPFK.get(5)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(6)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(7)}" /></td>
                            <!-- Всего -->
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(8)+physicalList.get(0).bsr
                                            +sumPract.get(2)+sumState.get(2)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(9)+sumPract.get(3)+sumState.get(3)}" /></td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumWithoutPFK.get(10)+physicalList.get(0).bsr}" /></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="border: 0px;"></td>
                            <td colspan="7">з.е. за год</td>
                            <c:forEach var = "i" begin = "1" step="2" end = "${title.studyTime*2}">
                                <td colspan="4"><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2"
                                                                              value="${sumZeList.get(i-1)+sumPract.get(i+3)+sumState.get(i+3)+
                                                                              sumZeList.get(i)+sumPract.get(i+4)+sumState.get(i+4)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td style="border: 0px;"></td>
                        </tr>
                        <tr>
                            <td style="border: 0px; font-style: italic;" colspan="3" rowspan="2">
                                *  - в зачетные единицы не переводится. Зачеты по ПФК также не включаются в общее число зачетов.
                            </td>
                            <td style="border: 0px;" rowspan="2"></td>
                            <td colspan="7">Количество зачетов</td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="2"><fmt:formatNumber type="number" groupingUsed="false" value="${creditList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td colspan="7">Кол-во экзаменов, в т.ч. ГОС</td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="2"><fmt:formatNumber type="number" groupingUsed="false" value="${examList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td style="border: 0px; font-style: italic;" colspan="3" rowspan="2">
                                ** Общая трудоёмкость основной образовательной программы ${sumAudPhysical.get(0)+physicalList.get(0).bsr
                                    +sumWithoutPFK.get(3)+sumPract.get(1)+sumState.get(1)}
                                час. +
                                <fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits = "2" value="${sumAudPhysical.get(1)+physicalList.get(1).bsr}" /> час. прикладной физической культуры
                            </td>
                            <td style="border: 0px;" rowspan="2"></td>
                            <td colspan="7">Количество учебных дисциплин</td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="2"><fmt:formatNumber type="number" groupingUsed="false" value="${creditList.get(i-1)+examList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td colspan="7">Кол-во экзаменов, в т.ч. ГОС</td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="2"><fmt:formatNumber type="number" groupingUsed="false" value="${kpList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td style="border: 0px;"></td>
                        </tr>
                        <tr>
                            <td style="border: 0px;"></td>
                        </tr>
                        <!-- Имена -->
                        <tr>
                            <td style="border: 0px;"></td>
                            <td style="border: 0px; text-align: left;" colspan="10"><h3>И.о. первого проректора по учебной работе</h3></td>
                            <td style="border: 0px;" colspan="${title.studyTime*4}"><input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z,.- ]{1,50}"
                                                                                           title="Имя проректора должно быть не более 50 символов и состоять из букв."
                                                                                           minlength="1" maxlength="50" style="width: 200px;" class="text-field"
                                                                                           required="required" name="prorectorName" value="${name.prorectorName}"/></td>
                        </tr>
                        <tr>
                            <td style="border: 0px;"></td>
                            <td style="border: 0px; text-align: left;" colspan="10"><h3>Начальник учебного отдела</h3></td>
                            <td style="border: 0px;" colspan="${title.studyTime*4}"><input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z,.- ]{1,50}"
                                                                                           title="Имя начальника должно быть не более 50 символов и состоять из букв."
                                                                                           minlength="1" maxlength="50" style="width: 200px;" class="text-field"
                                                                                           required="required" name="studyName" value="${name.studyName}"/></td>
                        </tr>
                        <tr>
                            <td style="border: 0px;"></td>
                            <td style="border: 0px; text-align: left;" colspan="10"><h3>И.о. декана факультета автоматизации и электротехнических систем</h3></td>
                            <td style="border: 0px;" colspan="${title.studyTime*4}"><input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z,.- ]{1,50}"
                                                                                           title="Имя декана должно быть не более 50 символов и состоять из букв."
                                                                                           minlength="1" maxlength="50" style="width: 200px;" class="text-field"
                                                                                           required="required" name="decanName" value="${name.decanName}"/></td>
                        </tr>
                        <tr>
                            <td style="border: 0px;"></td>
                            <td style="border: 0px; text-align: left;" colspan="10"><h3>Заведующий кафедрой</h3></td>
                            <td style="border: 0px;" colspan="${title.studyTime*4}"><input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z,.- ]{1,50}"
                                                                                           title="Имя заведующего должно быть не более 50 символов и состоять из букв."
                                                                                           minlength="1" maxlength="50" style="width: 200px;" class="text-field"
                                                                                           required="required" name="departName" value="${name.departName}"/></td>
                        </tr>

                    </table>


                    <div style = "width: 100%; height: 100px; float: left;">
                        <input type="submit" value="Сохранить" class="button" style="float: right; margin: 50px 50px 10px 10px;"/>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="/analyze.jsp" %>


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
