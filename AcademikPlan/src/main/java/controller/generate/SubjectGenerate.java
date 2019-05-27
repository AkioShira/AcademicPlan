package controller.generate;

import controller.xml.editor.XmlEditor;
import data.dao.mariaDB.*;
import data.model.*;
import sun.awt.Symbol;

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
        String html = "<div style= \"width=100%; padding-top:30px;\"><table style = \"font-size: 10px; " +
                "text-align: center; padding-top: 100px; margin: 0 auto;\"><tr >\n" +
                "<td rowspan=\"4\" style= \"min-width:50px\">"+headList.get(0).getValue()+"</td>\n" +
                "<td rowspan=\"4\" style= \"min-width:120px; max-width:120px; width:120px;\">"+headList.get(1).getValue()+"</td>\n" +
                "<td rowspan=\"4\" >"+headList.get(2).getValue()+"</td>\n" +
                "<td rowspan=\"4\" >"+headList.get(3).getValue()+"</td>\n" +
                "<td rowspan=\"4\" >Экз.</td>\n" +
                "<td rowspan=\"4\" >Зач.</td>\n" +
                "<td rowspan=\"4\" >"+headList.get(6).getValue()+"</td>\n" +
                "<td colspan=\"7\" >"+headList.get(7).getValue()+"</td>\n" +
                "<td colspan=\""+title.getStudyTime()*8+"\">\n" +
                headList.get(8).getValue()+
                "</td>\n" +
                "</tr>";
        html +="<tr >\n" +
                "<td colspan=\"4\">Аудиторные</td>\n" +
                "<td colspan=\"3\">Самост.</td>\n";
        for(int i =1; i<=title.getStudyTime(); i++)
            html += "<td colspan=\"8\">"+i+" Курс</td>";
        html+="</tr>";
        html+="<tr style = \"font-size: 9px;\">\n" +
                "<td rowspan=\"2\">"+headList.get(9).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(10).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(11).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(12).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(13).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(14).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(15).getValue()+"</td>\n";
        for(int i =1; i<=title.getStudyTime()*2; i++)
            html += "<td colspan=\"4\">"+i+" (18)</td>";

        html+="</tr><tr style = \"font-size: 9px;\">";
        for(int i =1; i<=title.getStudyTime()*2; i++) {
            html += "<td>" + headList.get(16).getValue() + "</td>";
            html += "<td>" + headList.get(17).getValue() + "</td>";
            html += "<td>" + headList.get(18).getValue() + "</td>";
            html += "<td>" + headList.get(19).getValue() + "</td>";
        }
        html+="</tr>";

        return html;
    }

    public String getSubjects(){
        CycleMariaDb cycleDao = fb.getCycleMariaDb(connection);
        PartMariaDb partDao = fb.getPartMariaDb(connection);
        SubjectMariaDb subjectDao = fb.getSubjectMariaDb(connection);
        List<Cycle> cycleList = cycleDao.getCyclesByTitle(title.getIdTitle());
        DecimalFormatSymbols formatSymbols = new DecimalFormatSymbols(Locale.getDefault());
        formatSymbols.setDecimalSeparator('.');
        DecimalFormat df = new DecimalFormat("##.#", formatSymbols);
        List<List<Double>> sumList = new ArrayList<>();
        List<Double> sumAllList = new ArrayList<>();
        String html = "";
        // кол-во циклов
        int cCounter = 0;
        // кол-во строк для подсчета переноса
        int sCounter = 0;
        for(Cycle cycle : cycleList){
            html += getSubjectHead();
            html +="<tr style=\"font-size: 12px; text-align: left;\"><td>&nbsp;<b>"+cycle.getShortName()+"</b></td>";
            html +="<td colspan=\""+(title.getStudyTime()*8+13)+"\">&nbsp;<b>"+cycle.getName()+"</b></td>";
            html +="</tr>";
            List<Part> partList = partDao.getPartesByCycle(cycle.getIdCycle());
            sumList.clear();
            sumAllList.clear();
            //Расчёт суммы частей
            for(Part part : partList)
                sumList.add(subjectDao.getSumByPart(part.getIdPart()));
            //Расчёт суммы по циклу
            for(int i =0; i<45; i++)
                sumAllList.add(0.0);
            for (List<Double> list : sumList) {
                for (int i = 0; i < list.size(); i++) {
                    sumAllList.set(i, sumAllList.get(i) + list.get(i));
                }
            }
            // кол-во частей
            int pCount = 0;
            for(Part part : partList){
                html +="<tr style=\"font-size: 11px; text-align: left;\"><td>&nbsp;<b>"+cycle.getShortName()+"."+part.getShortName()+"</b></td>";
                html +="<td colspan=\""+(title.getStudyTime()*8+13)+"\">&nbsp;<b>"+part.getName()+"</b></td>";
                html +="</tr>";
                List<Subject> subjectList = subjectDao.getSubjectsByPart(part.getIdPart());
                // Заполнение циклов
                for(Subject subject : subjectList){
                    double allAud = subject.getLec()*18 + subject.getLab()*18 + subject.getPract()*18;
                    double allSelf = subject.getSelf()*18 + subject.getBsr();
                    double all = allAud+allSelf;
                    html +="<tr>";
                    html +="<td style=\"text-align: left;\">&nbsp;"+cycle.getShortName()+"."+part.getShortName()
                           +df.format(subject.getNumber())+"</td>";
                    if(subject.getName().length()>15)
                        sCounter++;
                    html +="<td style=\"text-align: left; font-size: 9px;\">"+subject.getName()+"</td>";
                    html +="<td>"+subject.getDepart()+"</td>";
                    html +="<td>"+df.format(all/36)+"</td>";
                    html +="<td>"+subject.getExams()+"</td>";
                    html +="<td>"+subject.getCredits()+"</td>";
                    html +="<td>"+df.format(all)+"</td>";
                    html +="<td>"+df.format(allAud)+"</td>";
                    html +="<td>"+df.format(subject.getLec()*18)+"</td>";
                    html +="<td>"+df.format(subject.getLab()*18)+"</td>";
                    html +="<td>"+df.format(subject.getPract()*18)+"</td>";
                    html +="<td>"+df.format(allSelf)+"</td>";
                    html +="<td>"+df.format(subject.getSelf()*18)+"</td>";
                    html +="<td>"+subject.getBsr()+"</td>";
                    for(int i =1; i<=title.getStudyTime()*2; i++) {
                        if (subject.getExams() == i || subject.getCredits() == i) {
                            html += "<td>" + df.format(subject.getLec()) + "</td>";
                            html += "<td>" + df.format(subject.getLab()) + "</td>";
                            html += "<td>" + df.format(subject.getPract()) + "</td>";
                            html += "<td>" + df.format(subject.getSelf()) + "</td>";
                        } else {
                            html += "<td></td><td></td><td></td><td></td>";
                        }
                    }
                    html +="</tr>";
                    // Перенос цикла на сл страницу
                    if(sCounter>40){
                        html +="</table></div>";
                        html += "<div class=\"new_page\"></div>";
                        html += getSubjectHead();
                    }
                    sCounter++;
                }
                // Заполнение суммы по части
                html +="<tr><td></td><td><b>Итого по части</b></td><td></td>";
                for(int i =1; i<=title.getStudyTime()*8+11; i++){
                    html +="<td>"+df.format(sumList.get(pCount).get(i-1))+"</td>";
                }
                html +="</tr>";
                pCount++;
                sCounter++;
            }
            // Заполнение суммы по циклу
            html +="<tr><td></td><td><b>ИТОГО ПО ЦИКЛУ</b></td><td></td>";
            for(int i =1; i<=title.getStudyTime()*8+11; i++){
                html +="<td>"+df.format(sumAllList.get(i-1))+"</td>";
            }
            html +="</tr>";
            html +="</table></div>";
            if(cCounter<cycleList.size()-1)
                html += "<div class=\"new_page\"></div>";
            cCounter++;
        }




        return html;
    }
}
