package edu.emory.abid;

import edu.emory.abid.data.Reference;
import edu.emory.abid.data.Sample;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

@WebServlet(name = "SampleXMLServlet", urlPatterns = {"/SampleXMLServlet"})
public class SampleXMLServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Reference reference = (Reference)request.getSession().getAttribute("reference");
        Sample sample = new Sample();
        
        // copy selections from reference to sample (consider doing with XML/XPath?)
        {
            sample.setHospital(new Sample.Hospital());
            for(Reference.Hospital.HospitalLoc value : reference.getHospital().getHospitalLoc()) {
                if(value.isSelected()) { sample.getHospital().setHospitalLoc(value.getValue()); }
            }
            sample.setMrn("999999999");
            sample.setLastName("Doe");
            sample.setFirstName("John");
            sample.setCollectionDate("06/07/2018");
            sample.setGenders(new Sample.Genders());
            for(Reference.Genders.Gender value : reference.getGenders().getGender()) {
                if(value.isSelected()) { sample.getGenders().setGender(value.getValue()); }
            }
            sample.setAge("35");
            sample.setBbSummaries(new Sample.BbSummaries());
            for(Reference.BbSummaries.BbSummary value : reference.getBbSummaries().getBbSummary()) {
                if(value.isSelected()) { sample.getBbSummaries().setBbSummary(value.getValue()); }
            }
            sample.setQuestionSCD(new Sample.QuestionSCD());
            for(Reference.QuestionSCD.SCD value : reference.getQuestionSCD().getSCD()) {
                if(value.isSelected()) { sample.getQuestionSCD().setSCD(value.getValue()); }
            }
            sample.setAboRhType(new Sample.AboRhType());
            for(Reference.AboRhType.AboType.Abo value : reference.getAboRhType().getAboType().getAbo()) {
                if(value.isSelected()) { sample.getAboRhType().setAboType(value.getValue()); }
            }
            for(Reference.AboRhType.RhType.Rh value : reference.getAboRhType().getRhType().getRh()) {
                if(value.isSelected()) { sample.getAboRhType().setRhType(value.getValue()); }
            }

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
        }
        
    }

}
