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
    <%@ include file="/styles/user-managment.css" %>
    <%@ include file="/styles/message.css" %>
</style>
<html>
<head>
    <meta charset="utf-8">
    <title>Редактирование информации на страницах</title>
</head>
<body class="body">
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

<!-- ОСНОВНОЕ ОКНО -->
<div class="top-panel">
    Пользователь: ${sessionUser.login}
    <a href="<c:url value='/plans/admin' />">Назад</a>
</div>
<div class="center-block" style="width: 700px;">
    <h2>Редактирование страниц</h2>
    <table  class="center-table">
        <tr>
            <th>Титул учебного плана</th>
            <th></th>
        </tr>
        <c:forEach items="${titleContent}" var="title">
        <form action="/updatePage" method="POST">
            <tr>
                <td><textarea id="valueArea" name="valueArea" maxlength="150">${title.value}</textarea>  </td>
                <td>
                    <input type="text" hidden id="item" name="item" value="${title.item}"/>
                    <input type="text" hidden id="nodeName" name="nodeName"  value="${title.nodeName}"/>
                    <input type="submit" class="button green" value="Сохранить"/>
                </td>
            </tr>
        </form>
        </c:forEach>
    </table>

    <table  class="center-table">
        <tr>
            <th>График учебного процесса</th>
            <th></th>
        </tr>
        <c:forEach items="${titleShedules}" var="title">
        <form action="/updatePage" method="POST">
            <tr>
                <td><textarea id="valueArea" name="valueArea" maxlength="15">${title.value}</textarea>  </td>
                <td>
                    <input type="text" hidden id="item" name="item" value="${title.item}"/>
                    <input type="text" hidden id="nodeName" name="nodeName"  value="${title.nodeName}"/>
                    <input type="submit" class="button green" value="Сохранить"/>
                </td>
            </tr>
        </form>
        </c:forEach>
    </table>

    <table  class="center-table">
        <tr>
            <th>Сводные данные о бюджете времени</th>
            <th></th>
        </tr>
        <c:forEach items="${titleBudget}" var="title">
        <form action="/updatePage" method="POST">
            <tr>
                <td><textarea id="valueArea" name="valueArea" maxlength="30">${title.value}</textarea>  </td>
                <td>
                    <input type="text" hidden id="item" name="item" value="${title.item}"/>
                    <input type="text" hidden id="nodeName" name="nodeName"  value="${title.nodeName}"/>
                    <input type="submit" class="button green" value="Сохранить"/>
                </td>
            </tr>
        </form>
        </c:forEach>
    </table>
    <table  class="center-table">
        <tr>
            <th>Практика</th>
            <th></th>
        </tr>
        <c:forEach items="${titlePractics}" var="title">
        <form action="/updatePage" method="POST">
            <tr>
                <td><textarea id="valueArea" name="valueArea" maxlength="30">${title.value}</textarea>  </td>
                <td>
                    <input type="text" hidden id="item" name="item" value="${title.item}"/>
                    <input type="text" hidden id="nodeName" name="nodeName"  value="${title.nodeName}"/>
                    <input type="submit" class="button green" value="Сохранить"/>
                </td>
            </tr>
        </form>
        </c:forEach>
    </table>
    <table  class="center-table">
        <tr>
            <th>Государственная итоговая аттестация</th>
            <th></th>
        </tr>
        <c:forEach items="${titleState}" var="title">
        <form action="/updatePage" method="POST">
            <tr>
                <td><textarea id="valueArea" name="valueArea" maxlength="60">${title.value}</textarea>  </td>
                <td>
                    <input type="text" hidden id="item" name="item" value="${title.item}"/>
                    <input type="text" hidden id="nodeName" name="nodeName"  value="${title.nodeName}"/>
                    <input type="submit" class="button green" value="Сохранить"/>
                </td>
            </tr>
        </form>
        </c:forEach>
    </table>
    <table  class="center-table">
        <tr>
            <th>Заголовки таблиц циклов</th>
            <th></th>
        </tr>
        <c:forEach items="${cicles0}" var="cicle">
        <form action="/updatePage" method="POST">
            <tr>
                <td><textarea id="valueArea" name="valueArea" maxlength="60">${cicle.value}</textarea>  </td>
                <td>
                    <input type="text" hidden id="item" name="item" value="${cicle.item}"/>
                    <input type="text" hidden id="nodeName" name="nodeName"  value="${cicle.nodeName}"/>
                    <input type="submit" class="button green" value="Сохранить"/>
                </td>
            </tr>
        </form>
        </c:forEach>
        <c:forEach items="${cicles1}" var="cicle">
        <form action="/updatePage" method="POST">
            <tr>
                <td><textarea id="valueArea" name="valueArea" maxlength="10">${cicle.value}</textarea>  </td>
                <td>
                    <input type="text" hidden id="item" name="item" value="${cicle.item}"/>
                    <input type="text" hidden id="nodeName" name="nodeName"  value="${cicle.nodeName}"/>
                    <input type="submit" class="button green" value="Сохранить"/>
                </td>
            </tr>
        </form>
        </c:forEach>
        <c:forEach items="${cicles2}" var="cicle">
        <form action="/updatePage" method="POST">
            <tr>
                <td><textarea id="valueArea" name="valueArea" maxlength="10">${cicle.value}</textarea>  </td>
                <td>
                    <input type="text" hidden id="item" name="item" value="${cicle.item}"/>
                    <input type="text" hidden id="nodeName" name="nodeName"  value="${cicle.nodeName}"/>
                    <input type="submit" class="button green" value="Сохранить"/>
                </td>
            </tr>
        </form>
        </c:forEach>
    </table>
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

