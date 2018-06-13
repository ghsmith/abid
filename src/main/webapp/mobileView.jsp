<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html> 

<head> 
    <title>Antibody ID [alpha 20180612]</title> 
    <!--link rel="shortcut icon" href="<%=request.getContextPath()%>/favicon.ico" type="image/x-icon" /-->
    <!--meta name="apple-mobile-web-app-capable" content="yes" /-->
    <!--link rel="apple-touch-icon" href="<%=request.getContextPath()%>/apple-touch-icon.png" /-->
    <meta name="viewport" content="width=device-width, initial-scale=1"/> 
    <link rel="stylesheet" href="//code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"/>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="//code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>

<body>
    
    <div id="welcome" data-role="page">
        <div data-role="header">
            <h1>Antibody ID [alpha 20180612]</h1>
        </div>
        <div role="main" class="ui-content">
            <p>Caveat about clinically using this. Background information.
            Friends, Romans, Countrymen! Lend me your ears. We have come to bury Caesar, not to praise him.</p>
            <p><a class="button-agree" href="#currentNode" data-role="button">Acknowledge &amp; continue</a></p>
        </div>
        <div>
            <p style="text-align: center; font-size: small;">Copyright &copy; 2018<br/>Melanie Wooten, MD</p>
        </div>
    </div>
	
    <div id="currentNode" data-role="page">
        <div data-role="header">
            <h1>Antibody ID [alpha 20180612]</h1>
        </div>
        <div data-role="tabs" style="padding: 0px">

            <div data-role="navbar" class="tabBar">
                <ul>
                    <li><a href="#workup" class="workup ui-btn-active ui-state-persist">Workup</a></li>
                    <li><a href="#report" class="report">Report</a></li>
                </ul>
            </div>

            <div id="workup" class="ui-content">
                <p>Click on <i>Report</i> after you have completed all applicable workup.</p>
                <div id="responseItems">
                </div>
                <p>&nbsp;</p>
                <p><a class="button-reset" href="#" data-role="button">Reset all responses</a></p>
            </div>

            <div id="report" class="ui-content">
                <div id="reportBody" style="border: 1px solid black; padding: 5px; background-color: white;">
                </div>
                <a href="<%=request.getContextPath()%>/sampleXMLServlet" target="_blank">[XML version of this report]</a>
            </div>
            
        </div>
        <div>
            <p style="text-align: center;"><a href="#welcome">Welcome</a></p>
            <p style="text-align: center; font-size: small;">Copyright &copy; 2018<br/>Melanie Wooten, MD</p>
        </div>
    </div>
            
</body>

<script type="text/javascript">

    var responseItemElements = [
        {name:"residentName", type:"text"},
        {name:"mrn", type:"text"},
        {name:"lastName", type:"text"},
        {name:"firstName", type:"text"},
        {name:"age", type:"text"},
        {name:"collectionDate", type:"date"},
        {name:"hospital.hospitalLoc", type:"radio"},
        {name:"genders.gender", type:"radio"},
        {name:"bbSummaries.bbSummary", type:"radio"},
        {name:"questionSCD.scd", type:"radio"},
        {name:"aboRhType.aboType.abo", type:"radio"},
        {name:"aboRhType.rhType.rh", type:"radio"},
        {name:"antibodyScreen.screen", type:"radio"},
        {name:"antibodies.antibody", type:"checkbox"},
        {name:"otherAllo.allo", type:"radio"},
        {name:"resultDAT.dat", type:"radio"},
        {name:"rhogam.rhogamQ", type:"radio"},
        {name:"resultEluate.eluate", type:"radio"},
        {name:"antigenNeg.antigen", type:"checkbox"},
        {name:"phenotypeSCD.antigenSCD", type:"checkbox"}
        
    ];

    var reference;

    function getReference() { getReference(false); }
    function getReferenceReset() { getReference(true); }

    function getReference(reset) {
        
        return $.ajax({
            type: "GET",
            cache: false,
            dataType: "json",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/resources/reference" + (reset ? "/reset" : ""),
            success: function(data) {
                reference = data;
                renderResponseItems();
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

    function renderResponseItems() {
        
        $("#responseItems").html("");
        for(var x = 0; x < responseItemElements.length; x++) {
            if(responseItemElements[x].type == "radio" || responseItemElements[x].type == "checkbox") {
                var values = eval("reference." + responseItemElements[x].name);
                $("#responseItems").append("<p id='ri" + x + "stem' class='stem'>" + responseItemElements[x].name + "</p>")
                $("#responseItems").append("<p id='ri" + x + "options' class='options'></p>");
                $("#ri" + x + "options").append("<fieldset data-role='controlgroup'></fieldset>");
                for(var y = 0; y < values.length; y++) {
                    $("#ri" + x + "options fieldset").append("<input type='" + responseItemElements[x].type + "' name='ri" + x + "' id='ri" + x + "-" + y + "' data-binding='reference." + responseItemElements[x].name + "[" + y + "]" + "' " + (values[y].selected ? "checked = 'true'" : "") + "/>");
                    $("#ri" + x + "options fieldset").append("<label for='ri" + x + "-" + y + "'>" + values[y].value + "</label>");            
                }
            }
            else if(responseItemElements[x].type == "text") {
                var value = eval("reference." + responseItemElements[x].name);
                $("#responseItems").append("<p id='ri" + x + "stem' class='stem'>" + responseItemElements[x].name + "</p>")
                $("#responseItems").append("<p id='ri" + x + "options' class='options'></p>");
                $("#ri" + x + "options").append("<input type='text' data-clear-btn='true' id='ri" + x +  "' data-binding='reference." + responseItemElements[x].name + "' value='" + (value != null ? value : "") + "'>");
            }    
            else if(responseItemElements[x].type == "date") {
                var value = eval("reference." + responseItemElements[x].name);
                $("#responseItems").append("<p id='ri" + x + "stem' class='stem'>" + responseItemElements[x].name + "</p>")
                $("#responseItems").append("<p id='ri" + x + "options' class='options'></p>");
                $("#ri" + x + "options").append("<input type='date' data-clear-btn='true' id='ri" + x +  "' data-binding='reference." + responseItemElements[x].name + "' value='" + (value != null ? value : "") + "'>");
            }    
        }
        
        $("#responseItems .options").trigger("create");

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

        $("#responseItems input[type='text'], #responseItems input[type='date']").change(function(e) {
            eval($(this).attr("data-binding") + " = '" + $(this).val() + "'");
            setReference();
        });

    }

    $("#currentNode").bind("pageinit", function () {

        getReference();
        
        $("#currentNode .button-reset").bind("click", getReferenceReset);
        
        $("#currentNode .report").bind("click", function() {
            $("#reportBody").load("<%=request.getContextPath()%>/sampleXLSTServlet", function() {
                $("#reportBody").trigger("create");
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
