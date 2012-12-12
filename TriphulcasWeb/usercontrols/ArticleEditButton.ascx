﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArticleEditButton.ascx.cs" Inherits="usercontrols_ArticleEditButton" %>


 <div id="slogan">
            <p class="engraved"><%=String.Format(Resources.Resource1.EditArticleDescription,User.FirstName) %></p>
            <a class="download-button" href="#">
                <p><%=Resources.Resource1.EditArticle %></p>
                <%--<p class="smallprint">v2.2.0 - 14kb min+gz</p>--%>
            </a>
        </div>


<script type="text/javascript">

    $('.download-button').click(function () {        
        $.get('/Facebook/GetArticleLinkById/<%=umbraco.NodeFactory.Node.getCurrentNodeId()%>', function (target) {
            window.location = target.url;
        });
    });

</script>