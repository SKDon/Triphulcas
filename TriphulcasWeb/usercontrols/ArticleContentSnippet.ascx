<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArticleContentSnippet.ascx.cs" Inherits="usercontrols_TestUC" %>
<div class="sticker fullWidth">
    <div class="stickerHeading titillium">
        <h1><%=Resources.Resource1.ArticleContent %></h1>
    </div>
    <umbraco:Item ID="Item1" field="articulo" runat="server" />
    <div class="clear"></div>
</div>