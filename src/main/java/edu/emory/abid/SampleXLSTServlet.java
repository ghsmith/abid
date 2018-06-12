package edu.emory.abid;

import edu.emory.abid.data.ObjectFactory;
import edu.emory.abid.data.Reference;
import edu.emory.abid.data.Sample;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SampleXLSTServlet", urlPatterns = {"/SampleXLSTServlet"})
public class SampleXLSTServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Reference reference = (Reference)request.getSession().getAttribute("reference");
        
        // copy selections from reference to sample (consider doing with XML/XPath?)
        Sample sample = new Sample();
        {
            sample.setHospital(new Sample.Hospital());
            for(Reference.Hospital.HospitalLoc hospitalLoc : reference.getHospital().getHospitalLoc()) {
                if(hospitalLoc.isSelected()) { sample.getHospital().setHo
        }
        
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SampleXLSTServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SampleXLSTServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

}
