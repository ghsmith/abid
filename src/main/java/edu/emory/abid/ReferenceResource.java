package edu.emory.abid;

import edu.emory.abid.data.Reference;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.xml.bind.JAXBException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

@Path("reference")
public class ReferenceResource {

    private String[] sections = {
      "Demographics",
      "Serologic Testing",
      "Antibody ID"
    };
    
    @Context
    private UriInfo context;

    ReferenceFinder referenceFinder;
    
    public ReferenceResource(@Context ServletContext servletContext) throws JAXBException {
        this.referenceFinder = new ReferenceFinder(servletContext.getInitParameter("referenceXmlFileName"));
    }

    @GET
    @Produces("application/json")
    public Reference getJson(@Context HttpServletRequest req) {
        Reference reference = (Reference)req.getSession().getAttribute("reference");
        if(reference == null) {
            reference = referenceFinder.getReference();
            req.getSession().setAttribute("reference", reference);
            req.getSession().setAttribute("currentSection", 0);
        }
        return reference;
    }

    @GET
    @Path("reset")
    @Produces("application/json")
    public Reference getJsonReset(@Context HttpServletRequest req) {
        req.getSession().removeAttribute("reference");
        return getJson(req);
    }

    @PUT
    @Consumes("application/json")
    public void setJson(@Context HttpServletRequest req, Reference reference) {
        req.getSession().setAttribute("reference", reference);
    }
    
    // I must improve the following, but in a hurry...
    @GET
    @Path("responseItems")
    @Produces("application/json")
    public List<ResponseItem> getJsonResponseItems(
        @Context ServletContext servletContext,
        @Context HttpServletRequest req
    ) throws SAXException, IOException, ParserConfigurationException {
        Reference reference = (Reference)req.getSession().getAttribute("reference");
        if(reference == null) {
            reference = referenceFinder.getReference();
            req.getSession().setAttribute("reference", reference);
            req.getSession().setAttribute("currentSection", 0);
        }
        int currentSection = (int)req.getSession().getAttribute("currentSection");
        List<ResponseItem> responseItems = new ArrayList<>();
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();        
        Document document = builder.parse(new File(servletContext.getInitParameter("referenceXmlFileName")));
        NodeList nodeList = document.getElementsByTagName("*");
        for(int x = 0; x < nodeList.getLength(); x++) {
            Node node = nodeList.item(x);
            if(node.getNodeType() == Node.ELEMENT_NODE) {
                Element element = (Element)node;
                if(element.hasAttribute("section") && element.getAttribute("section").equals(sections[currentSection])) {
                    responseItems.add(new ResponseItem(
                        element.getNodeName() + "." + element.getElementsByTagName("*").item(0).getNodeName(),
                        element.getAttribute("stem"),
                        element.getAttribute("uiControl"))
                    );
                }
            }
        }
        return responseItems;
    }

    // I must improve the following, but in a hurry...
    @GET
    @Path("currSection")
    @Produces("application/json")
    public String getJsonCurrSection(
        @Context ServletContext servletContext,
        @Context HttpServletRequest req
    ) {
        Reference reference = (Reference)req.getSession().getAttribute("reference");
        if(reference == null) {
            reference = referenceFinder.getReference();
            req.getSession().setAttribute("reference", reference);
            req.getSession().setAttribute("currentSection", 0);
        }
        int currentSection = (int)req.getSession().getAttribute("currentSection");
        return sections[currentSection];
    }
    
    // I must improve the following, but in a hurry...
    @GET
    @Path("nextSection")
    @Produces("application/json")
    public String getJsonNextSection(
        @Context ServletContext servletContext,
        @Context HttpServletRequest req
    ) {
        Reference reference = (Reference)req.getSession().getAttribute("reference");
        if(reference == null) {
            reference = referenceFinder.getReference();
            req.getSession().setAttribute("reference", reference);
            req.getSession().setAttribute("currentSection", 0);
        }
        int currentSection = (int)req.getSession().getAttribute("currentSection");
        if(currentSection < sections.length - 1) {
            currentSection = currentSection + 1;
        }
        req.getSession().setAttribute("currentSection", currentSection);
        return sections[currentSection];
    }

    // I must improve the following, but in a hurry...
    @GET
    @Path("prevSection")
    @Produces("application/json")
    public String getJsonPrevSection(
        @Context ServletContext servletContext,
        @Context HttpServletRequest req
    ) {
        Reference reference = (Reference)req.getSession().getAttribute("reference");
        if(reference == null) {
            reference = referenceFinder.getReference();
            req.getSession().setAttribute("reference", reference);
            req.getSession().setAttribute("currentSection", 0);
        }
        int currentSection = (int)req.getSession().getAttribute("currentSection");
        if(currentSection > 0) {
            currentSection = currentSection - 1;
        }
        req.getSession().setAttribute("currentSection", currentSection);
        return sections[currentSection];
    }

    
    public class ResponseItem {
        public String name;
        public String stem;
        public String type;
        public ResponseItem(String name, String stem, String type) {
            this.name = name;
            this.stem = stem;
            this.type = type;
        }
    }
    
}