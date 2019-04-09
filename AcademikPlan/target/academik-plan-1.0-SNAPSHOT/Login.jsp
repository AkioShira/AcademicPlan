<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 26.03.2019
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style><%@ include file="/styles/login.css" %></style>
<html>
<head>
    <title>Вход в систему</title>
</head>
<body>
<form action="/" method="POST" class="submit">
    <table class="login-table">
        <tr style="padding-bottom: 100px;">
            <td>Вход в систему:</td>
        </tr>
        <tr>
            <td>
                <table class = "input-table">
                    <tr>
                        <td>Логин</td>
                        <td style="padding-left: 20px;"><input type="text" name="login" class="text-field"></td>
                    </tr>
                    <tr>
                        <td>Пароль</td>
                        <td style="padding-left: 20px;"><input type="password" name="password" class="text-field"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table class = "input-table">
                    <tr>
                        <td style = "font-size: 12px; color: red;">${error}</td>
                        <td style="padding-left: 20px"><input type="submit" name="submit" class="login-button" value="Войти"/></td>
                    </tr>

                </table>


            </td>
        </tr>
    </table>
</form>
</body>
</html>
