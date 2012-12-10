<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArticleViewerSnippet.ascx.cs" Inherits="usercontrols_TestUC" %>
<div class="sticker fullWidth">
    <div class="stickerHeading titillium">
        <h1><umbraco:Item ID="Item3" field="titulo" runat="server" /></h1>
    </div>
    <umbraco:Item ID="Item2" field="introduccion" runat="server" />
    <div class="clear"></div>
    <umbraco:Item ID="Item1" field="articulo" runat="server" />
    <div class="clear"></div>
</div>