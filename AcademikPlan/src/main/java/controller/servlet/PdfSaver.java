package controller.servlet;


import com.lowagie.text.DocumentException;

import com.lowagie.text.pdf.BaseFont;
import connection.pooling.ConnectionPool;
import controller.generate.TitleGenerate;
import controller.xml.editor.XmlEditor;
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
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.Connection;


@WebServlet("/toPdf")
public class PdfSaver extends HttpServlet {
    private static final String CHARSET = "UTF-8";

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            resp.setContentType("application/pdf");

            Connection connection = ConnectionPool.getConnection();
            XmlEditor xmlEditor = new XmlEditor(getServletContext().getRealPath("resources/servlet-text.xml"));
            HttpSession session = req.getSession();
            int id = (int) session.getAttribute("idTitle");
            TitleGenerate title = new TitleGenerate(connection, xmlEditor, id);
            byte[] pdfDoc = performPdfDocument(title);

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
     * @return PDF документ
     */
    private byte[] performPdfDocument(TitleGenerate title) throws IOException, DocumentException {
        String html = "<!doctype html>\n" +
                "<html>\n" +
                "<head>\n" +
                "<meta charset=\"utf-8\">\n" +
                "<title>Учебный план</title>\n" +
                "</head>" + title.getStyle() +
                "<body style=\"padding: 20px;\">\n" +
                "\t<div style=\"font-size: 14px;\">" + title.getHeadTable()+title.getStudyShedules()+title.getBudget()+
                title.getPractic()+title.getStateSertification();
        html += "</div></body>\n" +
                "</html>";



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
