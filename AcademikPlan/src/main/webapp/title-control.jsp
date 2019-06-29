<%--
  Created by IntelliJ IDEA.
  User: Arthur
  Date: 21.05.2019
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type='text/javascript'>
    function showControl(){
    document.getElementById('control_popup').style.display='block';
    }

</script>
<!-- РЕДАКТИРОВАТЬ -->
<div id="control_popup" class="parent_popup">
    <div class="popup-big">
        <div class="popup-form" style="height:470px;">
            <div class="top-div">
                Контроль версий плана
            </div>
            <div class="center-div">
                <table class="center-table">
                    <tr>
                        <th>Наименование</th>
                        <th>Дата/время</th>
                        <th style="width: 260px;"></th>
                    </tr>

                    <tr>
                        <td>бакалавр1</td>
                        <td>01.06.2019 14:20:06</td>
                        <td>
                            <input type="button" class="button red button-little" onclick="" value="Удалить"/>
                            <input type="button" class="button blue button-little" onclick="" value="Загрузить"/>

                        </td>
                    </tr>
                    <tr>
                        <td>бакалавр2</td>
                        <td>01.06.2019 14:21:10</td>
                        <td>
                            текущая
                        </td>
                    </tr>

                </table>
            </div>
            <div style = "padding: 20px 250px 0px 250px;">
                <input type="button" class="button blue button-little" onclick="" value="Добавить" name="restore-all"/>
                <input type="button" class="button gray button-little" onclick="document.getElementById('control_popup').style.display='none';" value="Отмена"/>
            </div>
        </div>
        <a class="close" title="Закрыть" onclick="document.getElementById('control_popup').style.display='none';">X</a></div>
</div>