package controller.generate;

import controller.xml.editor.XmlEditor;
import data.dao.mariaDB.*;
import data.model.*;

import java.sql.Connection;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

public class ResultGenerate {
    private Connection connection;
    private XmlEditor xmlEditor;
    private FactoryMariaDb fb;
    private Title title;

    public ResultGenerate(Connection connection, XmlEditor xmlEditor, int idTitle){
        this.connection = connection;
        this.xmlEditor = xmlEditor;

        fb = new FactoryMariaDb();
        TitleMariaDb titleDao = fb.getTitleMariaDb(connection);
        title = titleDao.getTitleById(idTitle);
    }

    public String getResultHead(){
        List<NodePage> headList = xmlEditor.getArrayXml("table-hmp");
        String html = "<div style= \"width=100%; padding-top:30px;\">" +
                "<table style = \"font-size: 11px; text-align: center; padding-top: 100px; margin: 0 auto;\">\n" +
                "<tr>\n" +
                "<td rowspan=\"4\" style=\"width: 200px; max-width: 200px;\" colspan=\"2\"></td>\n" +
                "<td rowspan=\"4\" class=\"rotatable\">"+headList.get(3).getValue()+"</td>\n" +
                "<td rowspan=\"4\" class=\"rotatable\">"+headList.get(6).getValue()+"</td>\n" +
                "<td colspan=\"7\" >"+headList.get(7).getValue()+"</td>\n" +
                "<td colspan=\""+(title.getStudyTime()*4)+"\">\n" + headList.get(8).getValue()+"\n" +
                "</td>\n" +
                "</tr>\n" +
                "<tr>\n" +
                "<td colspan=\"4\">Аудиторные</td>\n" +
                "<td colspan=\"3\">Самост.</td>\n";

        for(int i = 1; i<=title.getStudyTime(); i++){
            html += "<td colspan=\"4\">"+i+" Курс</td>";
        }

        html += "</tr><tr><td rowspan=\"2\">"+headList.get(9).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(10).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(11).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(12).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(13).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(14).getValue()+"</td>\n" +
                "<td rowspan=\"2\">"+headList.get(15).getValue()+"</td>\n";

        for(int i = 1; i<=title.getStudyTime()*2-1; i++){
            html += "<td colspan=\"2\">"+i+" (18)</td>";
        }
        html += "<td colspan=\"2\">"+title.getStudyTime()*2+" (9)</td></tr><tr>";

        for(int i=1; i<=title.getStudyTime()*2; i++){
            html += "<td>Ауд.</td><td>Сам.</td>";
        }

        html +="</tr>";

        return html;
    }

    public String getContent(){
        DecimalFormatSymbols formatSymbols = new DecimalFormatSymbols(Locale.getDefault());
        formatSymbols.setDecimalSeparator('.');
        DecimalFormat df = new DecimalFormat("##.#", formatSymbols);

        //Заполнение циклов
        CycleMariaDb cycleDao = fb.getCycleMariaDb(connection);
        List<Cycle> cycleList = cycleDao.getCyclesByTitle(title.getIdTitle());

        SubjectMariaDb subjectDao = fb.getSubjectMariaDb(connection);

        //Физкультура
        PhysicalMariaDb physicalDao = fb.getPhysicalMariaDb(connection);
        List<Physical> physicalList = physicalDao.getPhysicalsByTitle(title.getIdTitle());
        List<Double> sumAudPhysical = new ArrayList<>();
        for(Physical p : physicalList){

            double sum = 0;
            for(double d : p.getWeek())
                sum+=d*18;
            sumAudPhysical.add(sum);
        }

        //Сумма аудиторных часов
        List<Double> sumAudList = subjectDao.getSumAudByTitle(title.getIdTitle());
        for(int i = 0; i<sumAudList.size(); i++)
            for(Physical p : physicalList)
                sumAudList.set(i, sumAudList.get(i)+p.getWeek().get(i));

        //Сумма самостоятельных часов
        List<Double> sumSelfList = subjectDao.getSumSelfByTitle(title.getIdTitle());
        //Сумма всего
        List<Double> sumList = new ArrayList<>();
        boolean isMore=false;
        for(int i = 0; i<sumAudList.size(); i++){
            double j = sumAudList.get(i) + sumSelfList.get(i);
            sumList.add(j);
            if(j>54)
                isMore = true;
        }

        //Количество экзаменов
        List<Double> examList = subjectDao.getCountExamsByTitle(title.getIdTitle());
        //Количество зачетов
        List<Double> creditList = subjectDao.getCountCreditsByTitle(title.getIdTitle());
        //Количество КП
        List<Double> kpList = subjectDao.getCountKPByTitle(title.getIdTitle());
        //Сумма кредитов
        List<Double> sumZeList = subjectDao.getSumCredByTitle(title.getIdTitle());

        for(int i = 0; i<sumZeList.size(); i++)
            sumZeList.set(i, sumZeList.get(i)+physicalList.get(0).getWeek().get(i));

        isMore = false;
        for(double d : sumZeList){
            if(d>30)
                isMore = true;
        }
        //Сумма БСР
        List<Double> sumBSRList = subjectDao.getSumBSRByTitle(title.getIdTitle());

        PartMariaDb partDao = fb.getPartMariaDb(connection);
        List<Part> partList = partDao.getPartesByTitle(title.getIdTitle());
        //Сумма частей
        List<List<Double>> sumPartList = new ArrayList<>();
        for(Part part : partList)
            sumPartList.add(subjectDao.getSumByPart(part.getIdPart(), title.getStudyTime()));

        //Сумма без пфк
        List<Double> sumWithoutPFK = new ArrayList<>();
        for(int i =0; i<45; i++)
            sumWithoutPFK.add(0.0);

        for (List<Double> list : sumPartList) {
            for (int i = 0; i < list.size(); i++) {
                sumWithoutPFK.set(i, sumWithoutPFK.get(i) + list.get(i));
            }
        }

        //Сумма з.е
        double sumZE = 0;
        for(double d : sumZeList)
            sumZE += d;

        int countCycle = cycleDao.getCountCycleByTitle(title.getIdTitle());

        //Заполнение практик
        PractMariaDb practDao = fb.getPractMariaDb(connection);
        List<Pract> practList = practDao.getPractsByTitle(title.getIdTitle());

        PractTypesMariaDb typesDao = fb.getPractTypesMariaDb(connection);
        List<PractType> practTypes = typesDao.getAllPractTypes();

        //
        HashMap<Integer, String> typeMap = new HashMap<Integer, String>();
        for(PractType t : practTypes)
            typeMap.put(t.getIdPractType(), t.getName());

        //Сумма практик
        List<Double> sumPract = new ArrayList<>();
        for(int i = 0; i<4+title.getStudyTime()*2; i++)
            sumPract.add(0.0);

        for(Pract p : practList){
            sumPract.set(0, sumPract.get(0)+p.getWeek()*54.0/36.0);
            sumPract.set(1, sumPract.get(1)+p.getWeek()*54);
            sumPract.set(2, sumPract.get(2)+p.getWeek()*54);
            sumPract.set(3, sumPract.get(3)+p.getWeek()*54);
            for(int i = 1; i <= title.getStudyTime()*2; i++){
                if(p.getSemester()==i)
                    sumPract.set(i+3, sumPract.get(i)+p.getWeek()*54.0/36.0);
            }
        }

        //Заполнение гос аттестаций
        StateSertificationMariaDb stateDao = fb.getStateSertificationMariaDb(connection);
        List<StateSertification> stateList = stateDao.getSertificationsByTitle(title.getIdTitle());

        SertificationTypesMariaDb stateTypeDao = fb.getSertificationTypesMariaDb(connection);
        List<SertificationType> stateTypes = stateTypeDao.getAllSertificationTypes();
        //
        HashMap<Integer, String> stateMap = new HashMap<Integer, String>();
        for(SertificationType t : stateTypes)
            stateMap.put(t.getIdSertificationType(), t.getName());

        //Сумма гос. аттестаций
        List<Double> sumState = new ArrayList<>();
        for(int i = 0; i<4+title.getStudyTime()*2; i++)
            sumState.add(0.0);

        for(StateSertification s : stateList){
            sumState.set(0, sumState.get(0)+s.getZe());
            sumState.set(1, sumState.get(1)+s.getZe()*36);
            sumState.set(2, sumState.get(2)+s.getZe()*36);
            sumState.set(3, sumState.get(3)+s.getZe()*36);
            for(int i = 1; i <= title.getStudyTime()*2; i++){
                if(s.getSemester()==i)
                    sumState.set(i+3, sumState.get(i)+s.getZe());
            }
        }

        //Имена
        NameMariaDb nameDao = fb.getNameMariaDb(connection);
        Name name = nameDao.getNameByTitle(title.getIdTitle());

        //Физ культура 1
        String html = "<tr>\n" +
                "<td style=\"text-align: left\" colspan=\""+(title.getStudyTime()*4+11)+"\">\n" +
                "<b>Б"+(countCycle+1)+" Физическая культура</b>\n" +
                "</td>\n" +
                "</tr><tr>\n" +
                "<td style=\"text-align: left\" colspan=\"2\">Б"+(countCycle+1)+".1 "+physicalList.get(0).getName()+"</td>\n" +
                "<td>" + df.format((sumAudPhysical.get(0)+physicalList.get(0).getBsr())/36) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+physicalList.get(0).getBsr()) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)) + "</td>\n" +
                "<td></td>\n" +
                "<td></td>\n" +
                "<td>" + physicalList.get(0).getBsr() + "</td>\n" +
                "<td></td>\n" +
                "<td>\n" + physicalList.get(0).getBsr() + "</td>\n";
        for(int i =1; i<=title.getStudyTime()*2; i++){
            html +="<td>" + df.format(physicalList.get(0).getWeek().get(i-1))+"</td><td></td>";
        }
        html +="</tr>";

        //Физ культура 2
        html += "<tr>"+
                "<td style=\"text-align: left\" colspan=\"2\">Б"+(countCycle+1)+".2 "+physicalList.get(1).getName()+"</td>\n" +
                "<td>-</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(1)+physicalList.get(1).getBsr()) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(1)) + "</td>\n" +
                "<td></td>\n" +
                "<td></td>\n" +
                "<td>" + df.format(sumAudPhysical.get(1)) + "</td>\n" +
                "<td>" + physicalList.get(1).getBsr() + "</td>\n" +
                "<td></td>\n" +
                "<td>\n" + physicalList.get(1).getBsr() + "</td>\n";
        for(int i =1; i<=title.getStudyTime()*2; i++){
            html +="<td>" + df.format(physicalList.get(1).getWeek().get(i-1))+"</td><td></td>";
        }
        html +="</tr>";
        //теоретич подготовка
        html += "<tr>\n" +
                "<td style=\"text-align: left\" rowspan=\"3\">\n" +
                "Теоретическая подготовка\n" +
                "</td>\n" +
                "<td>Всего</td>\n" +
                "<td>" + df.format((sumAudPhysical.get(0)+physicalList.get(0).getBsr())/36 +sumWithoutPFK.get(0)) +"</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+physicalList.get(0).getBsr()+sumAudPhysical.get(1)+physicalList.get(1).getBsr()+sumWithoutPFK.get(3))+"</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+sumAudPhysical.get(1)+sumWithoutPFK.get(4)) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+sumWithoutPFK.get(5)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(6)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(7)+sumAudPhysical.get(1)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(8)+physicalList.get(0).getBsr()+physicalList.get(1).getBsr())+"</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(9))+"</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(10)+physicalList.get(0).getBsr()+physicalList.get(1).getBsr())+"</td>\n";

        for(int i = 1; i<= title.getStudyTime()*2; i++){
            html+= "<td>"+sumAudList.get(i-1)+"</td><td>"+sumSelfList.get(i-1)+"</td>";
        }
        html +="</tr>";

        //без пфк
        html += "<tr>\n" +
                "<td>без ПФК*</td>\n" +
                "<td>" + df.format((sumAudPhysical.get(0)+physicalList.get(0).getBsr())/36+sumWithoutPFK.get(0)) +"</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+physicalList.get(0).getBsr()+sumWithoutPFK.get(3))+"</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+sumWithoutPFK.get(4)) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+sumWithoutPFK.get(5)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(6)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(7)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(8)+physicalList.get(0).getBsr())+"</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(9))+"</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(10)+physicalList.get(0).getBsr())+"</td>\n";

        for(int i = 1; i<= title.getStudyTime()*2; i++){
            html+= "<td colspan=\"2\">" +  df.format(sumList.get(i-1))+"</td>";
        }
        html +="</tr>";

        html += "<tr><td>з.е</td><td>"+sumZE+"</td><td colspan=\"8\"></td>";

        for(int i =1; i<=title.getStudyTime()*2; i++)
            html+="<td colspan=\"2\">"+sumZeList.get(i-1)+"</td>";
        html +="</tr>";

        //Практика
        html += "<tr><td style=\"text-align: left\" colspan=\"11\"><b>Б"+(countCycle+2)+" Практическая подготовка</b>\n" +
                "</td><td colspan=\""+title.getStudyTime()*4+"\">з.е.</td></tr>";

        for(int j =1; j<=practList.size(); j++){
            html += "<tr>\n" +
                    "<td style=\"text-align: left\" colspan=\"2\">Б"+(countCycle+2)+"."+j+" " + typeMap.get(practList.get(j-1).getIdPractType())+"</td>\n" +
                    "<td>" + df.format(practList.get(j-1).getWeek()*54.0/36.0) + "</td>\n" +
                    "<td>" + practList.get(j-1).getWeek()*54 + "</td>\n" +
                    "<td></td><td></td><td></td><td></td>\n" +
                    "<td>" + practList.get(j-1).getWeek()*54 + "</td>\n" +
                    "<td>" + practList.get(j-1).getWeek()*54 + "</td>\n" +
                    "<td></td>\n";

            for(int i = 1; i<=title.getStudyTime()*2; i++){
                if(practList.get(j-1).getSemester() == i){
                    html += "<td colspan=\"2\">" + df.format(practList.get(j-1).getWeek()*54.0/36.0) + "</td>\n";
                }
                if(practList.get(j-1).getSemester() != i){
                    html += "<td colspan=\"2\"></td>";
                }
            }
            html += "</tr>";
        }

        html += "<tr><td style=\"text-align: left\" colspan=\"2\">Всего</td>\n" +
                "<td>" + df.format(sumPract.get(0)) + "</td>\n" +
                "<td>" + df.format(sumPract.get(1)) + "</td>\n" +
                "<td></td><td></td><td></td><td></td>\n" +
                "<td>" + df.format(sumPract.get(2)) + "</td>\n" +
                "<td>" + df.format(sumPract.get(3)) + "</td>\n" +
                "<td></td>\n" +
                "<td colspan=\""+title.getStudyTime()*4+"\"></td>\n" +
                "</tr>";

        //Гос аттестация
        html += "<tr><td style=\"text-align: left\" colspan=\"11\">\n" +
                "<b>Б" + (countCycle+3) + " Государственная итоговая аттестация</b>\n" +
                "</td><td colspan=\"" + title.getStudyTime()*4+"\">з.е.</td></tr>";

        for(int j =1; j<=stateList.size(); j++){
            html += "<tr>\n" +
                    "<td style=\"text-align: left\" colspan=\"2\">Б" + (countCycle+3)+"." + j + " " + stateMap.get(stateList.get(j-1).getIdSertificationType())+ "</td>\n" +
                    "<td>" + stateList.get(j-1).getZe() + "</td>\n" +
                    "<td>" + stateList.get(j-1).getZe()*36 + "</td>\n" +
                    "<td></td><td></td><td></td><td></td>\n" +
                    "<td>" + stateList.get(j-1).getZe()*36 + "</td>\n" +
                    "<td>" + stateList.get(j-1).getZe()*36 + "</td>\n" +
                    "<td></td>\n";
            for(int  i =1; i<=title.getStudyTime()*2; i++){
                if(stateList.get(j-1).getSemester() == i){
                    html +="<td colspan=\"2\">" + stateList.get(j-1).getZe() + "</td>";
                }
                if(stateList.get(j-1).getSemester() != i){
                    html +="<td colspan=\"2\"></td>";
                }
            }
            html += "</tr>";
        }

        html += "<tr>\n" +
                "<td style=\"text-align: left\" colspan=\"2\">Всего</td>\n" +
                "<td>" + sumState.get(0)+"</td>\n" +
                "<td>" + sumState.get(1)+"</td>\n" +
                "<td></td><td></td><td></td><td></td>\n" +
                "<td>" + sumState.get(2)+"</td>\n" +
                "<td>" + sumState.get(3)+"</td>\n" +
                "<td></td>\n" +
                "<td colspan=\"" + title.getStudyTime()*4 + "</td>\n" +
                "</tr>";
        // Подготовка бакалавра
        // всего**
        html += "<tr>\n" +
                "<td rowspan=\"2\">Подготовка бакалавра:</td>\n" +
                "<td>всего**</td>\n" +
                "<td>" + df.format((sumAudPhysical.get(0)+physicalList.get(0).getBsr())/36+sumWithoutPFK.get(0)+sumPract.get(0)+sumState.get(0)) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+physicalList.get(0).getBsr() +sumAudPhysical.get(1)+physicalList.get(1).getBsr()+sumWithoutPFK.get(3)+sumPract.get(1)+sumState.get(1)) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+sumAudPhysical.get(1)+sumWithoutPFK.get(4)) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+sumWithoutPFK.get(5)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(6)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(7)+sumAudPhysical.get(1)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(8)+physicalList.get(0).getBsr()+physicalList.get(1).getBsr()+sumPract.get(2)+sumState.get(2)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(9)+sumPract.get(3)+sumState.get(3)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(10)+physicalList.get(0).getBsr()+physicalList.get(1).getBsr()) + "</td>\n";
        for(int i = 1; i<=title.getStudyTime()*2; i++)
            html += "<td rowspan=\"2\" colspan=\"2\">"  + df.format(sumZeList.get(i-1)+sumPract.get(i+3)+sumState.get(i+3)) + "</td>";
        html +="</tr>";

        // без ПФК
        html += "<tr><td>без ПФК</td><td>" +
                df.format((sumAudPhysical.get(0)+physicalList.get(0).getBsr())/36+sumWithoutPFK.get(0) +
                sumPract.get(0)+sumState.get(0)) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+physicalList.get(0).getBsr()+sumWithoutPFK.get(3)+sumPract.get(1)+sumState.get(1)) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+sumWithoutPFK.get(4)) + "</td>\n" +
                "<td>" + df.format(sumAudPhysical.get(0)+sumWithoutPFK.get(5)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(6)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(7)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(8)+physicalList.get(0).getBsr()+sumPract.get(2)+sumState.get(2)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(9)+sumPract.get(3)+sumState.get(3)) + "</td>\n" +
                "<td>" + df.format(sumWithoutPFK.get(10)+physicalList.get(0).getBsr()) + "</td>\n" +
                "</tr>";

        html += "<tr><td colspan=\"4\" style=\"border: 0px;\"></td><td colspan=\"7\">з.е. за год</td>\n";

        for(int i =1; i<=title.getStudyTime()*2; i+=2){
            html += "<td colspan=\"4\">" + df.format(sumZeList.get(i-1)+sumPract.get(i+3)+sumState.get(i+3)+sumZeList.get(i)
                    +sumPract.get(i+4)+sumState.get(i+4)) + "</td>";
        }

        html += "</tr><tr><td style=\"border: 0px;\">&nbsp;</td></tr><tr>"+
                "<td style=\"border: 0px; font-style: italic;\" colspan=\"3\" rowspan=\"2\">\n" +
                "*  - в зачетные единицы не переводится. Зачеты по ПФК также не включаются в общее число зачетов.\n" +
                "</td>\n" +
                "<td style=\"border: 0px;\" rowspan=\"2\"></td>\n" +
                "<td colspan=\"7\">Количество зачетов</td>\n";

        for(int i =1; i<= title.getStudyTime()*2; i++){
            html +="<td colspan=\"2\">" + creditList.get(i-1) + "</td>";
        }
        html += "</tr>";

        html += "<tr><td colspan=\"7\">Кол-во экзаменов, в т.ч. ГОС</td>";

        for(int i =1; i<=title.getStudyTime()*2; i++){
            html += "<td colspan=\"2\">" + df.format(examList.get(i-1)) + "</td>\n";
        }
        html += "</tr><tr><td style=\"border: 0px; font-style: italic;\" colspan=\"3\" rowspan=\"2\">** " +
                "Общая трудоёмкость основной образовательной программы ";
        html += df.format(sumAudPhysical.get(0)+physicalList.get(0).getBsr()
                +sumWithoutPFK.get(3)+sumPract.get(1)+sumState.get(1));
        html += "час. +" + df.format(sumAudPhysical.get(1)+physicalList.get(1).getBsr()) + " час. прикладной физической культуры";
        html +="</td><td style=\"border: 0px;\" rowspan=\"2\"></td><td colspan=\"7\">Количество учебных дисциплин</td>";
        for(int i=1; i<=title.getStudyTime()*2; i++)
            html += "<td colspan=\"2\">" + df.format(creditList.get(i-1)+examList.get(i-1)) + "</td>";
        html += "</tr><tr><td colspan=\"7\">Кол-во экзаменов, в т.ч. ГОС</td>";
        for(int i=1; i<=title.getStudyTime()*2; i++)
            html += "<td colspan=\"2\">" + df.format(kpList.get(i-1)) + "</td>";
        html += "</tr><tr><td style=\"border: 0px;\">&nbsp;</td></tr><tr><td style=\"border: 0px;\">&nbsp;</td></tr>"+
                "<tr><td style=\"border: 0px;\">&nbsp;</td></tr><tr><td style=\"border: 0px;\">&nbsp;</td></tr>";

        //имена
        html += "<tr><td style=\"border: 0px;\"></td><td style=\"border: 0px; text-align: left;\" colspan=\"13\"><h3>И.о. первого проректора по учебной работе</h3></td>\n" +
                "<td style=\"border: 0px;\" colspan=\"" + (title.getStudyTime()*4-2) + "\">" + name.getProrectorName()+ "</td></tr>";
        html += "<tr><td style=\"border: 0px;\"></td><td style=\"border: 0px; text-align: left;\" colspan=\"13\"><h3>Начальник учебного отдела</h3></td>" +
                "<td style=\"border: 0px;\" colspan=\"" + (title.getStudyTime()*4-3) + "\">" + name.getStudyName() + "</td></tr>";
        html += "<tr><td style=\"border: 0px;\"></td><td style=\"border: 0px; text-align: left;\" colspan=\"13\"><h3>И.о. декана факультета автоматизации и электротехнических систем</h3></td>" +
                "<td style=\"border: 0px;\" colspan=\"" + (title.getStudyTime()*4-3) + "\">" + name.getDecanName() + "</td></tr>";
        html += "<tr><td style=\"border: 0px;\"></td><td style=\"border: 0px; text-align: left;\" colspan=\"13\"><h3>Заведующий кафедрой</h3></td>" +
                "<td style=\"border: 0px;\" colspan=\"" + (title.getStudyTime()*4-3) + "\">" + name.getDepartName() + "</td></tr>";

        html +="</table></div>";
        return html;
    }
}
