package controller.xml.editor;

import data.model.NodePage;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.FileOutputStream;
import java.net.URL;
import java.util.ArrayList;

public class XmlEditor {
    private Document document;
    private String path;

    public XmlEditor(String path){
        this.path = path;
        openXML();
    }

    private void openXML(){

        File xmlFile = new File(path);
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        try{
            builder = factory.newDocumentBuilder();
            document = builder.parse(xmlFile);
            document.getDocumentElement().normalize();
        }catch (Exception e){}
    }

    public ArrayList<NodePage> getArrayXml(String name){
        ArrayList<NodePage> names = new ArrayList<>();
        try{
            NodeList nodeList = document.getElementsByTagName(name);
            for(int i=0;i<nodeList.getLength();i++) {
                NodePage node = new NodePage();
                node.setItem(i);
                node.setNodeName(name);
                node.setValue(nodeList.item(i).getTextContent());
                names.add(node);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return names;
    }

    public boolean edit(NodePage nodePage){
        try{
            document.getElementsByTagName(nodePage.getNodeName()).item(nodePage.getItem()).setTextContent(nodePage.getValue());
            Transformer tr = TransformerFactory.newInstance().newTransformer();
            DOMSource source = new DOMSource(document);
            FileOutputStream fos = new FileOutputStream(path);
            StreamResult result = new StreamResult(fos);
            tr.transform(source, result);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
