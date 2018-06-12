package edu.emory.abid;

import edu.emory.abid.data.Reference;
import javax.xml.bind.JAXBException;

public class Test01 {

    public static void main(String[] args) throws JAXBException {
        ReferenceFinder referenceFinder = new ReferenceFinder("data/antibody_report_reference.xml");
        Reference reference = referenceFinder.getReference();
        System.out.println(reference.getHospital().getHospitalLoc());
    }
    
}
