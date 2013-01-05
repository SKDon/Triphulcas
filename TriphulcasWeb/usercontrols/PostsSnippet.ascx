<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PostsSnippet.ascx.cs" Inherits="usercontrols_PostListSnippet" %>

    <div class="<%=ClassName%>" style="width:<%=SnippetWidth%>px">
        <div class="stickerHeading titillium">
            <h1><%= Resources.Resource1.LastPosts %></h1>
        </div>
        <div id="liveExample" class="liveExample">
        <ul class="tickIcons">
        <asp:Repeater ID="articles" ItemType="umbraco.cms.businesslogic.web.Document" runat="server">                
            <ItemTemplate>
                <li><img src="<%#GetAuthorThumbnailUrl((int)Item.getProperty("forumPostOwnedBy").Value) %>" />&nbsp;<a href="<%#umbraco.library.NiceUrl(Item.ParentId) %>"><%#String.Format("{0} - en {1}", GetPostDateTime(Item), GetTopicName(Item))%></a></li>
            </ItemTemplate>
        </asp:Repeater>
        </ul>
            </div>
        
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
