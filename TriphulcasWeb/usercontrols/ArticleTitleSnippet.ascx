<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArticleTitleSnippet.ascx.cs" Inherits="usercontrols_TestUC" %>
<div class="sticker fullWidth">
    <div class="stickerHeading titillium">
        <h1><%=Resources.Resource1.ArticleTitle %></h1>
    </div>
    <umbraco:Item ID="Item1" field="titulo" runat="server" />
    <div class="clear"></div>
</div>