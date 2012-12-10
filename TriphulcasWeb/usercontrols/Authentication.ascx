<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Authentication.ascx.cs" Inherits="usercontrols_Authentication" %>
<div class="sticker" style="width:550px">
    <div class="stickerHeading titillium">
        <h1><b>Identificación </b><asp:Literal ID="LiteralTitle" Text="en curso" runat="server" />!</h1>
    </div>
	<p>
        <asp:Literal ID="LiteralText" runat="server" />	
	</p>
</div>
<div class="closing">
    <span></span>
</div>

<script type="text/javascript">    


    window.opener.UpdateFacebookProfile('<%=FacebookId%>');

    var array = [ "Cerrando", ".", ".", "." ];
    var index = 0;
    var timer = $.timer(function () {
        if (index < 4)
            $(".closing span").append(array[index++]);
        else
            window.close();
    });

    timer.set({ time: 500, autostart: true });
</script>