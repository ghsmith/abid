<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html> 

<head> 
    <title>Antibody ID</title> 
    <!--link rel="shortcut icon" href="<%=request.getContextPath()%>/favicon.ico" type="image/x-icon" /-->
    <!--meta name="apple-mobile-web-app-capable" content="yes" /-->
    <!--link rel="apple-touch-icon" href="<%=request.getContextPath()%>/apple-touch-icon.png" /-->
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>
</head>

<body>
    
    <div id="welcome" data-role="page">
        <div data-role="header">
            <h1>Antibody ID</h1>
        </div>
        <div role="main" class="ui-content">
            <p>Caveat about clinically using this.</p>
            <p><a class="button-agree" href="#currentNode" data-role="button">Acknowledge &amp; continue</a></p>
        </div>
        <div>
            <p style="text-align: center; font-size: small;">Copyright &copy; 2018<br/>Melanie Wooten, MD</p>
        </div>
    </div>
	
    <div id="currentNode" data-role="page">
        <div data-role="header">
            <h1>Antibody ID</h1>
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
                <div id="genders" class="responseItem">
                    <p class="stem"></p>
                    <p class="options"></p>
                </div>
                <p>&nbsp;</p>
                <p><a class="button-reset" href="#" data-role="button">Reset all responses</a></p>
            </div>

            <div id="report" class="ui-content">

                <div id="reportBody">
                </div>
                
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
        "hospital.hospitalLoc",
        "genders.gender",
        "bbSummaries.bbSummary",
        "questionSCD.scd",
        "aboRhType.aboType.abo",
        "aboRhType.rhType.rh",
        "antibodyScreen.screen",
        "antibodies.antibody",
        "otherAllo.allo",
        "resultDAT.dat",
        "rhogam.rhogamQ",
        "resultEluate.eluate",
        "antigenNeg.antigen",
        "phenotypeSCD.antigenSCD",
        
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
            url: "/abid/resources/reference" + (reset ? "/reset" : ""),
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
            url: "/abid/resources/reference",
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
            var values = eval("reference." + responseItemElements[x]);
            $("#responseItems").append("<p id='ri" + x + "stem' class='stem'>" + responseItemElements[x] + "</p>")
            $("#responseItems").append("<p id='ri" + x + "options' class='options'></p>");
            $("#ri" + x + "options").append("<fieldset data-role='controlgroup'></fieldset>");
            for(var y = 0; y < values.length; y++) {
                $("#ri" + x + "options fieldset").append("<input type='checkbox' id='checkbox-" + y + "' data-binding='reference." + responseItemElements[x] + "[" + y + "]" + "' " + (values[y].selected ? "checked = 'true'" : "") + "/>");
                $("#ri" + x + "options fieldset").append("<label for='checkbox-" + y + "'>" + values[y].value + "</label>");            
            }
        }
        $("#currentNode .options").trigger("create");

        $("#responseItems input[type='checkbox']").change(function(e) {
            var value = eval($(this).attr("data-binding"));
            if(this.checked) {
                value.selected = true;
            }
            else {
                value.selected = false;
            }
            setReference();
        });

    }

    $("#currentNode").bind("pageinit", function () {
        
        getReference();
        
        $("#currentNode .button-reset").bind("click", getReferenceReset);
        
        $("#currentNode .report").bind("click", function() {

        });
        
    });

</script>

</html>
