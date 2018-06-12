package edu.emory.abid;

import edu.emory.abid.data.Reference;
import java.io.File;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;

public class ReferenceFinder {

    Reference reference;
    
    public ReferenceFinder(String xmlFileName) throws JAXBException {
        JAXBContext jc0 = JAXBContext.newInstance("edu.emory.abid.data");
        reference = (edu.emory.abid.data.Reference)jc0.createUnmarshaller().unmarshal(new File(xmlFileName));
    }

    public Reference getReference() {
        return reference;
    }
    
}
