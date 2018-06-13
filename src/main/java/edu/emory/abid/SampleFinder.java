package edu.emory.abid;

import edu.emory.abid.data.Reference;
import edu.emory.abid.data.Sample;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class SampleFinder {

    public Sample populate(Reference reference) throws ParseException {

        // This is sloppy. We should set type to Date and handle conversion on
        // the client.
        SimpleDateFormat sdfIn = new SimpleDateFormat("yyyy-MM-dddd");
        SimpleDateFormat sdfOut = new SimpleDateFormat("MM/dd/yyyy");
        
        Sample sample = new Sample();
        
        sample.setResidentName(reference.getResidentName());
        sample.setMrn(reference.getMrn());
        sample.setLastName(reference.getLastName());
        sample.setFirstName(reference.getFirstName());
        sample.setAge(reference.getAge());
        sample.setCollectionDate(reference.getCollectionDate() != null ? sdfOut.format(sdfIn.parse(reference.getCollectionDate())) : null);
        sample.setHospital(new Sample.Hospital());
        for(Reference.Hospital.HospitalLoc value : reference.getHospital().getHospitalLoc()) {
            if(value.isSelected()) { sample.getHospital().setHospitalLoc(value.getValue()); }
        }
        sample.setGenders(new Sample.Genders());
        for(Reference.Genders.Gender value : reference.getGenders().getGender()) {
            if(value.isSelected()) { sample.getGenders().setGender(value.getValue()); }
        }
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
        for(Reference.AntibodyScreen.Screen value : reference.getAntibodyScreen().getScreen()) {
            if(value.isSelected()) { sample.setAntibodyScreen(value.getValue()); }
        }
        sample.setAntibodies(new Sample.Antibodies());
        for(Reference.Antibodies.Antibody value : reference.getAntibodies().getAntibody()) {
            if(value.isSelected()) { sample.getAntibodies().getAntibody().add(value.getValue()); }
        }
        sample.setOtherAllo(new Sample.OtherAllo());
        for(Reference.OtherAllo.Allo value : reference.getOtherAllo().getAllo()) {
            if(value.isSelected()) { sample.getOtherAllo().getAllo().add(value.getValue()); }
        }
        sample.setResultDAT(new Sample.ResultDAT());
        for(Reference.ResultDAT.DAT value : reference.getResultDAT().getDAT()) {
            if(value.isSelected()) { sample.getResultDAT().setDAT(value.getValue()); }
        }
        for(Reference.Rhogam.RhogamQ value : reference.getRhogam().getRhogamQ()) {
            if(value.isSelected()) { sample.setRhogam(value.getValue()); }
        }
        sample.setResultEluate(new Sample.ResultEluate());
        for(Reference.ResultEluate.Eluate value : reference.getResultEluate().getEluate()) {
            if(value.isSelected()) { sample.getResultEluate().setEluate(value.getValue()); }
        }
        sample.setAntigenNeg(new Sample.AntigenNeg());
        for(Reference.AntigenNeg.Antigen value : reference.getAntigenNeg().getAntigen()) {
            if(value.isSelected()) { sample.getAntigenNeg().getAntigen().add(value.getValue()); }
        }
        sample.setPhenotypeSCD(new Sample.PhenotypeSCD());
        for(Reference.PhenotypeSCD.AntigenSCD value : reference.getPhenotypeSCD().getAntigenSCD()) {
            if(value.isSelected()) { sample.getPhenotypeSCD().getAntigenSCD().add(value.getValue()); }
        }
        
        return sample;

    }
    
}
