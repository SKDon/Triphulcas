$(function () { //don't wait for dom loading
    var isInIframe = (window.location != window.parent.location) ? true : false;
    //$.browser.chrome = /chrome/.test(navigator.userAgent.toLowerCase()); 
    //alert(isInIframe);

    if (!isInIframe) {

        var $frame = $('<iframe id="home" style="border: 0; position:absolute; top:0; left:0; right:0; bottom:0; width:100%; height:100%" ></iframe>');
        $frame.attr('src', window.location + '?frames=true'); //the param is for ffox (...)
        var $player = $('<iframe id="player" src="/player.aspx" style="border: 0px; width: 0; height: 0;"></iframe>');
        $('head').html('<title>Ride with Triphulcas!</title>');
        $('body').html($frame);
        $player.appendTo('body');
        $('body').attr('style', 'margin:0');

        //if ($.browser.chrome) {            
        //    $('head').html('<title>Ride with Triphulcas!</title>');
        //    $('body').html($frame);
        //    $player.appendTo('body');
        //    $('body').attr('style', 'margin:0');
        //}
        //else {            
        //    $('head').html('<title>Ride with Triphulcas!</title>');
        //    $('body').html($frame);
        //    $player.appendTo('body');
        //    $('body').attr('style', 'margin:0');
        //}
    }
});