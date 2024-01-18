package edu.emory.abid;

import edu.emory.abid.data.Reference;
import edu.emory.abid.data.Sample;
import java.math.BigDecimal;
import java.math.MathContext;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class SampleFinder {

    public Sample populate(Reference reference) throws ParseException {

        // This is sloppy. We should set type to Date and handle conversion on
        // the client.
        SimpleDateFormat sdfIn = new SimpleDateFormat("yyyy-MM-dddd");
        SimpleDateFormat sdfOut = new SimpleDateFormat("MM/dd/yyyy");

        Sample sample = new Sample();

        // This is also sloppy. I suspect the right way to do this is to do an
        // XML-to-XML by XSLT.
        sample.setAge(reference.getAge().getFreeValue());
        try {
            sample.setCollectionDate(reference.getCollectionDate().getFreeValue() != null
                    ? sdfOut.format(sdfIn.parse(reference.getCollectionDate().getFreeValue()))
                    : null);
        } catch (ParseException e) {
            sample.setCollectionDate(null);
        }
        sample.setGenders(new Sample.Genders());
        for (Reference.Genders.Gender value : reference.getGenders().getGender()) {
            if (value.isSelected()) {
                sample.getGenders().setGender(value.getValue());
            }
        }
        sample.setBbSummaries(new Sample.BbSummaries());
        for (Reference.BbSummaries.BbSummary value : reference.getBbSummaries().getBbSummary()) {
            if (value.isSelected()) {
                sample.getBbSummaries().setBbSummary(value.getValue());
            }
        }
        sample.setQuestionSCD(new Sample.QuestionSCD());
        for (Reference.QuestionSCD.Scd value : reference.getQuestionSCD().getScd()) {
            if (value.isSelected()) {
                sample.getQuestionSCD().setSCD(value.getValue());
            }
        }
        sample.setAboRhType(new Sample.AboRhType());
        for (Reference.AboType.Abo value : reference.getAboType().getAbo()) {
            if (value.isSelected()) {
                sample.getAboRhType().setAboType(value.getValue());
            }
        }
        float freq = 1f;
        for (Reference.RhType.Rh value : reference.getRhType().getRh()) {
            if (value.isSelected()) {
                freq = value.getAntigenNegFreq().floatValue();
                Sample.AboRhType.RhType newValue = new Sample.AboRhType.RhType();
                newValue.setValue(value.getValue());
                newValue.setAntigenNegFreq(value.getAntigenNegFreq());
                sample.getAboRhType().setRhType(newValue);
            }
        }
        for (Reference.AntibodyScreen.Screen value : reference.getAntibodyScreen().getScreen()) {
            if (value.isSelected()) {
                sample.setAntibodyScreen(value.getValue());
            }
        }
        sample.setAntibodies(new Sample.Antibodies());
        for (Reference.Antibodies.Antibody value : reference.getAntibodies().getAntibody()) {
            if (value.isSelected()) {
                Sample.Antibodies.Antibody newValue = new Sample.Antibodies.Antibody();
                newValue.setValue(value.getValue());
                newValue.setHdfn(value.isHdfn());
                newValue.setSickleCell(value.isSickleCell());
                sample.getAntibodies().getAntibody().add(newValue);
            }
        }
        sample.setOtherAllo(new Sample.OtherAllo());
        for (Reference.OtherAllo.Allo value : reference.getOtherAllo().getAllo()) {
            if (value.isSelected()) {
                sample.getOtherAllo().getAllo().add(value.getValue());
            }
        }
        sample.setResultAutoControl(new Sample.ResultAutoControl());
        for (Reference.ResultAutoControl.AutoControl value : reference.getResultAutoControl().getAutoControl()) {
            if (value.isSelected()) {
                sample.getResultAutoControl().setAutoControl(value.getValue());
            }
        }
        sample.setResultDAT(new Sample.ResultDAT());
        for (Reference.ResultDAT.Dat value : reference.getResultDAT().getDat()) {
            if (value.isSelected()) {
                sample.getResultDAT().setDAT(value.getValue());
            }
        }
        for (Reference.Rhogam.RhogamQ value : reference.getRhogam().getRhogamQ()) {
            if (value.isSelected()) {
                sample.setRhogam(value.getValue());
            }
        }
        sample.setResultEluate(new Sample.ResultEluate());
        for (Reference.ResultEluate.Eluate value : reference.getResultEluate().getEluate()) {
            if (value.isSelected()) {
                sample.getResultEluate().setEluate(value.getValue());
            }
        }
        sample.setResultEluateAntibodies(reference.getResultEluateAntibodies().getFreeValue());
        sample.setAntigenNeg(new Sample.AntigenNeg());
        for (Reference.AntigenNeg.Antigen value : reference.getAntigenNeg().getAntigen()) {
            if (value.isSelected()) {
                // if (!"yes".equals(sample.getQuestionSCD().getSCD()) &&
                // value.isRespectIfAntigenNeg()) {
                // freq = freq * value.getAntigenNegFreq().floatValue();
                // }
                if (value.isRespectIfAntigenNeg()) {
                    freq = freq * value.getAntigenNegFreq().floatValue();
                }
                Sample.AntigenNeg.Antigen newValue = new Sample.AntigenNeg.Antigen();
                newValue.setValue(value.getValue());
                newValue.setAntigenNegFreq(value.getAntigenNegFreq());
                newValue.setRespectIfAntigenNeg(value.isRespectIfAntigenNeg());
                sample.getAntigenNeg().getAntigen().add(newValue);
            }
        }
        sample.setPhenotypeSCD(new Sample.PhenotypeSCD());
        for (Reference.PhenotypeSCD.AntigenSCD value : reference.getPhenotypeSCD().getAntigenSCD()) {
            if (value.isSelected()) {
                if ("yes".equals(sample.getQuestionSCD().getSCD())) {
                    // freq = freq * value.getAntigenNegFreq().floatValue();
                }
                Sample.PhenotypeSCD.AntigenSCD newValue = new Sample.PhenotypeSCD.AntigenSCD();
                newValue.setValue(value.getValue());
                newValue.setAntigenNegFreq(value.getAntigenNegFreq());
                sample.getPhenotypeSCD().getAntigenSCD().add(newValue);
            }
        }
        sample.setOverallFrequency((new BigDecimal(freq)).round(new MathContext(2)));

        return sample;

    }

}
