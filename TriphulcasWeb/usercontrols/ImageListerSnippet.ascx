<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImageListerSnippet.ascx.cs" Inherits="ImageListerSnippet" %>

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Repeater ID="users" ItemType="System.String" runat="server" OnItemDataBound="users_ItemDataBound">
            <ItemTemplate>
                <div class="sticker fullWidth">
                    <div class="stickerHeading galleryHeading" id="<%#Item %>">                        
                    </div>
                    <asp:Repeater ID="images" ItemType="umbraco.cms.businesslogic.media.Media" runat="server">
                        <ItemTemplate>
                            <%--<a class="imageLink" target="_blank" href="<%#Item.getProperty("umbracoFile").Value.ToString()%>">--%>
                                <img class="gallery" src="<%#Item.getProperty("umbracoFile").Value.ToString().Replace(".jpg", "_thumb.jpg") %>" title="<%#Item.Text%>" alt="<%#Item.Text%>" />
                            <%--</a>--%>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="clear"></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </ContentTemplate>
</asp:UpdatePanel>

<script type="text/javascript">

    $(function () {

        $('.stickerHeading.galleryHeading').each(function (index) {
            var self = this;
            $.get('/Facebook/GetHeaderProfile/' + $(this).attr("id"), function (profile) {
                $(self).html('<img class="galleryProfile" src="' + profile.url + '"/><span class="galleryText"><h1>' + profile.title + '</h1></span>');
            });
        });

        $('.gallery').click(function (e) {
            window.open($(this).attr('src').replace('_thumb.jpg','.jpg'), "_blank");
        });

    });

</script>
