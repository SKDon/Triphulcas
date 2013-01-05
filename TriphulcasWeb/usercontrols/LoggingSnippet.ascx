<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoggingSnippet.ascx.cs" Inherits="usercontrols_Snippet" %>
<div class="<%=ClassName%>" style="width:<%=SnippetWidth%>px">
    <div class="stickerHeading titillium">
        <h1 class="profileTitle"><b><%= Resources.Resource1.SnippetWelcomeTitle %>  </b><%=CurrentUserName%>!</h1>
    </div>
	<p id="pProfile" class="profile" runat="server" visible="true">
        <img id="pImage" runat="server" src="/img/unknown.gif" />
        <span id="pWelcome" runat="server"></span>        
        <button id="pLogout" runat="server" hidden style="display:none;"><%= Resources.Resource1.Logout %></button>
	</p>
    <%--Backup paragraph:--%>
    <p class="profile" id="pHidden" hidden style="display:none;">  
        <%= Resources.Resource1.SeeYou %>     
        <img src="/img/unknown.gif" />
        <span><%= Resources.Resource1.SnippetComebackBeforeLink %> <a class="popup" href="/authentication.aspx"><%= Resources.Resource1.SnippetComebackLink %> </a>.</span>        
	</p>
</div>

<script type="text/javascript">
    /// <reference path="../scripts/jquery-1.4.2.min.js" />

    function UpdateFacebookProfile(id) {
        $.get('/Facebook/GetProfile/' + id, function (profile) {
            $('.profileTitle').html('<b><%= Resources.Resource1.SnippetWelcomeTitle %> </b>' + profile.title + '!');
            $('#<%=pImage.ClientID%>').attr("src", profile.url);
            $('#<%=pWelcome.ClientID%>').html(profile.text);
            $('.profile button').show();

            //Update another strange snippet... ugly.
            UpdateTriphulcasActions(profile.triphulcas.toString());
        });

    }

    function SayBye(event) {
        $.get('/Facebook/Logout', function (empty) {
            $('.profileTitle').html('<%= Resources.Resource1.SeeYou %>');
            $('#<%=pImage.ClientID%>').attr("src", $('#pHidden img').attr("src"));
            $('#<%=pWelcome.ClientID%>').html($('#pHidden span').html());
            
            $('.profile button').hide();

            UpdateTriphulcasActions('false');
        });
        event.stopPropagation();        
    }
    
    if (!$('.profile button').data('events'))
        $('.profile button').bind("click", SayBye);
</script>