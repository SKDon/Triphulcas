<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImageListerSnippet.ascx.cs" Inherits="ImageListerSnippet" %>

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Repeater ID="users" ItemType="System.String" runat="server" OnItemDataBound="users_ItemDataBound">
            <ItemTemplate>
                <div class="sticker fullWidth">
                    <div class="stickerHeading galleryHeading" id="<%#Item %>">  
                        <img class="galleryProfile" src="/img/ajax-loader.gif"/>                      
                    </div>
                    <asp:Repeater ID="images" ItemType="umbraco.cms.businesslogic.media.Media" runat="server">
                        <ItemTemplate>
                            <%--<a class="imageLink" target="_blank" href="<%#Item.getProperty("umbracoFile").Value.ToString()%>">--%>
                                <img class="gallery" src="<%#Item.getProperty("umbracoFile").Value.ToString().Replace(".jpg", "_thumb.jpg") %>" title="<%#Item.Text%>" alt="<%#Container.ItemIndex%>" />
                            <%--</a>--%>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="clear"></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </ContentTemplate>
</asp:UpdatePanel>

<textarea id="fakeeditor" style="display:none"></textarea>

<script type="text/javascript">

    $(function () {

        $('.stickerHeading.galleryHeading').each(function (index) {
            var self = this;
            $.get('/Facebook/GetHeaderProfile/' + $(this).attr("id"), function (profile) {
                $(self).html('<img class="galleryProfile" src="' + profile.url + '"/><span class="galleryText"><h1>' + profile.title + '</h1></span>');
            });
        });

        $('.gallery').click(function (e) {
            //window.open($(this).attr('src').replace('_thumb.jpg','.jpg'), "_blank");

            var userId = $(this).parent().find(".stickerHeading.galleryHeading").attr("id");
            var page = $(this).attr('alt');

            var ed = new tinymce.Editor('fakeeditor', {
                inlinepopups_skin: "umbraco"
            });

            ed.windowManager = new tinymce.InlineWindowManager(ed); //new tinymce.WindowManager(ed);
            ed.selection = { getBookmark: function (param) { return param; } }

            ed.windowManager.open({
                /* UMBRACO SPECIFIC: Load Umbraco modal window */
                file: '/umbraco/plugins/ImageSlider.aspx?UserName=' + userId + '&page=' + page,
                //type: 'strange',
                width: 1015,
                height: 820,
                inline: 1
            }, {
                plugin_url: "http://localhost/umbraco_client/tinymce3/plugins/umbracoimg"
            });

            $('.mceClose').click(function () {
                //alert('Handler for .click() called.');
                //__doPostBack('UpdatePanel1', '');
            });

        });

    });
      

</script>
