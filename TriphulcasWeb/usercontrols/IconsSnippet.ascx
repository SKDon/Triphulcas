<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IconsSnippet.ascx.cs" Inherits="usercontrols_TestUC" %>
<div class="sticker fullWidth">
    <div class="stickerHeading titillium">
        <h1><%=Resources.Resource1.TitleMainSnippet %></h1>
    </div>
    <ul id="introBadges">        
        <li id="articleBadge">
            <img src="img/feature-icons/declarative-bindings.png" />					
            <p class="titillium heading">Crear artículo</p>
            <p>Haz click aquí para comenzar un nuevo artículo o terminar el último que dejaste a medias.</p>						
        </li>					        
        <li id="galleryBadge">
            <img src="img/feature-icons/automatic-refreshing.png" />					
            <p class="titillium heading">Galería de imágenes</p>
            <p>La comunidad tiene mucho que decir de tus imágenes</p>						
        </li>                
        <li id="soundBadge">
            <img src="img/feature-icons/dependency-tracking.png" />					
            <p class="titillium heading">Gramola</p>
            <p>Quita la basura que puso ese pringao y pincha algo que mole</p>
        </li>        
        <li id="forumBadge">
            <img src="img/feature-icons/templating.png" />					
            <p class="titillium heading">Foro</p>
            <p>El rellano de villa triphulcas, rincón de las verduleras</p>
        </li>					
    </ul>
    <div class="clear"></div>
</div>

<script type="text/javascript">
    /// <reference path="../scripts/jquery-1.4.2.min.js" />
    $(function () {
        UpdateTriphulcasActions('<%=(User!=null && User.IsInRole("Triphulcas"))%>');        
    });

    //$('#introBadges
    function UpdateTriphulcasActions(isTriphulcas) {
        if (isTriphulcas!=null && isTriphulcas.toLowerCase() == 'true') {
            $('#articleBadge').show();            
            $('#soundBadge').show();
        }
        else {
            $('#articleBadge').hide();
            $('#soundBadge').hide();
        }
    }
    

    $('#articleBadge').click(function () {
        //move to ready event?
        $.get('/Facebook/GetArticleLink', function (target) {
            window.location = target.url;
        });        
    });

</script>
