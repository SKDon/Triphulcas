<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GrooveSharkPlayer.ascx.cs" Inherits="GrooveSharkPlayer" %>


<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/swfobject.js"></script>
<script type="text/javascript" src="scripts/triphulcasPlayer.js"></script>
<script type="text/javascript" src="scripts/closingWatcher.js"></script>

<div id="swfWrapper"></div>
<input type="hidden" id="antyForgeryToken" value="<%=Guid.NewGuid().ToString() %>"


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