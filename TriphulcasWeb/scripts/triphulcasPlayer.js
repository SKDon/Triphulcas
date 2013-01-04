$(function () {
    window.triphulcasPlayer = {
        settings: {
            params: { allowScriptAccess: "always", wmode: "window" },
            vars: { hostname: "grooveshark.com", songIDs: "", style: "metal", p: "1" },
            attributes: { id: 'jsPlayerEmbed', name: 'jsPlayerEmbed' }
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
        tryStop: function () {
            $.ajax({
                url: "/Music/StopPlaying",
                type: "POST",
                dataType: "json",                
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ token: $('#antyForgeryToken').attr('value') }),
                success: function (response) {
                }
            });
        },
        tryInit: function () {
            $.ajax({
                url: "/Music/StartPlaying",
                type: "POST",
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ token: $('#antyForgeryToken').attr('value') }),
                success: function (response) {
                    if (response.message == "cool")
                        window.triphulcasPlayer.init();
                }
            });
        },
        init: function () {
            $.get('/Music/GetPlayList/' + $('#antyForgeryToken').attr('value'), function (list) {
                window.triphulcasPlayer.settings.vars.songIDs = list.join(',');
                //swfobject.embedSWF("http://grooveshark.com/songWidget.swf", "swfWrapper", "1", "1", "9.0.0", null, this.settings.vars, this.settings.params, this.settings.attributes);
                window.triphulcasPlayer.reset();
            });
        },
        testSong: function (songId) {
            $.get('/Music/GetPlayList/' + $('#antyForgeryToken').attr('value'), function (list) {
                var pos = $.inArray(songId, list);
                if (pos != -1)
                    list = $.grep(list, function (value) {
                        return value != songId;
                    });
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