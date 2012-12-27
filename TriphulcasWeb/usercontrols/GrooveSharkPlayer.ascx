<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GrooveSharkPlayer.ascx.cs" Inherits="GrooveSharkPlayer" %>

<%--
<div class="background_wrapper">
	    <div class="header_wrapper png" id="header_wrapper">
	         	  <div class="clouds_left png"></div>
      <div class="floatclouds_left png"></div>
      <div class="birds_left png"></div>
    		        <div class="header suntheme png">
	                <h1>
                        <a href="/">
                            <span>Tinysong</span>
                        </a>
                    </h1> 
                    
                    <div class="search_wrapper png" id="search_wrapper">
                        <div class="bar" id="search_wrapper_bar">
			            	<form id="search_form">
                                <input type="text" tabindex="" rel="Nombre del tema" value="Nombre del tema" name="search" id="search_input" onfocus="if(!window.tinysong&&this.value!=this.rel)this.value='';" onblur="if(!window.tinysong&&this.value=='')this.value=this.rel;">
                                <a class="icon png" id="icon_button" href="/"><span>Buscar</span></a>
                            </form> 
                        </div>
                    </div>
	            </div>
	           	    <div class="clouds_right png"></div>
        <div class="floatclouds_right png"></div>
        <div class="birds_right png"></div>
	 
	        </div>
	    </div>
	</div>
    <div class="clear"></div>
    <div id="page_wrapper">
        <div class="box start" id="message_box">
            <div class="top">
                <div class="cap right"></div>
                <div class="cap left"></div>
            </div>
            <div class="message">
                <div id="message_text">
                    		<span class="text">
	    	<span class="strong">Tinysong</span> is perfect for tweetin' songs.
	    </span>
                </div>
                <div class="loadinggraphic" id="loadinggraphic"></div> 
            </div>
            <div class="bottom">
                <div class="cap right"></div>
                <div class="cap left"></div>
            </div>
        </div>

        <div id="content_wrapper">
              
            
<!-- RHL110 / 489192 / 0 -->
    
        </div>
    </div>
    <div id="footer_wrapper">

    <div id="swfContainer"><div id="swfWrapper"></div></div> 
    <script type="text/javascript" src="scripts/jquery.js"></script>
    <script type="text/javascript" src="scripts/ui.js"></script>
        <script type="text/javascript" src="scripts/zeroclipboard.js"></script>
    <script type="text/javascript" src="scripts/player.js"></script>
    <script type="text/javascript" src="scripts/swfobject.js"></script>
    <script type="text/javascript" src="scripts/tinysong.js"></script>
    <script type="text/javascript" src="scripts/main.js"></script>--%>
<%--<script type="text/javascript" src="scripts/recaptcha.js"></script>--%>

<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/swfobject.js"></script>

<div id="swfWrapper"></div>

<script type="text/javascript">

    $(function () {
        window.triphulcasPlayer = {
            settings: {
                params : { allowScriptAccess: "always", wmode: "window" },
                vars : { hostname: "grooveshark.com", songIDs: "", style: "metal", p: "1" },
                attributes : { id: 'jsPlayerEmbed', name: 'jsPlayerEmbed' }
            },
            create: function () {
                if (swfobject.hasFlashPlayerVersion("6")) {
                    // check if SWF hasn't been removed, if this is the case, create a new alternative content container
                    var c = document.getElementById("content");
                    if (!c) {
                        var d = document.createElement("div");
                        d.setAttribute("id", "content");
                        document.getElementById("swfWrapper").appendChild(d);
                    }
                    // create SWF
                    //var att = { data: swfs[0], width: "300", height: "120" };
                    //var par = { menu: "false" };
                    //var id = "content";
                    //swfobject.createSWF(att, par, id);
                    swfobject.embedSWF("http://grooveshark.com/songWidget.swf", "content", "1", "1", "9.0.0", null, window.triphulcasPlayer.settings.vars, window.triphulcasPlayer.settings.params, window.triphulcasPlayer.settings.attributes);
                }
            },
            remove: function () {
                swfobject.removeSWF("jsPlayerEmbed");
            },
            init: function () {
                $.get('/Music/GetPlayList', function (list) {
                    window.triphulcasPlayer.settings.vars.songIDs = list.join(',');
                    //swfobject.embedSWF("http://grooveshark.com/songWidget.swf", "swfWrapper", "1", "1", "9.0.0", null, this.settings.vars, this.settings.params, this.settings.attributes);
                    window.triphulcasPlayer.reset();
                });                
            },
            testSong: function (songId) {
                $.get('/Music/GetPlayList', function (list) {
                    list.splice(0, 0, songId);
                    window.triphulcasPlayer.settings.vars.songIDs = list.join(',');
                    //swfobject.embedSWF("http://grooveshark.com/songWidget.swf", "swfWrapper", "1", "1", "9.0.0", null, this.settings.vars, this.settings.params, this.settings.attributes);
                    window.triphulcasPlayer.reset();
                });
            },
            reset: function () {
                window.triphulcasPlayer.remove();
                window.triphulcasPlayer.create();
            }
        }

        window.triphulcasPlayer.init();
    });

</script>

<%--

UNCOMMENT THIS. DESIRED BEHAVIOUR.
    
<script type="text/javascript" src="scripts/swfobject.js"></script>
<script type="text/javascript" src="scripts/jquery.js"></script>
<div id="player"></div>
<script type="text/javascript">
    swfobject.embedSWF("http://grooveshark.com/APIPlayer.swf", "player", "300", "300", "9.0.0", "", {}, { allowScriptAccess: "always" }, { id: "groovesharkPlayer", name: "groovesharkPlayer" }, function (e) {

        var element = e.ref;

        if (element) {

            setTimeout(function () {
                window.player = element;
                window.player.setVolume(99);
            }, 1500);

        } else {

            // Couldn't load player
            // Play sad trombone

        }

    });

    $(function () {
        playSong('392740');
    });

    function playSong(songId) {
        $.get('/Music/PlaySong/' + songId, function (response) {
            window.player.playStreamKey(response.StreamKey, response.StreamServerHostname, response.StreamServerID);
        });

    }
</script>--%>

<%--STEPS:- FULL LIST IN SERVER
    - CONTROLLER SERVERS FULL INTENTIONALLY UNORDERED LIST TO OBJECT IN HIDDEN FRAME
    - OBJECT STARTS PLAYING ON LOAD
    - ADDING NEW SONGS:
        - SELECTOR SEARCHES OVER TINYSONG, SHOWS SEVERAL PROPOSALS
        - PICKED ELEMENT ADDS THE LIST IN FIRST PLACE, AND STARTS REPRODUCING
            - TAKING ADVANTAGE OF THIS, THE OBJECT RELOADS WITH THE NEW FULL LIST (CONTROLLER HAD STORED THE PREVIOUS IN SESSION)--%>

<%--<object width="250" height="40" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="gsSong881558519" name="gsSong881558519">
    <param name="movie" value="http://grooveshark.com/songWidget.swf" />
    <param name="wmode" value="window" />
    <param name="allowScriptAccess" value="always" />
    <param name="flashvars" value="hostname=grooveshark.com&songIDs=23701045,27225308,33457332&style=metal&p=0" />
    <object type="application/x-shockwave-flash" data="http://grooveshark.com/songWidget.swf" width="250" height="40">
        <param name="wmode" value="window" /><param name="allowScriptAccess" value="always" />
        <param name="flashvars" value="hostname=grooveshark.com&songIDs=23701045,27225308,33457332&style=metal&p=0" />
        <span><a href="http://grooveshark.com/search/song?q=Beethoven%20Moonlight%20Sonata" title="Moonlight Sonata by Beethoven on Grooveshark">Moonlight Sonata by Beethoven on Grooveshark</a></span>
    </object>
</object>--%>

<%--<script type="text/javascript">

    //$.ajax({
    //    url: "https://grooveshark.com/more.php?authenticateUser",
    //    type: "POST",
    //    dataType: "json",
    //    contentType: "json",
    //    data: JSON.stringify({ "method": "authenticateUser", "header": { "uuid": "3047F391-2456-4E67-9D2F-2519A722BBA6", "country": { "CC3": 0, "CC2": 1, "CC4": 0, "CC1": 0, "ID": 65, "DMA": 0, "IPR": 0 }, "privacy": 0, "token": "c943d3ec4c0768e55cb0739599516bfbb29fa728eafbbe", "session": "9a16adf98957cdec3b86a6db38d10410", "client": "htmlshark", "clientRevision": "20120830" }, "parameters": { "username": "srcoton@gmail.com", "password": "zentzent" } }),
    //    success: function () {
    //        alert("success :-)");
    //    },
    //    error: function () {
    //        alert("fail :-(");
    //    }
    //});



</script>--%>