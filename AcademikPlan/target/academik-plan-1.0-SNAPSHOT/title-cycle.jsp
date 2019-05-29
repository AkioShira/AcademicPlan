<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 21.05.2019
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type='text/javascript'>
    function showCycle(){
        document.getElementById('cycle_popup').style.display='block';
    }

    function deleteCycle(idpk, name){
        document.getElementById('delete_cycle_popup').style.display='block';
        var el=document.getElementById('idCycleDelete');
        el.value = idpk;
        document.getElementById('text-cycle-delete').innerHTML = "Удалить цикл '"+name+"'? (Удалятся все части и дисциплины, что принадлежат этому циклу)";
    }

    function addCycle() {
        document.getElementById('insert_cycle_popup').style.display='block';
    }
</script>
<!-- РЕДАКТИРОВАТЬ ЦИКЛЫ -->
<div id="cycle_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Редактировать циклы
            </div>
            <div class="center-div">
                <table class="center-table">
                    <tr>
                        <th>Код цикла</th>
                        <th>Название</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${cycleList}" var="cycle" varStatus="status">
                        <tr>
                            <td>${cycle.shortName}</td>
                            <td>${cycle.name}</td>
                            <td>
                                <input type="button" class="button red button-little" onclick="deleteCycle(${cycle.idCycle}, '${cycle.shortName}');" value="Удалить"/>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
            <div style = "padding: 20px 250px 0px 250px;">
                <c:if test="${cycleList.size()<=10}">
                    <input type="button" class="button blue button-little" onclick="addCycle();" value="Добавить" name="restore-all"/>
                </c:if>
                <input type="button" class="button gray button-little" onclick="document.getElementById('cycle_popup').style.display='none';" value="Отмена"/>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('cycle_popup').style.display='none';">X</a></div>
</div>

<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ СТРОКИ -->
<div id="delete_cycle_popup" class="parent_popup">
    <div class="popup">
        <form action="/deleteCycle" method="POST" class="popup-form" style="height:140px;">
            <div id="text-cycle-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idCycleDelete" name="idCycleDelete"/>
                <input type="submit" class="button red button-little" value="Подтвердить"/>
                <input type="button" class="button gray button-little" onclick="document.getElementById('delete_cycle_popup').style.display='none';" value="Отмена"/>
            </div>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('delete_cycle_popup').style.display='none';">X</a>
    </div>
</div>
<!-- ОКНО ДОБАВЛЕНИЯ ЦИКЛА-->
<div id="insert_cycle_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:200px;">
            <div class="top-div">
                Добавить цикл
            </div>
            <form action="/insertCycle" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:50px;">
                    <table class="center-table" style="width: 600px;">
                        <tr style="background-color: white">
                            <td style="width: 150px; font-size: 16px;">Название</td>
                            <td>
                                <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9,.- ]{1,80}"
                                       title="Название цикла должно быть не более 80 символов и состоять из букв и/или цифр."
                                       minlength="1" maxlength="80" style="width: 400px" class="text-field" required="required" name="nameCycleInsert" value=""/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="bottom-div-zero">
                    <input type="submit" class="button green button-little" value="Сохранить" name="insert"/>
                    <input type="button" class="button gray button-little" onclick="document.getElementById('insert_cycle_popup').style.display='none';" value="Отмена"/>
                </div>
            </form>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('insert_cycle_popup').style.display='none';">X</a></div>
</div>