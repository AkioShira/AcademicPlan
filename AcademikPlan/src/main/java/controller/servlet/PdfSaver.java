package controller.servlet;


import com.lowagie.text.DocumentException;

import com.lowagie.text.pdf.BaseFont;
import org.htmlcleaner.CleanerProperties;
import org.htmlcleaner.HtmlCleaner;
import org.htmlcleaner.PrettyXmlSerializer;
import org.htmlcleaner.TagNode;
import org.xhtmlrenderer.pdf.ITextRenderer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;


@WebServlet("/toPdf")
public class PdfSaver extends HttpServlet {
    private static final String PAGE_TO_PARSE = "http://localhost:8080/page.jsp";
    private static final String CHARSET = "UTF-8";

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            resp.setContentType("application/pdf");

            byte[] pdfDoc = performPdfDocument(PAGE_TO_PARSE);

            resp.setContentLength(pdfDoc.length);
            resp.getOutputStream().write(pdfDoc);
        } catch (Exception ex) {
            resp.setContentType("text/html");

            PrintWriter out = resp.getWriter();
            out.write("<strong>Something wrong</strong><br /><br />");
            ex.printStackTrace(out);
        }
    }

    /**
     * Метод, подготавливащий PDF документ.
     * @param path путь до страницы
     * @return PDF документ
     */
    private byte[] performPdfDocument(String path) throws IOException, DocumentException {
        // Получаем HTML код страницы

        String html = "<!doctype html>\n" +
                "<html>\n" +
                "<head>\n" +
                "<meta charset=\"utf-8\">\n" +
                "<title>Учебный план</title>\n" +
                "</head>\n" +
                "<style>\n" +
                "\t* {\n" +
                "        font-family: Arial;\n" +
                "\t\t\n" +
                "    }\t\n" +
                "\n" +
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
                "</style>\n" +
                "<body style=\"padding: 20px;\">\n" +
                "\t<div style=\"font-size: 14px;\">\n" +
                "\t\t<table style=\"width: 100%;\">\n" +
                "\t\t\t<tr style=\"text-align:center;\">\n" +
                "\t\t\t\t<td style=\"font-weight: bold;\" colspan=\"2\">\n" +
                "\t\t\t\t\tМинистерство образования и науки Луганской Народной Республики <br>\n" +
                "\t\t\t\t\tГОУ ВПО ЛНР \"Донбасский государственный технический университет\" *(ДонГТУ)\n" +
                "\t\t\t\t</td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "                <td style=\"text-align: left; padding-left: 100px\">\n" +
                "                    <h4>Утверждаю</h4>\n" +
                "                    И.о. ректора _____ Зинченко А.М.<br>\n" +
                "                    \"__\"____ 2018 г.<br>\n" +
                "                    Одобрен Ученым советом ДонГТУ, протокол от __.__.г. №__\n" +
                "                </td>\n" +
                "                <td style=\"text-align: right; padding-right: 100px\">\n" +
                "                    Квалификация: <p>бакалавр</p><br>\n" +
                "                    Срок обучения: <p>4 г.</p><br>\n" +
                "                    На базе: <p>среднего общего образования</p><br>\n" +
                "                </td>\n" +
                "            </tr>\n" +
                "\t\t\t<tr>\n" +
                "                <td colspan=\"2\" style=\"text-align:center;padding-top: 20px;\">\n" +
                "                    <h3 style=\"margin-top:10px; display:inline-block;\">УЧЕБНЫЙ ПЛАН</h3>\n" +
                "                    <h4 style=\"font-style:italic; display:inline-block;\"> - год приёма 2018</h4>\n" +
                "                </td>\n" +
                "            </tr>               \n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px; font-size: 12px;\">уровень высшего образования (УВО)</td>\n" +
                "\t\t\t\t<td><p>бакалавриат</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px; font-size: 12px;\">код и наименование укрупненной группы направления подготовки</td>\n" +
                "\t\t\t\t<td><p>09.00.00  Информатика и вычислительная техника</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px; font-size: 12px;\">код и наименование направления подготовки</td>\n" +
                "\t\t\t\t<td><p>09.03.01  Информатика и вычислительная техника</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px; font-size: 12px;\">профиль (направленность)</td>\n" +
                "\t\t\t\t<td><p>Автоматизированные системы обработки информации и управления</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td style=\"padding-left: 150px; font-size: 12px;\">форма обучения</td>\n" +
                "\t\t\t\t<td><p>дневная</p></td>\n" +
                "\t\t\t</tr>\n" +
                "\t\t\t<tr>\n" +
                "\t\t\t\t<td></td>\n" +
                "\t\t\t\t<td style=\"font-size: 8px;\">(дневная, вечерняя, заочная (дистанционная), экстернат)</td>\n" +
                "\t\t\t</tr> \n" +
                "\t\t</table>\n" +
                "\t\t</div>\n" +
                "\t<div style = \"width: 90%; margin: 0 auto; font-size: 12px;\">\n" +
                "            <h3 style=\"text-align: center;\">І. ГРАФИК УЧЕБНОГО ПРОЦЕССА</h3>\n" +
                "            \n" +
                "            <h3>ОБОЗНАЧЕНИЯ:</h3>\n" +
                "            <p style=\"text-align: center; text-decoration: none;\">_ - теоретическое обучение; СК - сдача кредитов; С - сессия: К - каникулы: П - практика; Н - НИР; Г - государственный экзамен: Д - подотовка ВКР.</p>\n" +
                "       </div>\n" +
                "</body>\n" +
                "</html>\n";

        // Буффер, в котором будет лежать отформатированный HTML код
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        // Форматирование HTML кода
        /* эта процедура не обязательна, но я настоятельно рекомендую использовать этот блок */
        HtmlCleaner cleaner = new HtmlCleaner();
        CleanerProperties props = cleaner.getProperties();
        props.setCharset(CHARSET);
        TagNode node = cleaner.clean(html);
        new PrettyXmlSerializer(props).writeToStream(node, out);

        // Создаем PDF из подготовленного HTML кода
        ITextRenderer renderer = new ITextRenderer();

        renderer
                .getFontResolver()
                .addFont(getServletContext().getRealPath("resources/fonts/arial.ttf"),
                        BaseFont.IDENTITY_H,
                        BaseFont.NOT_EMBEDDED);

        renderer.setDocumentFromString(new String(out.toByteArray(), CHARSET));
        renderer.layout();
        /* заметьте, на этом этапе Вы можете записать PDF документ, скажем, в файл
         * но раз мы пишем сервлет, который будет возвращать PDF документ,
         * нам нужен массив байт, который мы отдадим пользователю */
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        renderer.createPDF(outputStream);

        // Завершаем работу
        renderer.finishPDF();
        out.flush();
        out.close();

        byte[] result = outputStream.toByteArray();
        outputStream.close();

        return result;
    }

    @Override
    public String getServletInfo() {
        return "The servlet that generate and returns pdf file";
    }
}
