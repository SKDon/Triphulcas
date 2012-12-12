<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArticlesSnippet.ascx.cs" Inherits="usercontrols_ArticlesSnippet" %>

    <div class="<%=ClassName%>" style="width:<%=SnippetWidth%>px">
        <div class="stickerHeading titillium">
            <h1><%= Resources.Resource1.LastArticles %></h1>
        </div>
        <ul class="tickIcons">
        <asp:Repeater ID="articles" ItemType="umbraco.cms.businesslogic.web.Document" runat="server">                
            <ItemTemplate>
                <li><img src="<%#GetAuthorThumbnailUrl(Item.Id) %>" />&nbsp;<a href="<%#umbraco.library.NiceUrl(Item.Id) %>"><%#Item.Text %></a></li>
            </ItemTemplate>
        </asp:Repeater>
        </ul>
        
<%--            <li>Free, open source (<a href="http://www.opensource.org/licenses/mit-license.php">MIT license</a>)</li>
            <li>Pure JavaScript &mdash; works with any web framework</li>
            <li>
                Small & lightweight &mdash; 40kb minified
                <p class="smallprint">... reduces to 14kb when using HTTP compression</p>
            </li>
            <li>No dependencies</li>            
            <li>
                Supports all mainstream browsers
                <p class="smallprint">IE 6+, Firefox 2+, Chrome, Opera, Safari (desktop/mobile)</p>
            </li>
            <li>
                Fully documented
                <p class="smallprint">API docs, live examples, and interactive tutorials included</p>
            </li>--%>
        
    </div>
