<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UploadImageButton.ascx.cs" Inherits="usercontrols_UploadImageButton" %>


 <div id="slogan">
            <p class="engraved"><%=String.Format(Resources.Resource1.UploadImagesDescription,User.FirstName) %></p>
            <a class="download-button" href="#">
                <p><%=Resources.Resource1.UploadImagesLiteral %></p>
                <%--<p class="smallprint">v2.2.0 - 14kb min+gz</p>--%>
            </a>
        </div>

<textarea id="fakeeditor" style="display:none"></textarea>


<script type="text/javascript">

    //tinyMCE.init({
    //    mode: 'exact',
    //    theme: 'umbraco',
    //    umbraco_path: '/umbraco',
    //    width: '900',
    //    height: '1000',
    //    theme_umbraco_toolbar_location: 'external',
    //    skin: 'umbraco',
    //    inlinepopups_skin: 'umbraco',
    //    plugins: 'contextmenu,umbracomacro,umbracoembed,noneditable,inlinepopups,table,advlink,spellchecker,paste,umbracoimg,umbracocss,umbracopaste,umbracolink,umbracocontextmenu',
    //    umbraco_advancedMode: true,
    //    umbraco_maximumDefaultImageWidth: '500',
    //    content_css: '/css/tripoli.simple.ie.css',
    //    theme_umbraco_styles: '',
    //    theme_umbraco_buttons1: 'code,separator,undo,redo,cut,copy,pasteword,separator,umbracocss,bold,italic,separator,bullist,numlist,outdent,indent,separator,link,unlink,anchor,separator,image,umbracomacro,table,umbracoembed,separator,charmap,',
    //    theme_umbraco_buttons2: '',
    //    theme_umbraco_buttons3: '',
    //    theme_umbraco_toolbar_align: 'left',
    //    theme_umbraco_disable: 'help,visualaid,justifyleft,strikethrough,removeformat,mcespellcheck,justifycenter,subscript,justifyfull,underline,justifyright,inserthorizontalrule,superscript',
    //    theme_umbraco_path: true,
    //    extended_valid_elements: 'div[*]',
    //    document_base_url: '/',
    //    relative_urls: false,
    //    remove_script_host: true,
    //    event_elements: 'div',
    //    paste_auto_cleanup_on_paste: true,
    //    valid_elements: '+a[id|style|rel|rev|charset|hreflang|dir|lang|tabindex|accesskey|type|name|href|target|title|class|onfocus|onblur|onclick|' +
    //    'ondblclick|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onkeypress|onkeydown|onkeyup],-strong/-b[class|style],-em/-i[class|style],' +
    //    '-strike[class|style],-u[class|style],#p[id|style|dir|class|align],-ol[class|reversed|start|style|type],-ul[class|style],-li[class|style],br[class],' +
    //    'img[id|dir|lang|longdesc|usemap|style|class|src|onmouseover|onmouseout|border|alt=|title|hspace|vspace|width|height|align|umbracoorgwidth|umbracoorgheight|onresize|onresizestart|onresizeend|rel],' +
    //    '-sub[style|class],-sup[style|class],-blockquote[dir|style|class],-table[border=0|cellspacing|cellpadding|width|height|class|align|summary|style|dir|id|lang|bgcolor|background|bordercolor],' +
    //    '-tr[id|lang|dir|class|rowspan|width|height|align|valign|style|bgcolor|background|bordercolor],tbody[id|class],' +
    //    'thead[id|class],tfoot[id|class],#td[id|lang|dir|class|colspan|rowspan|width|height|align|valign|style|bgcolor|background|bordercolor|scope],' +
    //    '-th[id|lang|dir|class|colspan|rowspan|width|height|align|valign|style|scope],caption[id|lang|dir|class|style],-div[id|dir|class|align|style],' +
    //    '-span[class|align|style],-pre[class|align|style],address[class|align|style],-h1[id|dir|class|align],-h2[id|dir|class|align],' +
    //    '-h3[id|dir|class|align],-h4[id|dir|class|align],-h5[id|dir|class|align],-h6[id|style|dir|class|align],hr[class|style],' +
    //    'dd[id|class|title|style|dir|lang],dl[id|class|title|style|dir|lang],dt[id|class|title|style|dir|lang],object[class|id|width|height|codebase|*],' +
    //    'param[name|value|_value|class],embed[type|width|height|src|class|*],map[name|class],area[shape|coords|href|alt|target|class],bdo[class],button[class],iframe[*]',
    //    invalid_elements: 'font',
    //    spellchecker_rpc_url: 'GoogleSpellChecker.ashx',
    //    entity_encoding: 'raw',
    //    theme_umbraco_pageId: '1155',
    //    theme_umbraco_versionId: 'd4c16662-1199-4472-9a89-357d1b8b7cea',
    //    umbraco_toolbar_id: 'LiveEditingClientToolbar'
    //});
    ////(function () {
    ////    var f =
    ////    function () {
    ////        if (document.getElementById('__umbraco_tinyMCE'))
    ////            tinyMCE.execCommand('mceAddControl', false, 'ContentPlaceHolderDefault_Main_EditorControlWrapper_DataEditor');
    ////        ItemEditing.remove_startEdit(f);
    ////    }
    ////    ItemEditing.add_startEdit(f);
    ////})(); (function () {
    ////    var f =
    ////    function () {
    ////        tinyMCE.execCommand('mceRemoveControl', false, 'ContentPlaceHolderDefault_Main_EditorControlWrapper_DataEditor');
    ////        ItemEditing.remove_stopEdit(f);
    ////    }
    ////    ItemEditing.add_stopEdit(f);
    ////})();

</script>
<%--<script type="text/javascript">

    ItemEditing.startEdit(3);

</script>
<script type="text/javascript">

    CDLazyLoader.AddJs('/umbraco_client/Application/NamespaceManager.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco_client/ui/jquery.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco_client/Application/JQuery/jquery.noconflict-invoke.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco/js/UmbracoSpeechBubble.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco/js/UmbracoSpeechBubbleInit.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco_client/Application/UmbracoUtils.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco/LiveEditing/Controls/LiveEditingToolbar.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco_client/Application/UmbracoClientManager.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco/LiveEditing/Modules/ItemEditing/ItemEditing.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco/LiveEditing/Modules/ItemEditing/ItemEditingInvoke.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco_client/tinymce3/tiny_mce_src.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco/LiveEditing/Controls/Communicator.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco/LiveEditing/Modules/UnpublishModule/UnpublishModule.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco_client/modal/modal.js?cdv=1', ''); CDLazyLoader.AddJs('/umbraco/LiveEditing/Modules/DeleteModule/DeleteModule.js?cdv=1', '');

</script>
<script type="text/javascript">

    CDLazyLoader.AddCss('/umbraco/LiveEditing/CSS/LiveEditing.css?cdv=1'); CDLazyLoader.AddCss('/umbraco_client/modal/style.css?cdv=1');

</script>--%>





<script type="text/javascript">
   

    function OpenUploadImagePopup() {

        var ed = new tinymce.Editor('fakeeditor', {
            inlinepopups_skin: "umbraco"
        });

        ed.windowManager = new tinymce.InlineWindowManager(ed); //new tinymce.WindowManager(ed);
        ed.selection = { getBookmark: function (param) { return param; } }  

        ed.windowManager.open({
            /* UMBRACO SPECIFIC: Load Umbraco modal window */
            file: '/umbraco/plugins/tinymce3/insertImage.aspx?ShowItFuckEr=please',
            //type: 'strange',
            width: 575,
            height: 505,
            inline: 1
        }, {
            plugin_url: "http://localhost/umbraco_client/tinymce3/plugins/umbracoimg"
        });
        
        $('.mceClose').click(function () {
            //alert('Handler for .click() called.');
            __doPostBack('UpdatePanel1', '');
        });

    }

    $('.download-button').bind("click",OpenUploadImagePopup);

    </script>

<%--<script type="text/javascript">

    $('.download-button').click(function () {
        $.get('/Facebook/GetArticleLinkById/<%=umbraco.NodeFactory.Node.getCurrentNodeId()%>', function (target) {
            window.location = target.url;
        });
    });

</script>--%>