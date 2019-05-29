<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 30.03.2019
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fmt:setLocale value="en_US"/>

<style><%@ include file="/styles/analyze.css" %>
</style>

<script type='text/javascript'>
    function showAnalyze() {
        document.getElementById('analyze_popup').style.display='block';
    }

</script>


<div id="analyze_popup" class="parent_popup">
    <div class="popup-big" style="width:900px;">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Анализ
            </div>
            <div class="center-div" style="overflow-y: auto; text-align: center;">
                <div style="float: left; width: 310px; height: 280px; ">
                    <b style="font-size: 14px;">Рассчет количества аудиторных и самостоятельных часов</b>
                    <table>
                        <tr>
                            <td>Семестр</td>
                            <td>Аудит.</td>
                            <td>Самост.</td>
                            <td>Итого</td>
                        </tr>
                        <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                            <tr>
                                <td>${i}с.</td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumAudList.get(i-1)}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumSelfList.get(i-1)}" /></td>
                                <c:if test="${sumList.get(i-1) <= 54}">
                                    <td style="color: green"><fmt:formatNumber type="number" groupingUsed="false" value="${sumList.get(i-1)}" /></td>
                                </c:if>
                                <c:if test="${sumList.get(i-1) > 54}">
                                    <td style="color: red"><fmt:formatNumber type="number" groupingUsed="false" value="${sumList.get(i-1)}" /></td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div style="float: left; width: 350px; height: 280px;">
                    <b style="font-size: 14px;">Рассчет количества экзаменов, зачетов, курсовых, кредитов</b>
                    <table>
                        <tr>
                            <td>Семестр</td>
                            <td>Экзам.</td>
                            <td>Зачеты</td>
                            <td>КП</td>
                            <td>Кредиты</td>
                        </tr>
                        <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                            <tr>
                                <td>${i}с.</td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${examList.get(i-1)}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${creditList.get(i-1)}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${kpList.get(i-1)}" /></td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumZeList.get(i-1)}" /></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div style="float: left; width: 200px; height: 280px;">
                    <b style="font-size: 14px;">Рассчет БСР на семестр</b>
                    <table>
                        <tr>
                            <td>Семестр</td>
                            <td>БСР</td>
                        </tr>
                        <c:forEach var = "i" begin = "1" end = "${title.studyTime*2}">
                            <tr>
                                <td>${i}с.</td>
                                <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumBSRList.get(i-1)}" /></td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td>Всего</td>
                            <td><fmt:formatNumber type="number" groupingUsed="false" value="${sumBSRList.get(title.studyTime*2)}" /></td>
                        </tr>
                    </table>

                </div>
                <div style="float: left; width: 100%; font-size: 12px; text-align: center; margin-top: 20px; color: red;">
                    ${message}
                </div>
            </div>
            <div style = "padding: 20px 390px 0 390px;">
                <input type="button" class="button gray button-little" onclick="document.getElementById('analyze_popup').style.display='none';" value="Ок"/>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('analyze_popup').style.display='none';">X</a></div>
</div>

