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
    <%@ include file="/styles/message.css" %></style>
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
</script>
<body>
<div class="wrapper">
    <div class = "menu">
        <ul>
            <li><a >ТИТУЛ</a></li>
            <li><a>ГСЭ</a></li>
            <li><a >МЕН</a></li>
            <li><a >ПРОФ</a></li>
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
                                "__"____ <input type="text" maxlength="4" style="width: 60px" class="text-field"
                                                required="required" name="yearCreation" value="${title.yearCreation}"/> г.<br>
                                ${titleContent.get(4).value} ___.___.${title.yearCreation}г. №__
                            </td>
                            <td style="text-align: right; padding-right: 100px">
                                ${titleContent.get(5).value}
                                    <p>
                                        <input type="text" maxlength="20" style="width: 200px" class="text-field" required="required" name="qualification" value="${title.qualification}"/>
                                    </p><br>
                                ${titleContent.get(6).value} <p>
                                    <input type="text" maxlength="2" style="width: 40px" class="text-field" required="required" name="studyTime" value="${title.studyTime}"/>
                                    г.</p><br>
                                ${titleContent.get(7).value} <p>среднего общего образования</p><br>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align:center;padding-top: 20px;">
                                <h3 style="margin-top:10px; display:inline-block;">${titleContent.get(8).value}</h3>
                                <h4 style="font-style:italic; display:inline-block;"> ${titleContent.get(9).value}</h4>
                                <p><input type="text" maxlength="4" style="width: 60px" class="text-field" required="required" name="yearReception" value="${title.yearReception}"/></p>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 150px; font-size: 12px;">${titleContent.get(10).value}</td>
                            <td><p><input type="text" maxlength="40" style="width: 400px" class="text-field" required="required" name="studyLevel" value="${title.studyLevel}"/></p></td>
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
                <div style = "width: 90%; margin: 0 auto; font-size: 12px;">
                    <h3 style="text-align: center;">${titleContent.get(18).value}</h3>

                    <h3>${titleContent.get(16).value}</h3>
                    <p style="text-align: center; text-decoration: none;">${titleContent.get(17).value}</p>
                </div>
                <div style = "width: 100%; height: 100px;">
                    <input type="submit" value="Сохранить" class="button" style="float: right; margin: 50px 50px 10px 10px;"/>
                </div>
            </div>
            </form>
        </div>

    </div>
    <div class="toolbar">
        <form action="/toPdf" method="POST">
            <input type="submit" value="Сохранить PDF" class="button red" style="float: right; margin: 10px 50px 10px 10px;"/>
        </form>
    </div>
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
</script>
</body>
</html>
