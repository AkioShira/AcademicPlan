<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 21.05.2019
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type='text/javascript'>
    function showPracts(){
    document.getElementById('pract_popup').style.display='block';
    }

    function deletePract(idpk, name){
    document.getElementById('delete_popup').style.display='block';
    var el=document.getElementById('idPractDelete');
    el.value = idpk;
    document.getElementById('text-delete').innerHTML = "Удалить практику '"+name+"'?";
    }

    function addPract() {
    document.getElementById('insert_popup').style.display='block';
    }
</script>
<!-- РЕДАКТИРОВАТЬ ПРАКТИКИ -->
<div id="pract_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Редактировать практики
            </div>
            <div class="center-div">
                <table class="center-table">
                    <tr>
                        <th>Название практики</th>
                        <th>Семестр</th>
                        <th>Недели</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${practList}" var="pract" varStatus="status">
                        <tr>
                            <td>${typeMap.get(pract.idPractType)}</td>
                            <td>${pract.semester}</td>
                            <td>${pract.week}</td>
                            <td>
                                <c:if test="${status.count!=1}">
                                    <input type="button" class="button red button-little" onclick="deletePract(${pract.idPract}, '${typeMap.get(pract.idPractType)}');" value="Удалить"/>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
            <div style = "padding: 20px 250px 0px 250px;">
                <c:if test="${practList.size()<=6}">
                    <input type="button" class="button blue button-little" onclick="addPract();" value="Добавить" name="restore-all"/>
                </c:if>
                <input type="button" class="button gray button-little" onclick="document.getElementById('pract_popup').style.display='none';" value="Отмена"/>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('pract_popup').style.display='none';">X</a></div>
</div>

<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ СТРОКИ -->
<div id="delete_popup" class="parent_popup">
    <div class="popup">
        <form action="/deletePract" method="POST" id="form-popup1" class="popup-form" style="height:140px;">
            <div id="text-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idPractDelete" name="idPractDelete"/>
                <input type="submit" class="button red button-little" value="Подтвердить"/>
                <input type="button" class="button gray button-little" onclick="document.getElementById('delete_popup').style.display='none';" value="Отмена"/>
            </div>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('delete_popup').style.display='none';">X</a>
    </div>
</div>
<!-- ОКНО ДОБАВЛЕНИЯ ПРАКТИКИ-->
<div id="insert_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:250px;">
            <div class="top-div">
                Добавить практику
            </div>
            <form action="/insertPract" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:100px;">
                    <table class="center-table" style="width: 600px;">
                        <tr>
                            <td style="width: 150px; font-size: 16px;">Название практики</td>
                            <td>
                                <select id="practInsert" name="practInsert" class="text-field" style="width: 90%; height: 30px;">
                                    <c:forEach items="${practTypes}" var="type">
                                        <option value="${type.idPractType}">${type.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="bottom-div-zero">
                    <input type="submit" class="button green button-little" value="Сохранить" name="insert"/>
                    <input type="button" class="button gray button-little" onclick="document.getElementById('insert_popup').style.display='none';" value="Отмена"/>
                </div>
            </form>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('insert_popup').style.display='none';">X</a></div>
</div>