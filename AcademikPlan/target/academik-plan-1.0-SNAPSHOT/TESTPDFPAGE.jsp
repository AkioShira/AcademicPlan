<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
%>
<%-- ! Ссылки на ресурсы должны быть абсолютными ! --%>
<style>
    * {
        font-family: Tahoma;
    }

    @page {
        margin: 0px;
        padding: 0px;
        size: A4 landscape;
    }

    @media print {
        .new_page {
            page-break-after: always;
        }
    }

    body *{
        padding: 0;
        margin: 0;
    }


    #block {
        width: 90%;
        margin: auto;
        background-color: white;
        border: dashed #dbdbdb 1px;
    }


</style>
<html>
<head>
    <meta charset="utf-8">
    <title>Пример</title>

</head>
<body>
<div id="block">
    Раз два три
</div>

</body>
</html>