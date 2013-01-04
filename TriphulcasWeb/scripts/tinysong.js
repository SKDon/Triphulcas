(function () {
    window.tinysong = {
        settings: {
            host: { search: "http://tinysong.com/s/", share: "?s=sh", shareLog: "?s=ls", shareEmail: "?s=e", requestAPIKey: "?s=apikey", clipboard: "swf/ZeroClipboard.swf", recaptcha: "?s=rc" }, clipboard: { cursor: true }, loading: { height: 12 }, messageSwitch: 500, scroll: { threshold: { top: 180, bottom: 220, nominal: $("div.header_wrapper").height() }, to: { top: 0, bottom: $("div.header_wrapper").height() }, duration: 150, moreSongsDuration: 150, easing: "linear" }, searchText: "Buscar", shareEmail: { up: 500, down: 200 },
            apiKey: { up: 500, down: 200 }, results: { up: 200, down: 1E3 }
        }, page: {
            body: $("html, body"), content: $("#content_wrapper"), header: $("#header_wrapper"), loading: $("#loadinggraphic"), message: { className: $("#message_box"), text: $("#message_text") }, song: { play: "ul.result div.play", pause: "ul.result div.pause", loading: "ul.result div.loading" }, clipboard: { body: $("#clipboard_click"), text: "span#clipboard_text", end: "span#clipboard_click_end" }, search: {
                general: $("#search_wrapper div#search_wrapper_bar"),
                form: $("#search_form"), input: $("#search_input"), button: $("#icon_button"), more: "#more_results", moreText: "#more_results span", results: "#result_wrapper", resultsButton: ".recaptchaWrapper button", recaptchaWrapper: ".recaptchaWrapper", recaptchaChallenge: "#recaptcha_challenge_field", recaptchaResponse: "#recaptcha_response_field"
            }, share: {
                link: $("#content_wrapper ul.result"), log: $("ul#sharelinks li a"),
                email: {
                    body: "div.email", link: "ul#sharelinks li.email a#email_link", textarea: "div.email div#textarea_wrapper", textareaText: "div.email div#textarea_wrapper textarea#personalMessage", input: "div.email input", button: "div.email button#submitEmail", form: "div.email form#emailForm", toAddr: "div.email input#toAddr", fromAddr: "div.email input#fromAddr", base62: "div.email input#base62", challenge: "input#recaptcha_challenge_field", response: "input#recaptcha_response_field", errors: {
                        emailError: "div.email div#email_error",
                        className: "error", recaptcha: "#recaptcha_error"
                    }
                }
            }, api: { apiKey: { body: "div.key_request", success: "div.key_success", input: "div.api_key input", form: "div.api_key form", button: "div.api_key button", email: "div.api_key input.email", terms: "div.api_key input.terms", challenge: "input#recaptcha_challenge_field", response: "input#recaptcha_response_field", errors: { emailError: "#email_error", className: "error", recaptcha: "#recaptcha_error", terms: "#terms_error", custom: "#custom_error" } } }
        }, states: {
            animation: null, animationComplete: true,
            clipboard: null, loadingDots: null, messageClass: "start", pagePosition: "top", searchText: null, searchIndexOffset: 0, state: "home", windowHash: null, checkhash: null, base62: null, isHome: true
        }, init: function () {
            ZeroClipboard.setMoviePath(this.settings.host.clipboard);
            this.changeSearchText(this.settings.searchText, true);
            this.initEvents();
            this.changePagePosition(0, null, true);
            this.loading(0);
            //window.player = new jsPlayer;
            this.checkHash()
        }, initEvents: function () {
            this.page.search.input.focus(function () {
                if ($(this).val() == window.tinysong.settings.searchText)
                    window.tinysong.changeSearchText("",
                    true);
                else
                    window.tinysong.equalSearchText($(this).val()) && $(this).select()
            });
            this.page.search.input.blur(function () {
                window.tinysong.changeSearchText(window.tinysong.getSearchText(), $(this).val() == "")
            });
            this.page.search.form.submit(function (a) {
                a.cancelBubble = true;
                //window.player.playSong(this, "26799184");
                window.tinysong.search(window.tinysong.page.search.input.val());                
                a.stopPropagation();
                return false
            });
            this.page.search.button.click(function () {
                window.tinysong.search(window.tinysong.page.search.input.val());
                return false
            });
            $(this.page.search.more).live("click",
            function () {
                window.tinysong.moreSongs(window.tinysong.getSearchText());
                return false
            });
            $(this.page.search.resultsButton).live("click", window.tinysong.searchCaptcha);
            this.page.share.link.live("click", function () {
                //window.tinysong.share($(this).attr("rel").split("-"))

                var song_id = $(this).find('.play').attr('rel') != undefined ? $(this).find('.play').attr('rel') : $(this).find('.pause').attr('rel');

                $.ajax({
                    url: '/Music/AddToQueue',
                    type: 'POST',
                    dataType: 'json',
                    data: JSON.stringify({ SongID: song_id, SongName: $(this).find('.song').text(), ArtistName: $(this).find('.artist').text() }),
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        // get the result and do some magic with it
                        //var message = data.Message;

                        //update updatepanel from client
                        __doPostBack('UpdatePanel1', '');
                    }
                });
            });
            this.page.share.link.live("mouseout", function () {
                $(this).find(".sharesong").removeClass("mouseover")
            });
            $(this.page.song.play).live("mouseover", function () {
                $(this).parent(1).find(".sharesong").removeClass("mouseover")
            });
            $(this.page.song.pause).live("mouseover",
            function () {
                $(this).parent(1).find(".sharesong").removeClass("mouseover")
            });
            $(this.page.song.loading).live("mouseover", function () {
                $(this).parent(1).find(".sharesong").removeClass("mouseover")
            });
            $(this.page.song.play).live("click", function (a) {
                a.cancelBubble = true;
                parent.frames[1].triphulcasPlayer.testSong($(this).attr("rel"));
                //window.player.toggleSong(this, $(this).attr("rel"));
                $(window.tinysong.page.song.pause).removeClass("pause").removeClass("loading").addClass("play");
                $(window.tinysong.page.song.loading).removeClass("pause").removeClass("loading").addClass("play");
                $(this).removeClass("play").removeClass("loading").addClass("pause");
                return false
            });
            $(this.page.song.pause).live("click", function (a) {
                a.cancelBubble = true;
                //window.player.toggleSong(this, $(this).attr("rel"));
                return false
            });
            $(this.page.song.loading).live("click", function (a) {
                a.cancelBubble = true;
                //window.player.toggleSong(this, $(this).attr("rel"));
                return false
            });
            this.page.body.mousemove(function (a) {
                window.tinysong.scroll(a.pageY)
            });
            $(document).keydown(function (a) {
                if (!window.tinysong.equalState("shareEmail"))
                    if (a.keyCode >=
                    48 && a.keyCode <= 57 || a.keyCode >= 65 && a.keyCode <= 90)
                        if (!$(a.target).is("input")) {
                            window.tinysong.scroll(0);
                            window.tinysong.page.search.input.focus()
                        }
            });
            this.page.share.log.live("mousedown", function (a) {
                window.tinysong.shareLog($(this).attr("rel").split("-"));
                a.stopPropagation();
                return false
            });
            $("#clipboard_click").live("mouseover", function () {
                if (window.tinysong.states.clipboard == null) {
                    window.tinysong.states.clipboard = new ZeroClipboard.Client;
                    window.tinysong.states.clipboard.setText($("#clipboard_text").html());
                    window.tinysong.states.clipboard.setHandCursor(true);
                    window.tinysong.states.clipboard.glue("clipboard_click");
                    window.tinysong.states.clipboard.addEventListener("onComplete", function () {
                        $("#clipboard_click").hide();
                        $("#clipboard_success").show();
                        window.tinysong.states.clipboard.destroy()
                    })
                }
            });
            $(this.page.share.email.link).live("click", function () {
                window.tinysong.changePagePosition($(this).offset().top + 30, function () {
                    $(window.tinysong.page.share.email.body).slideDown(window.tinysong.settings.shareEmail.down,
                    function () {
                        window.tinysong.changeState("shareEmail")
                    })
                }, true)
            });
            $(this.page.share.email.textarea).live("mouseover", function () {
                $(this).addClass("activeHover")
            });
            $(this.page.share.email.textarea).live("mouseout", function () {
                $(this).removeClass("activeHover")
            });
            $(this.page.share.email.textarea).live("focus", function () {
                $(this).addClass("activeFocus")
            });
            $(this.page.share.email.textarea).live("blur", function () {
                $(this).removeClass("activeFocus")
            });
            $(this.page.share.email.textareaText).live("focus", function () {
                $(this).val() ==
                $(this).attr("rel") && $(this).val("")
            });
            $(this.page.share.email.textareaText).live("blur", function () {
                $(this).val() == "" && $(this).val($(this).attr("rel"))
            });
            $(this.page.share.email.input).live("focus", function () {
                $(this).addClass("activeFocus").parent(0).addClass("activeFocus").parent(0).addClass("activeFocus");
                $(this).val() == $(this).attr("rel") && $(this).val("")
            });
            $(this.page.share.email.input).live("blur", function () {
                $(this).removeClass("activeFocus").parent(0).removeClass("activeFocus").parent(0).removeClass("activeFocus");
                $(this).val() == "" && $(this).val($(this).attr("rel"))
            });
            $(this.page.share.email.form).live("submit", function (a) {
                a.cancelBubble = true;
                a.stopPropagation();
                window.tinysong.shareEmail();
                return false
            });
            $(this.page.share.email.button).live("click", function (a) {
                a.cancelBubble = true;
                a.stopPropagation();
                window.tinysong.shareEmail();
                return false
            });
            $(this.page.api.apiKey.input).live("focus", function () {
                $(this).addClass("activeFocus").parent(0).addClass("activeFocus").parent(0).addClass("activeFocus");
                $(this).val() ==
                $(this).attr("rel") && $(this).val("")
            });
            $(this.page.api.apiKey.input).live("blur", function () {
                $(this).removeClass("activeFocus").parent(0).removeClass("activeFocus").parent(0).removeClass("activeFocus");
                $(this).val() == "" && $(this).val($(this).attr("rel"))
            });
            $(this.page.api.apiKey.form).live("submit", function (a) {
                a.cancelBubble = true;
                a.stopPropagation();
                window.tinysong.requestAPIKey();
                return false
            });
            $(this.page.api.apiKey.button).live("click", function (a) {
                a.cancelBubble = true;
                a.stopPropagation();
                window.tinysong.requestAPIKey();
                return false
            })
        }, scroll: function (a) {
            if (!this.isScrollable())
                return null;
            switch (this.getState()) {
                case "share":
                case "shareEmail":
                case "result":
                    this.changePagePosition(a)
            }
        }, search: function (a, b) {
            if (!(!b && this.equalState(["search", "result"]) && this.equalSearchText(a))) {
                this.clearContent();
                this.changeState("search");
                this.changeSearchText(a, true);
                this.changeBase62(null);
                //$.post(this.settings.host.search, { q: [a, 0] }, function (c) {
                $.get('/Music/Search/' + a, function (c) {
                    if (typeof c.extraParams.offset != "undefined")
                        window.tinysong.states.searchIndexOffset =
                        c.extraParams.offset;
                    window.tinysong.changePagePosition(window.tinysong.settings.scroll.to.bottom, function () {
                        window.tinysong.showContent(c, null, true);
                        window.tinysong.changeState("result");
                        window.tinysong.page.search.input.blur()
                    }, true)
                }, "json")
            }
        }, searchCaptcha: function () {
            var a = $(window.tinysong.page.search.recaptchaChallenge).val(), b = $(window.tinysong.page.search.recaptchaResponse).val();
            window.tinysong.moreSongs(window.tinysong.page.search.input.val(), [a, b])
        }, moreSongs: function (a, b) {
            this.changeState("search");
            var c = [a, window.tinysong.states.searchIndexOffset];
            if (typeof b != "undefined")
                c = c.concat(b);
            //$.post(this.settings.host.search, { q: c }, function (d) {
            $.get('/Music/Search/' + a, function (d) {
                if (d.extraParams.offset)
                    window.tinysong.states.searchIndexOffset = d.extraParams.offset;
                window.tinysong.showContent(d, function () {
                    window.tinysong.changePagePosition(window.tinysong.getPageOffset($(window.tinysong.page.search.results), true, window.tinysong.settings.scroll.moreSongsDuration), function () {
                        window.tinysong.changeState("result");
                        window.tinysong.page.search.input.blur()
                    },
                    true)
                }, true)
            }, "json")
        }, share: function (a) {
            this.clearContent();
            this.changeBase62(a[0]);
            a[2] = this.getSearchText();
            $.post(this.settings.host.share, { q: a }, function (b) {
                window.tinysong.changePagePosition(window.tinysong.settings.scroll.to.bottom, function () {
                    window.tinysong.changeState("share");
                    window.tinysong.showContent(b)
                }, true)
            }, "json")
        }, shareEmail: function () {
            toAddr = $(window.tinysong.page.share.email.toAddr);
            fromAddr = $(window.tinysong.page.share.email.fromAddr);
            message = $(window.tinysong.page.share.email.textareaText);
            base62 = $(window.tinysong.page.share.email.base62);
            challenge = $(window.tinysong.page.share.email.challenge);
            response = $(window.tinysong.page.share.email.response);
            $(window.tinysong.page.share.email.errors.emailError).hide();
            $(window.tinysong.page.share.email.errors.recaptcha).hide();
            toAddr.removeClass("emailError").parent(0).removeClass("emailError").parent(0).removeClass("emailError");
            fromAddr.removeClass("emailError").parent(0).removeClass("emailError").parent(0).removeClass("emailError");
            if (toAddr.val() ==
            toAddr.attr("rel") || !this.validEmail(toAddr.val())) {
                toAddr.addClass("emailError").parent(0).addClass("emailError").parent(0).addClass("emailError");
                $(window.tinysong.page.share.email.errors.emailError).show()
            } else if (fromAddr.val() == fromAddr.attr("rel") || !this.validEmail(fromAddr.val())) {
                fromAddr.addClass("emailError").parent(0).addClass("emailError").parent(0).addClass("emailError");
                $(window.tinysong.page.share.email.errors.emailError).show()
            } else
                $.post(window.tinysong.settings.host.recaptcha, {
                    q: [challenge.val(),
                            response.val()]
                }, function (a) {
                    if (a.valid) {
                        message.val() == message.attr("rel") && message.val("");
                        $.post(window.tinysong.settings.host.shareEmail, { q: [base62.val(), toAddr.val(), fromAddr.val(), message.val()] }, function () {
                            $(window.tinysong.page.share.email.body).slideUp(window.tinysong.settings.shareEmail.up);
                            window.tinysong.changeState("share")
                        }, "json")
                    } else
                        $(window.tinysong.page.share.email.errors.recaptcha).show()
                }, "json")
        }, requestAPIKey: function () {
            var a = window.tinysong.page.api, b = $(a.apiKey.email), c =
            $(a.apiKey.terms), d = $(a.apiKey.challenge), e = $(a.apiKey.response);
            $(a.apiKey.errors.emailError).hide();
            $(a.apiKey.errors.recaptcha).hide();
            $(a.apiKey.errors.terms).hide();
            b.removeClass("emailError").parent(0).removeClass("emailError").parent(0).removeClass("emailError");
            if (b.val() == b.attr("rel") || !this.validEmail(b.val())) {
                b.addClass("emailError").parent(0).addClass("emailError").parent(0).addClass("emailError");
                $(a.apiKey.errors.emailError).show()
            } else
                c.is(":checked") ? $.post(window.tinysong.settings.host.requestAPIKey,
                { q: [d.val(), e.val(), b.val(), c.is(":checked")] }, function (f) {
                    if (f.valid) {
                        $(a.apiKey.body).slideUp(window.tinysong.settings.apiKey.up, function () {
                            $(a.apiKey.success).show()
                        });
                        window.tinysong.changeState("apiKey")
                    } else if (typeof f.error != "undefined")
                        $(a.apiKey.errors.custom).text(f.error).show();
                    else
                        f.recaptcha || $(a.apiKey.errors.recaptcha).show()
                }, "json") : $(a.apiKey.errors.terms).show()
        }, shareLog: function (a) {
            $.post(this.settings.host.shareLog, { q: a }, function () {
            }, "plaintext")
        }, changeSearchText: function (a,
        b, c) {
            if (b != false) {
                this.page.search.input.val(a);
                if (!(a == "" || a == "Search Any Song" || this.equalSearchText(a) || c == true)) {
                    this.states.searchText = a;
                    this.states.searchIndexOffset = 0
                }
            }
        }, changeBase62: function (a) {
            this.states.base62 = a
        }, getBase62: function () {
            return this.states.base62 == null ? "" : this.states.base62
        }, equalSearchText: function (a) {
            return this.states.searchText == a
        }, getSearchText: function () {
            return this.states.searchText
        }, getHash: function () {
            return window.location.hash.split("/")
        }, equalHash: function () {
            return this.states.windowHash ==
            window.location.hash
        }, changeState: function (a) {
            this.states.state = a;
            if (a == "result" || a == "share") {
                this.states.windowHash = "#/" + a + "/" + this.page.search.input.val() + "/" + this.getBase62();
                window.location.hash = this.states.windowHash
            }
            this.states.loading != null && clearTimeout(this.states.loading);
            this.states.loading = null;
            if (a == "search")
                if (this.states.clipboard != null) {
                    this.states.clipboard.destroy();
                    this.states.clipboard = null
                }
        }, equalState: function (a) {
            if (this.states.state == null)
                return false;
            if (!$.isArray(a))
                return this.states.state ==
                a;
            var b = false;
            $.each(a, function (c) {
                if (a[c] == window.tinysong.states.state)
                    b = true
            });
            return b
        }, getState: function () {
            return this.states.state
        }, getPageOffset: function (a) {
            return a.offset().top + a.height()
        }, isScrollable: function () {
            return $(window).height() < $(document).height() - this.settings.scroll.threshold.nominal
        }, equalPagePosition: function (a) {
            return window.tinysong.states.pagePosition == a
        }, findPagePosition: function (a) {
            return a < window.tinysong.settings.scroll.threshold.bottom ? "top" : "bottom"
        }, changePagePosition: function (a,
        b, c, d) {
            var e = this.findPagePosition(a);
            if (window.tinysong.equalPagePosition(e) && c != true)
                return b == null ? null : b();
            window.tinysong.states.pagePosition = e;
            if (this.states.state != null) {
                if (!this.isScrollable())
                    return b == null ? null : b();
                if (window.tinysong.states.animationComplete == false)
                    return b == null ? null : b();
                window.tinysong.states.animation && window.tinysong.states.animation.stop()
            }
            window.tinysong.states.animationComplete = false;
            window.tinysong.states.animation = window.tinysong.page.body.animate({
                scrollTop: c ?
                    a : window.tinysong.settings.scroll.to[e]
            }, {
                complete: function () {
                    window.tinysong.states.animationComplete = true;
                    b != null && b()
                }, duration: d ? d : window.tinysong.settings.scroll.duration, easing: window.tinysong.settings.scroll.easing
            })
        }, clearContent: function (a) {
            $("#loadinggraphic").show();
            $("#message_text").html("");
            if (this.states.messageClass != "start") {
                this.page.message.className.removeClass(this.states.messageClass).addClass("start");
                this.states.messageClass = "start"
            }
            $("#content_wrapper").children().remove();
            typeof a == "function" && a()
        }, showContent: function (a, b, c) {
            if (!this.equalState(["search"])) //TODO. chapucilla temporal
                return;
            var d = $(window.tinysong.page.search.results);
            if (c) {
                if (typeof a.rateLimit == "undefined" || !a.rateLimit) {
                    $(window.tinysong.page.search.more).show();
                    $(window.tinysong.page.search.recaptchaWrapper).remove()
                } else
                    $(window.tinysong.page.search.more).hide();
                if (d.length)
                    !a.rateLimit && a.className == "error" && $(window.tinysong.page.search.moreText).html("No more songs found!");
                else
                    $(window.tinysong.page.loading).hide()
            } else
                $(window.tinysong.page.loading).hide();
            a.message && $("#message_text").html(a.message);
            if (window.tinysong.states.messageClass != a.className) {
                window.tinysong.page.message.className.switchClass(window.tinysong.states.messageClass, a.className, window.tinysong.settings.messageSwitch);
                window.tinysong.states.messageClass = a.className
            }
            if (a.html.length > 0)
                if (c && d.length) {
                    $(".last").removeClass("last");
                    a = $("<div/>").hide().append(a.html);
                    d.append(a);
                    a.slideDown(window.tinysong.settings.results.down, b)
                } else
                    $("#content_wrapper").html(a.html).slideDown(window.tinysong.settings.results.down,
                    b)
        }, validEmail: function (a) {
            return /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(a)
        }, loading: function (a) {
            setTimeout(function () {
                var b = -1 * a * window.tinysong.settings.loading.height;
                $(window.tinysong.page.loading).css({ backgroundPosition: "0 " + b + "px" });
                if (a >= 3)
                    a = -1;
                window.tinysong.loading(++a)
            }, 100)
        }, checkHash: function () {
            window.tinysong.states.checkHash && clearTimeout(window.tinysong.states.checkHash);
            window.tinysong.states.checkHash = setTimeout(function () {
                newHash = decodeURIComponent(window.location.hash);
                if (newHash != window.tinysong.states.windowHash && typeof newHash != undefined) {
                    var a = window.tinysong.getHash();
                    window.tinysong.states.state = a[1];
                    window.tinysong.states.state = window.tinysong.states.state ? decodeURIComponent(window.tinysong.states.state) : "";
                    var b = a[2] ? decodeURIComponent(a[2]) : "";
                    window.tinysong.states.state != "" && window.tinysong.changeSearchText(b, true);
                    window.tinysong.states.windowHash = decodeURIComponent(window.location.hash);
                    switch (a[1]) {
                        case "share":
                            window.tinysong.states.isHome = false;
                            window.tinysong.share([a[3], "search", b]);
                            break;
                        case "result":
                            window.tinysong.states.isHome = false;
                            window.tinysong.search(b, true);
                            break;
                        default:
                        case undefined:
                        case null:
                            if (window.tinysong.states.isHome)
                                break;
                            window.tinysong.states.isHome = true;
                            window.location.reload()
                    }
                }
                window.tinysong.checkHash()
            }, 1E3)
        }
    }
})();
