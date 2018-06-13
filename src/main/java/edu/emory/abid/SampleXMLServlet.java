package edu.emory.abid;

import edu.emory.abid.data.Reference;
import edu.emory.abid.data.Sample;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

@WebServlet(name = "sampleXMLServlet", urlPatterns = {"/sampleXMLServlet"})
public class SampleXMLServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Reference reference = (Reference)request.getSession().getAttribute("reference");
        Sample sample;
        try {
            sample = new SampleFinder().populate(reference);
        } catch (ParseException ex) {
            throw new RuntimeException(ex);
        }
        
        // marshal sample to XML
        try {
            JAXBContext jc0 = JAXBContext.newInstance("edu.emory.abid.data");
            Marshaller marshaller = jc0.createMarshaller();
            marshaller.setProperty(javax.xml.bind.Marshaller.JAXB_ENCODING, "UTF-8");
            marshaller.setProperty(javax.xml.bind.Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.marshal(sample, out);            
        }
        catch (JAXBException ex) {
            throw new RuntimeException(ex);
        }
        
    }

}
