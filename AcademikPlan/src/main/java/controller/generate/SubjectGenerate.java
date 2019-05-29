package controller.generate;

import controller.xml.editor.XmlEditor;
import data.dao.mariaDB.*;
import data.model.*;

import java.sql.Connection;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class SubjectGenerate {
    private Connection connection;
    private XmlEditor xmlEditor;
    private Title title;

    private FactoryMariaDb fb;

    public SubjectGenerate(Connection connection, XmlEditor xmlEditor, int idTitle){
        this.connection = connection;
        this.xmlEditor = xmlEditor;

        fb = new FactoryMariaDb();
        TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
        title = titleDao.getTitleById(idTitle);
    }

    private String getSubjectHead(){
        List<NodePage> headList = xmlEditor.getArrayXml("table-hmp");
        StringBuilder html = new StringBuilder("<div style= \"width=100%; padding-top:30px;\"><table style = \"font-size: 10px; " +
                "text-align: center; padding-top: 100px; margin: 0 auto;\"><tr >\n" +
                "<td rowspan=\"4\" style= \"min-width:40px\">" + headList.get(0).getValue() + "</td>\n" +
                "<td rowspan=\"4\" style= \"min-width:120px; max-width:120px; width:120px;\">" + headList.get(1).getValue() + "</td>\n" +
                "<td rowspan=\"4\" >" + headList.get(2).getValue() + "</td>\n" +
                "<td rowspan=\"4\" >" + headList.get(3).getValue() + "</td>\n" +
                "<td rowspan=\"4\" >Экз.</td>\n" +
                "<td rowspan=\"4\" >Зач.</td>\n" +
                "<td rowspan=\"4\" >" + headList.get(6).getValue() + "</td>\n" +
                "<td colspan=\"7\" >" + headList.get(7).getValue() + "</td>\n" +
                "<td colspan=\"" + title.getStudyTime() * 8 + "\">\n" +
                headList.get(8).getValue() +
                "</td>\n" +
                "</tr>");
        html.append("<tr >\n" + "<td colspan=\"4\">Аудиторные</td>\n" + "<td colspan=\"3\">Самост.</td>\n");
        for(int i =1; i<=title.getStudyTime(); i++)
            html.append("<td colspan=\"8\">").append(i).append(" Курс</td>");
        html.append("</tr>");
        html.append("<tr style = \"font-size: 9px;\">\n" + "<td rowspan=\"2\">").append(headList.get(9).getValue()).append("</td>\n").append("<td rowspan=\"2\">").append(headList.get(10).getValue()).append("</td>\n").append("<td rowspan=\"2\">").append(headList.get(11).getValue()).append("</td>\n").append("<td rowspan=\"2\">").append(headList.get(12).getValue()).append("</td>\n").append("<td rowspan=\"2\">").append(headList.get(13).getValue()).append("</td>\n").append("<td rowspan=\"2\">").append(headList.get(14).getValue()).append("</td>\n").append("<td rowspan=\"2\">").append(headList.get(15).getValue()).append("</td>\n");
        for(int i =1; i<title.getStudyTime()*2; i++)
            html.append("<td colspan=\"4\">").append(i).append(" (18)</td>");
        html.append("<td colspan=\"4\">").append(title.getStudyTime() * 2).append(" (19)</td>");

        html.append("</tr><tr style = \"font-size: 9px;\">");
        for(int i =1; i<=title.getStudyTime()*2; i++) {
            html.append("<td>").append(headList.get(16).getValue()).append("</td>");
            html.append("<td>").append(headList.get(17).getValue()).append("</td>");
            html.append("<td>").append(headList.get(18).getValue()).append("</td>");
            html.append("<td>").append(headList.get(19).getValue()).append("</td>");
        }
        html.append("</tr>");

        return html.toString();
    }

    public String getSubjects(){
        CycleMariaDb cycleDao = fb.getCycleMariaDb(connection);
        PartMariaDb partDao = fb.getPartMariaDb(connection);
        SubjectMariaDb subjectDao = fb.getSubjectMariaDb(connection);
        SubSubjectMariaDb subSubjectDao = fb.getSubSubjectMariaDb(connection);
        List<Cycle> cycleList = cycleDao.getCyclesByTitle(title.getIdTitle());
        DecimalFormatSymbols formatSymbols = new DecimalFormatSymbols(Locale.getDefault());
        formatSymbols.setDecimalSeparator('.');
        DecimalFormat df = new DecimalFormat("##.#", formatSymbols);
        List<List<Double>> sumList = new ArrayList<>();
        List<Double> sumAllList = new ArrayList<>();
        StringBuilder html = new StringBuilder();
        // кол-во циклов
        int cCounter = 0;

        for(Cycle cycle : cycleList){
            html.append(getSubjectHead());
            html.append("<tr style=\"font-size: 12px; text-align: left;\"><td>&nbsp;<b>").append(cycle.getShortName()).append("</b></td>");
            html.append("<td colspan=\"").append(title.getStudyTime() * 8 + 13).append("\">&nbsp;<b>").append(cycle.getName()).append("</b></td>");
            html.append("</tr>");
            List<Part> partList = partDao.getPartesByCycle(cycle.getIdCycle());
            sumList.clear();
            sumAllList.clear();
            //Расчёт суммы частей
            for(Part part : partList)
                sumList.add(subjectDao.getSumByPart(part.getIdPart(), title.getStudyTime()));
            //Расчёт суммы по циклу
            for(int i =0; i<45; i++)
                sumAllList.add(0.0);
            for (List<Double> list : sumList) {
                for (int i = 0; i < list.size(); i++) {
                    sumAllList.set(i, sumAllList.get(i) + list.get(i));
                }
            }
            // кол-во строк для подсчета переноса
            int sCounter = 0;
            // кол-во частей
            int pCount = 0;
            for(Part part : partList){

                html.append("<tr style=\"font-size: 11px; text-align: left;\"><td>&nbsp;<b>").append(cycle.getShortName()).append(".").append(part.getShortName()).append("</b></td>");
                html.append("<td colspan=\"").append(title.getStudyTime() * 8 + 13).append("\">&nbsp;<b>").append(part.getName()).append("</b></td>");
                html.append("</tr>");
                List<Subject> subjectList = subjectDao.getSubjectsByPart(part.getIdPart());

                //Заполнение дисциплин по выбору
                for(Subject s : subjectList)
                    s.setSubSubjectList(subSubjectDao.getSubSubjectsBySubject(s.getIdSubject()));

                for(Subject subject : subjectList){
                    // Перенос цикла на сл страницу
                    if(sCounter>40){
                        html.append("</table></div>");
                        html.append("<div class=\"new_page\"></div>");
                        html.append(getSubjectHead());
                        sCounter = 0;
                    }

                    double allAud = subject.getLec()*18 + subject.getLab()*18 + subject.getPract()*18;
                    double allSelf = subject.getSelf()*18 + subject.getBsr();
                    double all = allAud+allSelf;
                    html.append("<tr>");
                    html.append("<td style=\"text-align: left;\">&nbsp;").append(cycle.getShortName()).append(".").append(part.getShortName()).append(df.format(subject.getNumber())).append("</td>");
                    // Вычислить кол-во строк занимаемых дисциплиной. длина строк/символов в строке
                    sCounter+=subject.getName().length()/24;

                    html.append("<td style=\"text-align: left; font-size: 9px;\">").append(subject.getName()).append("</td>");
                    html.append("<td>").append(subject.getDepart()).append("</td>");
                    html.append("<td>").append(df.format(all / 36)).append("</td>");
                    html.append("<td>").append(subject.getExams()).append("</td>");
                    html.append("<td>").append(subject.getCredits()).append("</td>");
                    html.append("<td>").append(df.format(all)).append("</td>");
                    html.append("<td>").append(df.format(allAud)).append("</td>");
                    html.append("<td>").append(df.format(subject.getLec() * 18)).append("</td>");
                    html.append("<td>").append(df.format(subject.getLab() * 18)).append("</td>");
                    html.append("<td>").append(df.format(subject.getPract() * 18)).append("</td>");
                    html.append("<td>").append(df.format(allSelf)).append("</td>");
                    html.append("<td>").append(df.format(subject.getSelf() * 18)).append("</td>");
                    html.append("<td>").append(subject.getBsr()).append("</td>");
                    for(int i =1; i<=title.getStudyTime()*2; i++) {
                        if (subject.getExams() == i || subject.getCredits() == i) {
                            html.append("<td>").append(df.format(subject.getLec())).append("</td>");
                            html.append("<td>").append(df.format(subject.getLab())).append("</td>");
                            html.append("<td>").append(df.format(subject.getPract())).append("</td>");
                            html.append("<td>").append(df.format(subject.getSelf())).append("</td>");
                        } else {
                            html.append("<td></td><td></td><td></td><td></td>");
                        }
                    }
                    html.append("</tr>");

                    //Печать дисциплин по выбору
                    int subNumber = 1;
                    for(SubSubject ss : subject.getSubSubjectList()){

                        // Перенос цикла на сл страницу
                        if(sCounter>40){
                            html.append("</table></div>");
                            html.append("<div class=\"new_page\"></div>");
                            html.append(getSubjectHead());
                            sCounter = 0;
                        }

                        html.append("<tr><td style=\"text-align: left;\">&nbsp;").append(cycle.getShortName()).append(".").append(part.getShortName()).append(df.format(subject.getNumber())).append(".").append(subNumber).append("</td>");
                        html.append("<td style=\"text-align: left;\">").append(ss.getName()).append("</td>");
                        html.append("<td>").append(subject.getDepart()).append("</td>");
                        for(int i =0; i<title.getStudyTime()*8+11; i++)
                            html.append("<td></td>");
                        html.append("</tr>");
                        subNumber++;
                        sCounter++;
                    }

                    sCounter++;
                }
                // Печать суммы по части
                html.append("<tr><td></td><td><b>Итого по части</b></td><td></td>");
                for(int i =1; i<=title.getStudyTime()*8+11; i++){
                    html.append("<td>").append(df.format(sumList.get(pCount).get(i - 1))).append("</td>");
                }
                html.append("</tr>");
                pCount++;
                sCounter++;
            }
            // Заполнение суммы по циклу
            html.append("<tr><td></td><td><b>ИТОГО ПО ЦИКЛУ</b></td><td></td>");
            for(int i =1; i<=title.getStudyTime()*8+11; i++){
                html.append("<td>").append(df.format(sumAllList.get(i - 1))).append("</td>");
            }
            html.append("</tr>");
            html.append("</table></div>");
            if(cCounter<cycleList.size()-1)
                html.append("<div class=\"new_page\"></div>");
            cCounter++;
        }
        return html.toString();
    }
}
