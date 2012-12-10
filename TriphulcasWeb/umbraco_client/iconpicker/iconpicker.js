var lastChecksum = "Page_Load";
var initialSelection = null;

jQuery(document).ready(function () {
    var val = jQuery(".iconpicker").val();
    if (val !== null && val !== "") {
        $.getJSON("../webservices/IconPicker.ashx", {
                 search: val
            },
        function (search) {
            if (search.sprites.length != 0) {
                initialSelection = search.sprites[0];
            } else {
                initialSelection = { id: "folder", className: "folder", Name: "folder.gif" };
            }
            
            jQuery(".iconpicker").select2(
            {
                ajax: {
                    url: "../webservices/IconPicker.ashx",
                    dataType: 'json',
                    quietMillis: 200,
                    data: function (term) {
                        return {
                            search: term
                        };
                    },
                    results: function (data) {
                        var newChecksum = data.checksum;
                        if (lastChecksum !== newChecksum) {
                            jQuery('link[title=IconSpriteCss]').attr('href', "../webservices/IconPicker.ashx?Css=true&r=" + Math.random());
                        }
                        return { results: data.sprites };
                    }
                },
                formatResult: spriteItemFormatter,
                formatSelection: spriteSelectionFormatter,
                initSelection: function () {
                    var data = [];
                    if (initialSelection) {
                        data.push(initialSelection);
                    }
                    return data;
                }
            });

            jQuery(".iconpicker").select2("val", initialSelection);
        });
    }
});

function spriteItemFormatter(item) {
    var markup = "<span class='icon-result'>";
    if (item.className) {
        markup += "<span class='sprite umbracosprite-" + item.className + "'>&nbsp;</span>";
    }
    markup += "<span>" + item.className + "</span>";
    markup += "</span>";

    return markup;
}

function spriteSelectionFormatter(item) {
    if (!item) {
        item = initialSelection;
        jQuery('input.iconpicker').val(item.id);
    }

    return "<span style='padding-left:20px;background-repeat:no-repeat;' class='selected-sprite'><span class='icon umbracosprite-" + item.className + "'>&nbsp;</span>" + item.className + "</span>";
}