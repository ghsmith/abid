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
            <h1>Antibody ID [alpha 20190813]</h1>
        </div>
        <div role="main" class="ui-content">
            <p>Caveat about clinically using this. Background information.
            Friends, Romans, Countrymen! Lend me your ears. We have come to bury Caesar, not to praise him.</p>
            <p><a class="button-agree" href="#currentNode" data-role="button">Acknowledge &amp; continue</a></p>
        </div>
        <div>
            <p style="text-align: center; font-size: small;">Copyright &copy; 2019<br/>Melanie Wooten, MD</p>
        </div>
    </div>
	
    <div id="currentNode" data-role="page">
        <div data-role="header">
            <h1>Antibody ID [alpha 20190813]</h1>
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
                <p>Click on <i>Report</i> after you have completed all applicable workup.</p>
                <div id="responseItems">
                </div>
                <fieldset class="ui-grid-a">
                    <div class="ui-block-a"><button class="button-prev" data-icon="arrow-l">Prev</button></div>
                    <div class="ui-block-b"><button class="button-next" data-icon="arrow-r" data-iconpos="right">Next</button></div>
                </fieldset>
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
            <p style="text-align: center; font-size: small;">Copyright &copy; 2019<br/>Melanie Wooten, MD</p>
        </div>
    </div>
            
</body>

<script type="text/javascript">

    var reference;
    var responseItems;
    var currentSection;

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

        $("#currentNode .button-prev").closest('.ui-btn').addClass('ui-disabled');
        $("#currentNode .button-next").closest('.ui-btn').addClass('ui-disabled');
        if(currentSection != "Demographics") { $("#currentNode .button-prev").closest('.ui-btn').removeClass('ui-disabled'); }
        if(currentSection != "Antibody ID") { $("#currentNode .button-next").closest('.ui-btn').removeClass('ui-disabled'); }
        if($(":focus") != null) { $(":focus").blur(); }
        $.mobile.silentScroll(0);
        
        getResponseItems().then(function() {
            
            $("#currentSection").html(currentSection);
            
            $("#responseItems").html("");
            for(var x = 0; x < responseItemElements.length; x++) {
                $("<p class='stem'>" + responseItemElements[x].stem + "</p>").appendTo("#responseItems");
                var $options = $("<p class='options'></p>").appendTo("#responseItems");
                if(responseItemElements[x].type == "radio" || responseItemElements[x].type == "checkbox") {
                    var values = eval("reference." + responseItemElements[x].name);
                    var $fieldset = $("<fieldset data-role='controlgroup'></fieldset>").appendTo($options);
                    for(var y = 0; y < values.length; y++) {
                        $("<input type='" + responseItemElements[x].type + "' name='ri" + x + "' id='ri" + x + "-" + y + "' data-binding='reference." + responseItemElements[x].name + "[" + y + "]" + "' " + (values[y].selected ? "checked = 'true'" : "") + "/>").appendTo($fieldset);
                        $("<label for='ri" + x + "-" + y + "'>" + values[y].value + "</label>").appendTo($fieldset);
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

            $("#responseItems input[type='text'], #responseItems input[type='number'], #responseItems input[type='date']").change(function(e) {
                eval($(this).attr("data-binding") + " = '" + $(this).val() + "'");
                setReference();
            });

        });
        
    }

    $("#currentNode").bind("pageinit", function() {

        getReference().then(getCurrSection).then(renderResponseItems);

        $("#currentNode .button-next").bind("click", function() { getNextSection().then(renderResponseItems); });
        $("#currentNode .button-prev").bind("click", function() { getPrevSection().then(renderResponseItems); });
        $("#currentNode .button-reset").bind("click", function() { getReferenceReset().then(getCurrSection).then(renderResponseItems); });
        
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
