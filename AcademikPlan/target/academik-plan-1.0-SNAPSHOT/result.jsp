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
            <form action="/updateCyclePage" method="POST">
                <input type="text" hidden id="idCycle" name="idCycle" value="${cycle.idCycle}"/>
                <div class="content-block" style="width: ${1600 + title.studyTime*100}px; padding-bottom: 130px;">
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
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="2">${i} (18)</td>
                            </c:forEach>
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
                        <tr>
                            <td style="text-align: left" rowspan="3">
                                Теоретическая подготовка
                            </td>
                            <td>Всего</td>
                            <td></td><td></td>
                            <td></td><td></td>
                            <td></td><td></td>
                            <td></td><td></td>
                            <td></td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudList.get(i-1)}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumSelfList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td>без ПФК*</td>
                            <td>${sumAllList.get(0)}</td><td>${sumAllList.get(3)}</td>
                            <td>${sumAllList.get(4)}</td><td>${sumAllList.get(5)}</td>
                            <td>${sumAllList.get(6)}</td><td>${sumAllList.get(7)}</td>
                            <td>${sumAllList.get(8)}</td><td>${sumAllList.get(9)}</td>
                            <td>${sumAllList.get(10)}</td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="2"><fmt:formatNumber type="number" groupingUsed="false" value="${sumList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td>з.е</td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumZe}" /></td>
                            <td colspan="8"></td>
                            <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                                <td colspan="2"><fmt:formatNumber type="number" groupingUsed="false" value="${sumZeList.get(i-1)}" /></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td style="text-align: left" colspan="${title.studyTime*4+14}">
                                <b>Б${countCycle+2} Практическая подготовка</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left" colspan="${title.studyTime*4+14}">
                                <b>Б${countCycle+3} Государственная итоговая аттестация</b>
                            </td>
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
