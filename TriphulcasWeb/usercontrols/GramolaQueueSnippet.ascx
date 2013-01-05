<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GramolaQueueSnippet.ascx.cs" Inherits="GramolaQueue" %>


<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>

        <div class="sticker fullWidth">
            <div class="stickerHeading titillium">
                <h1><%= Resources.Resource1.ThemesInQueue%></h1>
            </div>

            <div class="clear"></div>

            <div class="result_wrapper" id="resultlist_wrapper">

                <asp:Repeater ID="results" ItemType="SongRepeaterInfo" runat="server">
                    <ItemTemplate>
                        <ul class="result" rel="<%#Item.SongInfo.SongID %>-search">
                            <li class="">
                                <div class="sharesong" rel="<%#Item.SongInfo.SongID %>" style="display:<%#IsTriphulcas?"block":"none"%>">
                                    <span class="button"></span>
                                </div>

                                <div class="play" id="sr-<%#Item.SongInfo.SongID %>" rel="<%#Item.SongInfo.SongID %>">
                                    <span class="button"></span>
                                </div>

                                <div class="thumbnail">
                                    <img src="<%#Item.Thumbnail %>" />
                                </div>

                                <div class="track">
                                    <ul>
                                        <li class="song"><%#Item.SongInfo.SongName %></li>
                                        <li class="artist"><%#Item.SongInfo.ArtistName %></li>
                                    </ul>
                                </div>

                                <div class="clear"></div>
                            </li>
                        </ul>
                    </ItemTemplate>
                </asp:Repeater>

            </div>

        </div>

    </ContentTemplate>
</asp:UpdatePanel>


<script type="text/javascript">
    $('#resultlist_wrapper ul.result div.sharesong').live("click", function () {
        $.ajax({
            url: '/Music/RemoveFromQueue',
            type: 'POST',
            dataType: 'json',
            data: JSON.stringify({ SongID: $(this).attr('rel')}),
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                // get the result and do some magic with it
                //var message = data.Message;

                //update updatepanel from client
                __doPostBack('UpdatePanel1', '');
            }
        });
    });
</script>