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
<style><%@ include file="/styles/title.css" %></style>
<html>
<head>
    <meta charset="utf-8">
    <title>Учебные планы </title>
</head>
<body>
<div class="wrapper">
    <div class = "menu">
        <ul>
            <li><a href="/title">ТИТУЛ</a></li>
            <li><a href="">ГСЭ</a></li>
            <li><a href="">МЕН</a></li>
            <li><a href="">ПРОФ</a></li>
            <li style="width: 90%"><form action="/ext" style="float: right" method="POST"><input type="submit" name="submit" class="exit-button" value="Выход"/></form></li>
        </ul>
    </div>

    <div style="height: calc(100% - (130px));overflow: auto;">
        <div class="center-block custom-scrollbar">
            <div class="content-block">

                <table class="head-table">
                    <tr>
                        <td style="font-weight: bold;" colspan=2>
                            Министерство образования и науки Луганской Народной Республики<br>
                            ГОУ ВПО ЛНР "Донбасский государственный технический университет" *(ДонГТУ)
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left; padding-left: 100px">
                            <h4>Утверждаю</h4>
                            И.о. ректора __ Зинченко А.М.<br>
                            "__"____ <input type="text" name="yearCreation" class="text-field" value="">г.<br>
                            Одобрен Ученым советом ДонГТУ, протокол от __.__.<input type="text" name="yearCreation1" class="text-field" value="">г. №__
                        </td>
                        <td style="text-align: right; padding-right: 100px">
                            Квалификация: <input type="text" name="qualification" style="width: 80px" class="text-field" value=""><br>
                            Срок обучения: <input type="text" name="termsEducation" class="text-field" value="">г.<br>
                            на базе: среднего общего образования <br>
                        </td>
                    </tr>

                </table>


            </div>
        </div>
    </div>
    <div class="toolbar">
        <form action="/toPdf" method="POST">
            <input type="submit" value="pdf"/>
        </form>
    </div>
    <div class="footer">
        &copy <br>
    </div>
</div>
</body>
</html>
