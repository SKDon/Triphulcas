//window.onload = function (event) {
//    event.stopPropagation(true);

//var frame = '<iframe id="home" src="' + window.location.href + '" style="border: 0; position:absolute; top:0; left:0; right:0; bottom:0; width:100%; height:100%" ></iframe>';
//var player = '<iframe id="player" src="/player.aspx" style="border: 0px; width: 0; height: 0;visibility:hidden;display:none"></iframe>';

//document.getElementsByTagName('head')[0].innerHTML = '<title>Ride with Triphulcas</title>';                
////document.body = document.createElement('body');
//document.getElementsByTagName('body')[0].innerHTML = frame + player;
//document.getElementsByTagName('body')[0].attributes["style"] = "margin:0";

//var headHtml = "<head>" + $("head").html() + "</head>";
//var bodyHtml = "<body>" + $("body").html() + "</body>";

//$('head').html('<title>Ride with Triphulcas</title>');
//$('body').html($frame);
//$('body').attr('style', 'margin:0');

//    setTimeout(function () {
//        var doc = $frame[0].contentWindow.document;
//        $('head', doc).html(headHtml);
//        $('body', doc).html(bodyHtml);
//        //doc.documentElement.innerHTML = wholePage;
//    }, 1);

//};

//<script type="text/javascript">
//    var isInIframe = (window.location != window.parent.location) ? true : false;

//if (!isInIframe) {
//    var frame = '<iframe id="home" src="' + window.location.href + '" style="border: 0; position:absolute; top:0; left:0; right:0; bottom:0; width:100%; height:100%" ></iframe>';
//    var player = '<iframe id="player" src="/player.aspx" style="border: 0px; width: 0; height: 0;visibility:hidden;display:none"></iframe>';

//    document.getElementsByTagName('head')[0].innerHTML = '<title>Ride with Triphulcas</title>';                
//    document.body = document.createElement('body');
//    document.getElementsByTagName('body')[0].innerHTML = frame + player;
//    document.getElementsByTagName('body')[0].attributes["style"] = "margin:0";
//}
//</script>