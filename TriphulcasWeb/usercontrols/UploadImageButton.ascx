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