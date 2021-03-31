<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html> 

<head> 
    <title>Antibody ID [beta 20190819]</title> 
    <!--link rel="shortcut icon" href="<%=request.getContextPath()%>/favicon.ico" type="image/x-icon" /-->
    <!--meta name="apple-mobile-web-app-capable" content="yes" /-->
    <!--link rel="apple-touch-icon" href="<%=request.getContextPath()%>/apple-touch-icon.png" /-->
    <meta name="viewport" content="width=device-width, initial-scale=1"/> 
    <link rel="stylesheet" href="https://code.jquery.com/mobile/1.5.0-rc1/jquery.mobile-1.5.0-rc1.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/mobile/1.5.0-rc1/jquery.mobile-1.5.0-rc1.min.js" integrity="sha256-c3VbCrdCtTHmXYAuxRT4D0Cy5VC/0zBnXVRIvJiV9xo=" crossorigin="anonymous"></script>
</head>

<body>
    
    <div id="welcome" data-role="page">
        <div data-role="header">
            <h3 style="text-align: center;">Antibody ID [beta 20190819]</h3>
        </div>
        <div role="main" class="ui-content">
            <p>Antibody identification reports are important documents in the
                medical record which provide accurate and clear communication of
                a patient's transfusion requirements to the clinical team. This
                user-friendly application is based on a proprietary algorithm
                which uses a series of simple questions to accurately summarize
                serologic testing and transfusion recommendations for many of
                the most common situations (including administration of a RhIg
                product, possibility of HDFN, and antigen-negative
                recommendations for patients with Sickle Cell disease).
                This application is only a tool and contains a comprehensive,
                but not exhaustive, list of common antigens/antibodies.
                Medical decisions based on the output of this tool should only
                be made by qualified and licensed medical providers.</p>
            <p><a class="button-agree" href="#currentNode" data-role="button">Acknowledge &amp; continue</a></p>
        </div>
        <div>
            <p style="text-align: center; font-size: small;">Copyright &copy; 2019<br/>Melanie Wooten, MD</p>
        </div>
    </div>
	
    <div id="currentNode" data-role="page">
        <div data-role="header">
            <h3 style="text-align: center;">Antibody ID [beta 20190819]</h3>
        </div>
        <div data-role="tabs" style="padding: 0px">

            <div data-role="navbar" class="tabBar">
                <ul>
                    <li><a href="#workup" class="workup ui-btn-active ui-state-persist">Workup</a></li>
                    <li><a href="#report" class="report">Report</a></li>
                </ul>
            </div>

            <div id="workup" class="ui-content">
                <div style="text-align: center; font-weight: bold;" id="currentSection"></div>
                <div style="text-align: center;" id="currentSection">Click on <i>Report</i> after you have completed all applicable workup.</div>
                <div id="responseItems">
                </div>
                <fieldset class="ui-grid-a">
                    <div class="ui-block-a"><button class="button-prev" data-icon="ui-icon-arrow-l">Prev</button></div>
                    <div class="ui-block-b"><button class="button-next" data-icon="ui-icon-arrow-r" data-iconpos="right">Next</button></div>
                </fieldset>
                <p>&nbsp;</p>
                <p><a class="button-reset" href="#" data-role="button">Reset all responses</a></p>
            </div>

            <div id="report" class="ui-content">
                <div id="reportBody" style="border: 1px solid black; padding: 5px; background-color: white;">
                </div>
                <div style="text-align: center;"><a href="<%=request.getContextPath()%>/sampleXMLServlet" target="_blank">[XML version of this report]</a></div>
            </div>
            
        </div>
        <div>
            <p style="text-align: center;"><a href="#welcome">Welcome</a></p>
            <p style="text-align: center; font-size: small;">Copyright &copy; 2019<br/>Melanie Wooten, MD</p>
        </div>
    </div>
            
</body>

<script type="text/javascript">

    var reference;
    var responseItems;
    var currentSection;

    function getReference() { return getReference(false); }
    function getReferenceReset() { return getReference(true); }

    function getReference(reset) {
        
        return $.ajax({
            type: "GET",
            cache: false,
            dataType: "json",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/resources/reference" + (reset ? "/reset" : ""),
            success: function(data) {
                reference = data;
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(textStatus + "/" + errorThrown);
            }
        });
        
    }

    function setReference() {
        return $.ajax({
            type: "PUT",
            cache: false,
            dataType: "json",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/resources/reference",
            data: JSON.stringify(reference),
            success: function() {
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(textStatus + "/" + errorThrown);
            }
        });
    }

    function getResponseItems() {
        
        return $.ajax({
            type: "GET",
            cache: false,
            dataType: "json",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/resources/reference/responseItems",
            success: function(data) {
                responseItemElements = data;
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(textStatus + "/" + errorThrown);
            }
        });
        
    }

    function getCurrSection() {
        
        return $.ajax({
            type: "GET",
            cache: false,
            dataType: "text",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/resources/reference/currSection",
            success: function(data) {
                currentSection = data;
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(textStatus + "/" + errorThrown);
            }
        });

    }

    function getNextSection() {
        
        return $.ajax({
            type: "GET",
            cache: false,
            dataType: "text",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/resources/reference/nextSection",
            success: function(data) {
                currentSection = data;
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(textStatus + "/" + errorThrown);
            }
        });

    }

    function getPrevSection() {
        
        return $.ajax({
            type: "GET",
            cache: false,
            dataType: "text",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/resources/reference/prevSection",
            success: function(data) {
                currentSection = data;
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(textStatus + "/" + errorThrown);
            }
        });

    }

    function renderResponseItems() {
        renderResponseItemsNoScroll(false);
    }

    function renderResponseItemsNoScroll(noScroll) {

        $("#currentNode .button-prev").button('disable');
        $("#currentNode .button-next").button('disable');
        if(!currentSection.match(/Section 1.*/)) { $("#currentNode .button-prev").button('enable'); }
        if(!currentSection.match(/Section 3.*/)) { $("#currentNode .button-next").button('enable'); }
        if($(":focus") != null) { $(":focus").blur(); }
        if(!noScroll) {
            //$.mobile.silentScroll(0);
            window.scrollTo(0, 1);
        }
        
        getResponseItems().then(function() {
            
            $("#currentSection").html(currentSection);
            
            $("#responseItems").html("");
            for(var x = 0; x < responseItemElements.length; x++) {
                if(!reference.questionSCD.scd[0].selected && (responseItemElements[x].name == "phenotypeSCD.antigenSCD")) { continue; }
                //if(reference.questionSCD.scd[0].selected && (responseItemElements[x].name == "antigenNeg.antigen")) { continue; }
                if(!reference.resultEluate.eluate[3].selected && (responseItemElements[x].name == "resultEluateAntibodies.freeValue")) { continue; }
                // major hack for side-by-side display of antibodies and antigen negative requirements
                // assumes that antibodies.antibody and antigenNeg.antigen appear in that sequence
                var $base = (responseItemElements[x].name == "antibodies.antibody" || responseItemElements[x].name == "antigenNeg.antigen") ? $("<div style='display: inline-block; width: 50%;'></div>").appendTo("#responseItems") : $("#responseItems");
                $("<p class='stem'>" + responseItemElements[x].stem + "</p>").appendTo($base);
                var $options = $("<p class='options'></p>").appendTo($base);
                if(responseItemElements[x].type == "radio" || responseItemElements[x].type == "checkbox") {
                    var values = eval("reference." + responseItemElements[x].name);
                    var $fieldset = $("<fieldset data-role='controlgroup'></fieldset>").appendTo($options);
                    // major hack for side-by-side display of antibodies and antigen negative requirements
                    // assumes that there are always more antibodies.antibody than antigenNeg.antigen
                    if(responseItemElements[x].name == "antigenNeg.antigen") {
                        for(var z = reference.antigenNeg.antigen.length; z < reference.antibodies.antibody.length; z++) {
                            $("<input type='checkbox' name='bogus" + z + "' id='bogus" + z + "' disabled='true'/><label for='bogus" + z + "'>n/a</label>").appendTo($fieldset);
                        }
                    }
                    for(var y = 0; y < values.length; y++) {
                        $("<input type='" + responseItemElements[x].type + "' name='ri" + x + "' id='ri" + x + "-" + y + "' data-binding='reference." + responseItemElements[x].name + "[" + y + "]" + "' " + (values[y].selected ? "checked = 'true'" : "") + "/>").appendTo($fieldset);
                        // major hack for side-by-side display of antibodies and antigen negative requirements
                        // shrinking "warm autoantibody" to "warm auto" so things don't wrap
                        $("<label for='ri" + x + "-" + y + "'>" + values[y].value.replace("autoantibody", "auto") + "</label>").appendTo($fieldset);
                    }
                }
                else if(responseItemElements[x].type == "text") {
                    var value = eval("reference." + responseItemElements[x].name);
                    $("<input type='text' data-clear-btn='true' id='ri" + x +  "' data-binding='reference." + responseItemElements[x].name + "' value='" + (value != null ? value : "") + "'>").appendTo($options);
                }    
                else if(responseItemElements[x].type == "number") {
                    var value = eval("reference." + responseItemElements[x].name);
                    $("<input type='number' data-clear-btn='true' id='ri" + x +  "' data-binding='reference." + responseItemElements[x].name + "' value='" + (value != null ? value : "") + "'>").appendTo($options);
                }    
                else if(responseItemElements[x].type == "date") {
                    var value = eval("reference." + responseItemElements[x].name);
                    $("<input type='date' data-clear-btn='true' id='ri" + x +  "' data-binding='reference." + responseItemElements[x].name + "' value='" + (value != null ? value : "") + "'>").appendTo($options);
                }    
            }
        
            $("#responseItems .options").enhanceWithin();

            $("#responseItems input[type='radio']").change(function(e) {
                $(this).parents("fieldset").find("input").each(function() {
                    eval($(this).attr("data-binding") + ".selected = false");
                });
                eval($(this).attr("data-binding") + ".selected = " + this.checked);
                setReference();
            });

            $("#responseItems input[type='checkbox']").change(function(e) {
                eval($(this).attr("data-binding") + ".selected = " + this.checked);
                setReference();
            });

            $("#responseItems input[type='text'], #responseItems input[type='number'], #responseItems input[type='date']").change(function(e) {
                eval($(this).attr("data-binding") + " = '" + $(this).val() + "'");
                setReference();
            });

            $("#responseItems input[data-binding^='reference.resultEluate']").change(function(e) {
                renderResponseItemsNoScroll(true);
            });

        });
        
    }

    $("#currentNode").bind("pagecreate", function() {

        getReference().then(getCurrSection).then(renderResponseItems);

        $("#currentNode .button-next").bind("click", function() { getNextSection().then(renderResponseItems); });
        $("#currentNode .button-prev").bind("click", function() { getPrevSection().then(renderResponseItems); });
        $("#currentNode .button-reset").bind("click", function() { getReferenceReset().then(getCurrSection).then(renderResponseItems); });
        
        $("#currentNode .report").bind("click", function() {
            $("#reportBody").load("<%=request.getContextPath()%>/sampleXLSTServlet", function() {
                $("#reportBody").enhanceWithin();
            });
        });

        // there must be a better way to persist tab state...
        $("#currentNode .tabBar a").bind("click", function() {
            $("#currentNode .tabBar a").removeClass("ui-state-persist");
            $(this).addClass("ui-state-persist");
        });

    });

</script>

</html>
