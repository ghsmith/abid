<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="html"/>
    
    <xsl:template match="/sample">
        
        <html>
            <body>
                <p> Blood Bank Summary:
                    <xsl:value-of select="bbSummaries/bbSummary"></xsl:value-of>
                    <xsl:choose>
                        <xsl:when test="bbSummaries/bbSummary = 'Routine'"> antibody identification and/or blood product special requirements evaluation. Please allow an extra 1-2 hours to find compatible blood for transfusion.</xsl:when>
                        <xsl:when test="bbSummaries/bbSummary = 'Complex'"> antibody identification and/or blood product special requirements evaluation. Please allow an extra 24 hours to find compatible blood for transfusion.</xsl:when>
                        <xsl:when test="bbSummaries/bbSummary = 'Highly complex'"> antibody identification and/or blood product special requirements evaluation. Please allow an extra 2-3 days to find compatible blood for transfusion.</xsl:when>
                        <xsl:otherwise> (Error! Please choose the appropriate Blood Bank Summary category.) </xsl:otherwise>
                    </xsl:choose>
                </p>
                <p>
                    A blood sample received on <xsl:value-of select="collectionDate"/> typed as group
                    <xsl:value-of select="aboRhType/aboType"/><xsl:text>, </xsl:text><xsl:value-of select="aboRhType/rhType"/>.    
                    <xsl:choose>
                        <xsl:when test="antibodyScreen = 'negative'">The antibody screen is negative. </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="count(antibodies/antibody) > 0">Panel identification
                                    <xsl:choose>
                                        <xsl:when test="count(antibodies/antibody) = 1 and (antibodies/antibody) = 'warm autoantibody'">reveals a warm autoantibody.</xsl:when>
                                        <xsl:otherwise>
                                            <xsl:if test="count(antibodies/antibody) = 1">reveals an </xsl:if>
                                            <xsl:if test="count(antibodies/antibody) > 1">revealed </xsl:if>
                                            <xsl:choose>
                                                <xsl:when test="count(antibodies/antibody) > 1 and (antibodies/antibody) = 'warm autoantibody'">a </xsl:when>
                                            </xsl:choose>    
                                            <xsl:for-each select="antibodies/antibody">
                                                <xsl:if test="count(../antibody) > 1 and position() = last()"><xsl:text> and</xsl:text></xsl:if>
                                                <xsl:if test="position() > 1"><xsl:text> </xsl:text></xsl:if>
                                                <xsl:value-of select="current()"/>
                                                <xsl:if test="position() != last() and count(../antibody) > 2"><xsl:text>,</xsl:text></xsl:if>   
                                            </xsl:for-each>
                                            <xsl:if test="count(antibodies/antibody) = 1"> antibody.</xsl:if>
                                            <xsl:if test="count(antibodies/antibody) > 1"> antibodies.</xsl:if>
                                        </xsl:otherwise>
                                    </xsl:choose>    
                                </xsl:when>
                            </xsl:choose>    
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="antibodyScreen = 'negative'"></xsl:when>
                        <xsl:otherwise>
                            All other common clinically significant alloantibodies were
                            <xsl:value-of select="otherAllo/allo"></xsl:value-of>.
                        </xsl:otherwise>
                    </xsl:choose>
                    The autocontrol was <xsl:value-of select="resultAutoControl/autoControl"/>.
                    The DAT was <xsl:value-of select="resultDAT/DAT"/>.
                    <xsl:choose>
                        <xsl:when test="resultAutoControl/autoControl = 'negative' and resultDAT/DAT = 'negative'"> </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="resultEluate/eluate = 'not performed'"></xsl:when>
                                <xsl:when test="resultEluate/eluate = 'negative'">The eluate is negative. </xsl:when>
                                <xsl:when test="resultEluate/eluate = 'panagglutination'">The eluate demonstrates panagglutination. </xsl:when>
                                <xsl:when test="resultEluate/eluate = 'positive for... (specify below)'">The eluate is positive for
                                    <xsl:value-of select="resultEluateAntibodies" />.
                                    <!--xsl:for-each select="antibodies/antibody">
                                    <xsl:if test="count(../antibody) > 1 and position() = last()"><xsl:text> and</xsl:text></xsl:if>
                                    <xsl:if test="position() > 1"><xsl:text> </xsl:text></xsl:if>
                                    <xsl:value-of select="current()"/>
                                    <xsl:if test="position() != last() and count(../antibody) > 2"><xsl:text>,</xsl:text></xsl:if>   
                                </xsl:for-each><xsl:text>. </xsl:text-->
                                </xsl:when>
                            </xsl:choose>     
                        </xsl:otherwise>    
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="questionSCD/SCD = 'yes'">The patient's phenotype or predicted phenotype is:
                            <xsl:for-each select="phenotypeSCD/antigenSCD">
                                <xsl:if test="count(../antigenSCD) > 1 and position() = last()"><xsl:text> and</xsl:text></xsl:if>
                                <xsl:if test="position() > 1"><xsl:text> </xsl:text></xsl:if>
                                <xsl:value-of select="current()"></xsl:value-of>
                                <xsl:if test="position() != last() and count(../antigenSCD) > 2"><xsl:text>,</xsl:text></xsl:if>
                            </xsl:for-each>.
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="count(antigenNeg/antigen) = 0"></xsl:when>
                                <xsl:otherwise>The patient's phenotype is
                                    <xsl:for-each select="antigenNeg/antigen">
                                        <xsl:if test="count(../antigen) > 1 and position() = last()"><xsl:text> and</xsl:text></xsl:if>
                                        <xsl:if test="position() > 1"><xsl:text> </xsl:text></xsl:if>
                                        <xsl:value-of select="current()"></xsl:value-of><xsl:text>-negative</xsl:text>
                                        <xsl:if test="position() != last() and count(../antigen) > 2"><xsl:text>,</xsl:text></xsl:if>   
                                    </xsl:for-each>.
                                </xsl:otherwise>
                            </xsl:choose>    
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
                <p>
                    Impression:
                </p>
                <p>
                    -- The patient is <xsl:value-of select="aboRhType/aboType"/><xsl:text>, </xsl:text><xsl:value-of select="aboRhType/rhType"/>.
                    <xsl:choose>
                        <xsl:when test="rhogam = 'yes' and count(antibodies/antibody) = 1 and (antibodies/antibody) = 'anti-D'">
                            <p>
                                -- The presence of anti-D is likely due to antenatal administration of Rh immunoglobulin.  Clinical correlation is necessary. 
                            </p>
                        </xsl:when>    
                        <xsl:when test="antibodyScreen = 'positive' and count(antibodies/antibody) = 1 and (antibodies/antibody) = 'anti-M'">
                            <p>
                                -- The patient has antibodies against the M antigen. Anti-M may be naturally occuring and is generally considered to be clinically insignificant, rarely implicated in hemolytic disease of the fetus and newborn.
                            </p>
                            <p>
                                -- Although antigen-negative (M-negative) units are not required for this patient, acquiring crossmatch compatible units may take additional time due to the presence of this antibody.    
                            </p>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="antibodyScreen = 'positive'">
                                    <p>
                                        -- The patient
                                        <xsl:choose>
                                            <xsl:when test="count(antigenNeg/antigen) &lt; 1">has</xsl:when>
                                            <xsl:otherwise>had</xsl:otherwise>
                                        </xsl:choose>
                                        developed
                                        <xsl:choose>
                                            <xsl:when test="count(antibodies/antibody) = 1 and (antibodies/antibody) = 'HTLA'">antibodies against an unspecified antigen that is likely present at a high frequency in the donor population.
                                                <p> -- HTLA (high-titer, low-avidity) antibodies are generally considered to be clinically insignificant; however, due to the presence of these antibodies, crossmatch compatible units may be difficult to obtain.
                                                </p>
                                            </xsl:when>
                                            <xsl:when test="count(antibodies/antibody) = 1 and (antibodies/antibody) = 'warm autoantibody'">a warm autoantibody. Clinical correlation to rule out immune-mediated hemolysis is recommended.</xsl:when>
                                            <xsl:otherwise>antibodies against the
                                                <xsl:choose>
                                                    <xsl:when test="count(antigenNeg/antigen) = 0 and (antibodies/antibody) = 'anti-D'">D antigen</xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:if test="count(antigenNeg/antigen) = 1 and (antibodies/antibody) = 'anti-D'">D and </xsl:if>
                                                        <xsl:if test="count(antigenNeg/antigen) > 1 and (antibodies/antibody) = 'anti-D'">D, </xsl:if>
                                                        <xsl:for-each select="antigenNeg/antigen">
                                                            <xsl:if test="count(../antigen) > 1 and position() = last()"><xsl:text>and </xsl:text></xsl:if>
                                                            <xsl:value-of select="current()"/><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>   
                                                        </xsl:for-each>
                                                        <xsl:if test="count(antigenNeg/antigen) = 1"> antigen,</xsl:if>
                                                        <xsl:if test="count(antigenNeg/antigen) > 1"> antigens,</xsl:if>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                likely as the result of previous transfusion<xsl:if test="genders/gender = 'Female'"> or pregnancy.</xsl:if><xsl:if test="genders/gender = 'Male'">.</xsl:if>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </p>
                                    <xsl:choose>
                                        <xsl:when test="count(antibodies/antibody) > 1 and antibodyScreen = 'positive' and (antibodies/antibody) = 'HTLA'">
                                            <p>
                                                -- The patient has developed HTLA (high-titer, low-avidity) antibodies, likely as the result of previous transfusion. HTLA antibodies are generally considered clinically insignificant.
                                            </p>
                                        </xsl:when>
                                    </xsl:choose>    
                                    <p>
                                        <xsl:choose>
                                            <xsl:when test="questionSCD/SCD = 'yes'">
                                                -- In this patient with a history of Sickle Cell disease, the development of these antibodies means that this patient is at increased risk of developing additional antibodies with future transfusions.
                                                <xsl:if test="genders/gender = 'Female' and age &lt; '51'">This antibody specificity has been associated with hemolytic disease of the fetus and newborn; monitoring is suggested should the patient become pregnant.</xsl:if> 
                                            </xsl:when>
                                            <xsl:otherwise>
                                                -- The development of these antibodies means that this patient is at increased risk of developing additional antibodies with future transfusions.
                                                <xsl:if test="genders/gender = 'Female' and age &lt; '51'">This antibody specificity has been associated with hemolytic disease of the fetus and newborn; monitoring is suggested should the patient become pregnant.</xsl:if>
                                            </xsl:otherwise>    
                                        </xsl:choose>    
                                    </p>
                                </xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>    
                        </xsl:otherwise>
                    </xsl:choose>    
                </p>
                <xsl:choose>
                    <xsl:when test="questionSCD/SCD = 'yes' and antibodyScreen = 'negative'">
                        <p>
                            -- The patient has Sickle Cell disease. To limit alloimmunization in a patient likely to receive many transfusions, the patient has been placed on the Sickle Cell Disease Protocol.
                        </p>
                    </xsl:when>
                    <xsl:otherwise></xsl:otherwise>
                </xsl:choose> 
                <p>
                    -- The blood bank will provide
                    <xsl:choose>
                        <xsl:when test="aboRhType/aboType = 'O'">Group O, </xsl:when>
                        <xsl:otherwise>Group ABO-compatible, </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="aboRhType/rhType = 'Rh-negative'">Rh-negative, </xsl:when>
                        <xsl:otherwise>Rh-compatible, </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="questionSCD/SCD = 'yes'">
                            <xsl:if test="antibodyScreen = 'negative'">C-negative, E-negative, K-negative (if these are negative, per Sickle Cell Disease Protocol), </xsl:if>
                            <xsl:if test="antibodyScreen = 'positive'">C-negative, E-negative, K-negative, Fy(a)-negative, Jk(b)-negative (if these are negative, per Sickle Cell Disease Protocol), </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each select="antigenNeg/antigen[@respectIfAntigenNeg = 'true']">
                                <xsl:if test="count(../antigen) > 1 and position() = last()"></xsl:if>
                                <xsl:if test="position() > 1"><xsl:text> </xsl:text></xsl:if>
                                <xsl:value-of select="current()"></xsl:value-of><xsl:text>-negative, </xsl:text>   
                            </xsl:for-each>   
                        </xsl:otherwise>    
                    </xsl:choose>crossmatch compatible
                    <xsl:choose>
                        <xsl:when test="antibodies/antibody = 'warm autoantibody'">or least incompatible </xsl:when>
                        <xsl:when test="antibodies/antibody = 'HTLA'">or least incompatible </xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>units should the patient require future transfusion.
                </p>
                <xsl:choose>
                    <xsl:when test="overallFrequency &lt; 0.02">
                        <p>
                            -- The frequency of this combination of antigen-negative units is rare (less than 2% of the population).
                            A nationwide search through the American Rare Donor Program may be necessary to find appropriate units for this patient.
                        </p>
                    </xsl:when>
                    <xsl:when test="overallFrequency &lt; 0.05">
                        <p>
                            -- The frequency of this combination of antigen-negative units is uncommon (less than 5% of the donor population).
                        </p>
                    </xsl:when>
                </xsl:choose>
                <p>
                    ICD10: R76.8
                </p>
            </body>
        </html>
        
    </xsl:template>
    
</xsl:stylesheet>