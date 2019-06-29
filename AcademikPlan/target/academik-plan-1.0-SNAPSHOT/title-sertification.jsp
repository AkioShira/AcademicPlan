<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 21.05.2019
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type='text/javascript'>
    function showSertification(){
        document.getElementById('state_popup').style.display='block';
    }

    function deleteSertification(idpk, name){
        document.getElementById('delete_state_popup').style.display='block';
        var el=document.getElementById('idSertificationDelete');
        el.value = idpk;
        document.getElementById('text-state-delete').innerHTML = "Удалить аттестацию '"+name+"'?";
    }

    function addSertification() {
        document.getElementById('insert_state_popup').style.display='block';
    }
</script>
<!-- РЕДАКТИРОВАТЬ АТТЕСТАЦИИ -->
<div id="state_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Редактировать государственные аттестации
            </div>
            <div class="center-div">
                <table class="center-table">
                    <tr>
                        <th>Форма аттестации</th>
                        <th>Семестр</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${stateList}" var="state" varStatus="status">
                        <tr>
                            <td>${stateMap.get(state.idSertificationType)}</td>
                            <td>${state.semester}</td>
                            <td>
                                <c:if test="${stateList.size()>1}">
                                    <input type="button" class="button red button-little" onclick="deleteSertification(${state.idSertification}, '${stateMap.get(state.idSertificationType)}');" value="Удалить"/>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
            <div style = "padding: 20px 250px 0px 250px;">
                <c:if test="${stateList.size()<=3}">
                    <input type="button" class="button blue button-little" onclick="addSertification();" value="Добавить" name="restore-all"/>
                </c:if>
                <input type="button" class="button gray button-little" onclick="document.getElementById('state_popup').style.display='none';" value="Отмена"/>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('state_popup').style.display='none';">X</a></div>
</div>

<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ СТРОКИ -->
<div id="delete_state_popup" class="parent_popup">
    <div class="popup">
        <form action="/deleteSertification" method="POST" id="form-popup1" class="popup-form" style="height:140px;">
            <div id="text-state-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idSertificationDelete" name="idSertificationDelete"/>
                <input type="submit" class="button red button-little" value="Подтвердить"/>
                <input type="button" class="button gray button-little" onclick="document.getElementById('delete_state_popup').style.display='none';" value="Отмена"/>
            </div>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('delete_state_popup').style.display='none';">X</a>
    </div>
</div>
<!-- ОКНО ДОБАВЛЕНИЯ ПРАКТИКИ-->
<div id="insert_state_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:250px;">
            <div class="top-div">
                Добавить государственную аттестацию
            </div>
            <form action="/insertSertification" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:100px;">
                    <table class="center-table" style="width: 600px;">
                        <tr>
                            <td style="width: 150px; font-size: 16px;">Форма аттестации</td>
                            <td>
                                <select id="sertificationInsert" name="sertificationInsert" class="text-field" style="width: 90%; height: 30px;">
                                    <c:forEach items="${stateTypes}" var="state">
                                        <option value="${state.idSertificationType}">${state.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="bottom-div-zero">
                    <input type="submit" class="button green button-little" value="Сохранить" name="insert"/>
                    <input type="button" class="button gray button-little" onclick="document.getElementById('insert_state_popup').style.display='none';" value="Отмена"/>
                </div>
            </form>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('insert_state_popup').style.display='none';">X</a></div>
</div>