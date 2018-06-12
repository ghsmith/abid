package edu.emory.abid;

import edu.emory.abid.data.Reference;
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

@Path("reference")
public class ReferenceResource {

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
    
}