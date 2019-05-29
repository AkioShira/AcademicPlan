<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 30.03.2019
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fmt:setLocale value="en_US"/>

<script type='text/javascript'>

    function deletePart(idpk, name){
        document.getElementById('delete_part_popup').style.display='block';
        var el=document.getElementById('idPartDelete');
        el.value = idpk;
        document.getElementById('text-part-delete').innerHTML = "Удалить часть '"+name+"'? (Так же удалятся все дисциплины, принадлежащие к этой части)";
    }

    function addPart() {
        document.getElementById('insert_part_popup').style.display='block';
    }

</script>

<!-- РЕДАКТИРОВАТЬ ЧАСТИ -->
<div id="part_popup" class="parent_popup">
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
                    <c:forEach items="${partList}" var="part" varStatus="status">
                        <tr>
                            <td>${part.shortName}</td>
                            <td>${part.name}</td>
                            <td>
                                <input type="button" class="button red button-little" onclick="deletePart(${part.idPart}, '${part.shortName}');" value="Удалить"/>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
            <div style = "padding: 20px 250px 0px 250px;">
                <c:if test="${partList.size()<=5}">
                    <input type="button" class="button blue button-little" onclick="addPart();" value="Добавить" name="restore-all"/>
                </c:if>
                <input type="button" class="button gray button-little" onclick="document.getElementById('part_popup').style.display='none';" value="Отмена"/>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('part_popup').style.display='none';">X</a></div>
</div>

<!-- ОКНО ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ ЧАСТИ -->
<div id="delete_part_popup" class="parent_popup">
    <div class="popup">
        <form action="/deletePart" method="POST" class="popup-form" style="height:140px;">
            <div id="text-part-delete" class="top-div">
            </div>
            <div class="bottom-div-two">
                <input type="number" hidden id="idPartDelete" name="idPartDelete"/>
                <input type="submit" class="button red button-little" value="Подтвердить"/>
                <input type="button" class="button gray button-little" onclick="document.getElementById('delete_part_popup').style.display='none';" value="Отмена"/>
            </div>
        </form>
        <a class="close" title="Закрыть" onclick="document.getElementById('delete_part_popup').style.display='none';">X</a>
    </div>
</div>

<!-- ДОБАВИТЬ ЧАСТЬ -->
<div id="insert_part_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:250px;">
            <div class="top-div">
                Добавить часть
            </div>
            <form action="/insertPart" autocomplete="off" method="POST">
                <div class="center-div-update" style="height:100px;">
                    <table class="center-table" style="width: 600px;">
                        <tr>
                            <td style="width: 150px; font-size: 16px;">Код части</td>
                            <td>
                                <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9 ]{1,10}"
                                       title="Код части должен быть не более 10 символов и состоять из букв и/или цифр."
                                       minlength="1" maxlength="10" style="width: 400px" class="text-field" required="required" name="shortNamePartInsert" value=""/>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td style="width: 150px; font-size: 16px;">Название</td>
                            <td>
                                <input type="text" pattern="^(?![ ])[А-Яа-яA-Za-z0-9,.- ]{1,80}"
                                       title="Название части должно быть не более 80 символов и состоять из букв и/или цифр."
                                       minlength="1" maxlength="80" style="width: 400px" class="text-field" required="required" name="namePartInsert" value=""/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="bottom-div-zero">
                    <input type="submit" class="button green button-little" value="Сохранить" name="insert"/>
                    <input type="button" class="button gray button-little" onclick="document.getElementById('insert_part_popup').style.display='none';" value="Отмена"/>
                </div>
            </form>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('insert_part_popup').style.display='none';">X</a></div>
</div>
