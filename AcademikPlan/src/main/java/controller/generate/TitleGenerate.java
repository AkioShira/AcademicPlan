package controller.generate;

import controller.xml.editor.XmlEditor;
import data.dao.mariaDB.*;
import data.model.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class TitleGenerate {
    private Connection connection;
    private XmlEditor xmlEditor;

    private FactoryMariaDb fb;
    private List<NodePage> titleList;
    private Title title;
    String[] courses = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"};

    public TitleGenerate(Connection connection, XmlEditor xmlEditor, int idTitle){
        this.connection = connection;
        this.xmlEditor = xmlEditor;

        fb = new FactoryMariaDb();
        titleList = xmlEditor.getArrayXml("content");
        TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
        title = titleDao.getTitleById(idTitle);
    }

    public String getHeadTable(){
        GroupDirectionMariaDb groupDao = fb.getGroupDirectionMariaDb(connection);
        DirectionMariaDb directionDao = fb.getDirectionMariaDb(connection);
        ProfileMariaDb profileDao = fb.getProfileMariaDb(connection);
        GroupDirection groupDirection = groupDao.getDirectionById(title.getIdGroupDirection());
        Direction direction = directionDao.getDirectionById(title.getIdDirection());
        Profile profile = profileDao.getProfileById(title.getIdProfile());

        return "<table style=\"width: 100%; font-size: 12px;\">\n" +
                "\t\t\t<tr style=\"text-align:center;\">\n" +
                "\t\t\t\t<td style=\"font-weight: bold;\" colspan=\"2\">\n" +
                titleList.get(0).getValue() + " <br>\n" +
                titleList.get(1).getValue() +
                "\t\t\t\t</td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "                <td style=\"text-align: left; padding-left: 100px\">\n" +
                "                    <h4>"+titleList.get(2).getValue()+"</h4>\n" +
                "                    И.о. ректора _____ "+titleList.get(3).getValue()+"<br>\n" +
                "                    \"__\"____ "+title.getYearCreation()+" г.<br>\n"
                + titleList.get(4).getValue()+" __.__. "+title.getYearCreation()+ " г. №__\n </td>\n" +
                "                <td style=\"text-align: right; padding-right: 100px\">\n" +
                titleList.get(5).getValue()+" <p>"+title.getQualification()+"</p><br>\n" +
                titleList.get(6).getValue()+" <p>"+title.getStudyTime()+" г.</p><br>\n" +
                titleList.get(7).getValue()+" <p>среднего общего образования</p><br>\n" +
                "                </td>\n" +
                "            </tr>\n" +
                "\t\t\t<tr>\n" +
                "                <td colspan=\"2\" style=\"text-align:center;padding-top: 20px;\">\n" +
                "                    <h3 style=\"margin-top:10px; display:inline-block;\">"+ titleList.get(8).getValue()+"</h3>\n" +
                "                    <h4 style=\"font-style:italic; display:inline-block;\">"+ titleList.get(9).getValue()+" "+title.getYearReception()+"</h4>\n" +
                "                </td>\n" +
                "            </tr>               \n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px;\">"+ titleList.get(10).getValue()+"</td>\n" +
                "\t\t\t\t<td><p>"+title.getStudyLevel()+"</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px; \">"+ titleList.get(11).getValue()+"</td>\n" +
                "\t\t\t\t<td><p>"+groupDirection.getNumber()+" "+groupDirection.getName()+"</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px;\">"+ titleList.get(12).getValue()+"</td>\n" +
                "\t\t\t\t<td><p>"+direction.getNumber()+" "+direction.getName()+"</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px;\">"+ titleList.get(13).getValue()+"</td>\n" +
                "\t\t\t\t<td><p>"+profile.getName()+"</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px; \">"+ titleList.get(14).getValue()+"</td>\n" +
                "\t\t\t\t<td><p>"+title.getFormEducation()+"</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td></td>\n" +
                "\t\t\t\t<td style=\"font-size: 8px;\">"+ titleList.get(15).getValue()+"</td>\n" +
                "\t\t\t</tr> \n" +
                "\t\t</table>";
    }

    public String getStudyShedules(){

        int[] row0 = {29,5,12,19,26,3,10,17,24,31,7,14,21,28,5,12,19,26,2,9,16,23,30,
                6,13,20,27,6,13,20,27,3,10,17,24,1,8,15,22,29,5,12,19,26,3,10,17,24,31,7,14,21};
        int[] row1 = {4,11,18,25,2,9,16,23,30,6,13,20,27,4,11,18,25,1,8,15,22,29,5,12,19,26,5,12,
                19,26,2,9,16,23,30,7,14,21,28,4,11,18,25,2,9,16,23,30,6,13,20,27};
        StudyShedulesMariaDb sheduleDao = fb.getStudySheduleMariaDb(connection);
        List<List<StudyShedule>> sheduleList = new ArrayList<>();
        for(int i=1; i<=title.getStudyTime(); i++)
            sheduleList.add(sheduleDao.getSheduleByTitleCourse(title.getIdTitle(), i));
        List<NodePage> titleShedules = xmlEditor.getArrayXml("month");
        StringBuilder html = new StringBuilder("<div style = \"width: 90%; margin: 0 auto; font-size: 12px; padding-top: 10px;\">\n" +
                "<h4 style=\"text-align: center;\">" + titleList.get(18).getValue() + "</h4> <table " +
                "border=\"1\" style=\"width:100%; text-align: center; \">\n" +
                "<tr> <td rowspan=\"4\" style=\"width:40px\">КУРС</td>\n" +
                "<td colspan=\"4\">" + titleShedules.get(0).getValue() + "</td>\n" +
                "<td colspan=\"5\">" + titleShedules.get(1).getValue() + "</td>\n" +
                "<td colspan=\"4\">" + titleShedules.get(2).getValue() + "</td>\n" +
                "<td colspan=\"4\">" + titleShedules.get(3).getValue() + "</td>\n" +
                "<td colspan=\"5\">" + titleShedules.get(4).getValue() + "</td>\n" +
                "<td colspan=\"4\">" + titleShedules.get(5).getValue() + "</td>\n" +
                "<td colspan=\"4\">" + titleShedules.get(6).getValue() + "</td>\n" +
                "<td colspan=\"4\">" + titleShedules.get(7).getValue() + "</td>\n" +
                "<td colspan=\"5\">" + titleShedules.get(8).getValue() + "</td>\n" +
                "<td colspan=\"4\">" + titleShedules.get(9).getValue() + "</td>\n" +
                "<td colspan=\"4\">" + titleShedules.get(10).getValue() + "</td>\n" +
                "<td colspan=\"5\">" + titleShedules.get(11).getValue() + "</td></tr>");
        html.append("<tr>");
        for(int i=1; i<=52; i++){
            html.append("<td>").append(i).append("</td>");
        }
        html.append("</tr>");
        html.append("<tr>");
        for(int s: row0)
            html.append("<td>").append(s).append("</td>");
        html.append("</tr>");
        html.append("<tr>");
        for(int s: row1)
            html.append("<td>").append(s).append("</td>");
        html.append("</tr>");
        for(int i=0; i<title.getStudyTime(); i++){
            html.append("<tr>");
            html.append("<td>").append(courses[i]).append("</td>");
            for(StudyShedule ss : sheduleList.get(i))
                html.append("<td>").append(ss.getLabel()).append("</td>");
            html.append("</tr>");
        }
        html.append("</table>");
        html.append("<h5>").append(titleList.get(16).getValue()).append("</h5>");
        html.append("<p style=\"text-align: center; text-decoration: none; font-size: 10px;\">").append(titleList.get(17).getValue()).append("</p>");
        html.append("</div>");
        return html.toString();
    }

    public String getBudget(){
        StudyShedulesMariaDb sheduleDao = fb.getStudySheduleMariaDb(connection);
        List<Budget> budgets = sheduleDao.getBudgetByTitle(title.getIdTitle(), title.getStudyTime());
        List<NodePage> budgetList = xmlEditor.getArrayXml("budget");
        StringBuilder html = new StringBuilder("<div style=\"width: 400px; float: left; font-size: 12px; padding-left: 50px; padding-top: 20px;\">\n" +
                "                    <h4 style=\"text-align: center;\">" + titleList.get(19).getValue() + "</h4>\n" +
                "                    <table border=\"1\" style=\"font-size: 12px; text-align: center;\">\n" +
                "                        <tr>");
        for(NodePage node : budgetList)
            html.append("<td class=\"rotatable\">").append(node.getValue()).append("</td>");
        html.append("</tr>");
        for(int i =0; i<title.getStudyTime(); i++){
            html.append("<tr>");
            html.append("<td>").append(courses[i]).append("</td>");
            html.append("<td>").append(budgets.get(i).getTheory()).append("</td>");
            html.append("<td>").append(budgets.get(i).getExam()).append("</td>");
            html.append("<td>").append(budgets.get(i).getPractic()).append("</td>");
            html.append("<td>").append(budgets.get(i).getQualification()).append("</td>");
            html.append("<td>").append(budgets.get(i).getStateExam()).append("</td>");
            html.append("<td>").append(budgets.get(i).getHolidays()).append("</td>");
            html.append("<td>").append(budgets.get(i).getAll()).append("</td>");
            html.append("</tr>");
        }
        html.append("<tr>");
        html.append("<td>Всего</td>");
        html.append("<td>").append(budgets.get(title.getStudyTime()).getTheory()).append("</td>");
        html.append("<td>").append(budgets.get(title.getStudyTime()).getExam()).append("</td>");
        html.append("<td>").append(budgets.get(title.getStudyTime()).getPractic()).append("</td>");
        html.append("<td>").append(budgets.get(title.getStudyTime()).getQualification()).append("</td>");
        html.append("<td>").append(budgets.get(title.getStudyTime()).getStateExam()).append("</td>");
        html.append("<td>").append(budgets.get(title.getStudyTime()).getHolidays()).append("</td>");
        html.append("<td>").append(budgets.get(title.getStudyTime()).getAll()).append("</td>");
        html.append("</tr></table>\n" + "                </div>");
        return html.toString();
    }

    public String getPractic(){
        PractMariaDb practDao = fb.getPractMariaDb(connection);
        List<Pract> practList = practDao.getPractsByTitle(title.getIdTitle());
        PractTypesMariaDb typesDao = fb.getPractTypesMariaDb(connection);
        List<PractType> practTypes = typesDao.getAllPractTypes();
        HashMap<Integer, String> typeMap = new HashMap<Integer, String>();
        for(PractType t : practTypes)
            typeMap.put(t.getIdPractType(), t.getName());
        List<NodePage> practHeadList = xmlEditor.getArrayXml("headPractics");
        StringBuilder html = new StringBuilder("<div style=\"width: 200px; float: left; padding-left: 30px; font-size: 12px; padding-top: 20px;\">\n" +
                "                    <h4 style=\"text-align: center;\">" + titleList.get(20).getValue() + "</h4>\n" +
                "                    <table border=\"1\" style=\"text-align: center;\">\n" +
                "                        <tr style=\"height: 45px;\">");
        for(NodePage node : practHeadList)
            html.append("<td>").append(node.getValue()).append("</td>");
        html.append(" </tr>");
        for(Pract pract : practList){
            html.append("<tr><td>").append(typeMap.get(pract.getIdPractType())).append("</td>");
            html.append("<td>").append(pract.getSemester()).append("</td>");
            html.append("<td>").append(pract.getWeek()).append("</td></tr>");
        }
        html.append("</table></div>");
        return html.toString();
    }

    public String getStateSertification(){
        StateSertificationMariaDb stateDao = fb.getStateSertificationMariaDb(connection);
        List<StateSertification> listState = stateDao.getSertificationsByTitle(title.getIdTitle());
        List<NodePage> headList = xmlEditor.getArrayXml("headState");
        String html = "<div style=\"width: 300px; font-size: 12px; float: left; padding-left: 30px; padding-top: 20px;\">\n" +
                "                    <h4 style=\"text-align: center;\">"+titleList.get(21).getValue()+
                "</h4>\n" +
                "                    <table border=\"1\" style=\"font-size: 12px; text-align: center;\">\n" +
                "                        <tr style=\"height: 45px;\">";
        for(NodePage node : headList)
            html+="<td>"+node.getValue()+"</td>";
        html+="</tr>\n" +
                "<tr>\n" +
                "<td>Государственная итоговая аттестация</td>\n" +
                "<td>Государственный экзамен</td><td>"+listState.get(0).getSemester()+"</td>\n" +
                "                        </tr>\n" +
                "                        <tr>\n" +
                "                            <td>Государственная итоговая аттестация</td>\n" +
                "                            <td>Выпускная квалификационная работа</td>\n" +
                "                            <td>"+listState.get(1).getSemester()+"</td>\n" +
                "                        </tr>\n" +
                "                    </table>\n" +
                "                </div>";
        return html;
    }

    public String getStyle(){
        return "<style>\n" +
                "\t* {\n" +
                "        font-family: Arial;\n" +
                "\t\t\n" +
                "    }\t\n" +
                "\t\n" +
                "\t.rotatable{\n" +
                "   font-size: 11px; transform: rotate(-90deg);\n" +
                "}\n" +
                "\t\n" +
                "\ttable{\n" +
                "\t\ttable-layout: fixed; border-color: black;\n" +
                "    \tborder-collapse: collapse;\n" +
                "    \tmargin: 0 auto;\n" +
                "\t}\n" +
                "\t\n" +
                "\ttd{\n" +
                "\t\tmin-width: 15px;\n" +
                "\t}\n" +
                "\t\n" +
                "\t@page {\n" +
                "        margin: 0px;\n" +
                "        padding: 0px;\n" +
                "        size: A4 landscape;\n" +
                "    }\n" +
                "\n" +
                "    @media print {\n" +
                "        .new_page {\n" +
                "            page-break-after: always;\n" +
                "        }\n" +
                "    }\n" +
                "\n" +
                "    body *{\n" +
                "        padding: 0;\n" +
                "        margin: 0;\n" +
                "    }\n" +
                "\t\n" +
                "\tp{\n" +
                "\t\tdisplay: inline-block; font-size: 12px; margin: 0px;\n" +
                "\t}\n" +
                "</style>";
    }
}
