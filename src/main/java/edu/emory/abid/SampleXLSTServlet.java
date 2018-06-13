package edu.emory.abid;

import edu.emory.abid.data.Reference;
import edu.emory.abid.data.Sample;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

@WebServlet(name = "sampleXLSTServlet", urlPatterns = {"/sampleXLSTServlet"})
public class SampleXLSTServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Reference reference = (Reference)request.getSession().getAttribute("reference");
        Sample sample = new SampleFinder().populate(reference);
        
        File sampleXmlFile = null;
        
        // marshal sample to XML
        try {
            JAXBContext jc0 = JAXBContext.newInstance("edu.emory.abid.data");
            Marshaller marshaller = jc0.createMarshaller();
            marshaller.setProperty(javax.xml.bind.Marshaller.JAXB_ENCODING, "UTF-8");
            marshaller.setProperty(javax.xml.bind.Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            sampleXmlFile = File.createTempFile("sample", ".xml");
            OutputStream os = new FileOutputStream(sampleXmlFile);
            marshaller.marshal(sample, os);            
        }
        catch (JAXBException ex) {
        }

        // XSL transform
        try {
            TransformerFactory factory = TransformerFactory.newInstance();
            Source xsl = new StreamSource(new File(getServletContext().getInitParameter("xslFileName")));
            Source text = new StreamSource(sampleXmlFile);
            Transformer transformer = factory.newTransformer(xsl);
            transformer.transform(text, new StreamResult(out));
        } catch (TransformerConfigurationException ex) {
            throw new RuntimeException(ex);
        } catch (TransformerException ex) {
            throw new RuntimeException(ex);
        }
        
    }

}
