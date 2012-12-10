<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArticleIntroductionSnippet.ascx.cs" Inherits="usercontrols_TestUC" %>
<div class="sticker fullWidth">
    <div class="stickerHeading titillium">
        <h1><%=Resources.Resource1.ArticleIntroduction %></h1>
    </div>
    <umbraco:Item ID="Item1" field="introduccion" runat="server" />
    <div class="clear"></div>
</div>