<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GramolaSnippet.ascx.cs" Inherits="GramolaSnippet" %>



<div class="sticker fullWidth">
    <div class="stickerHeading titillium">
        <h1><%= Resources.Resource1.GramolaPlayerGreeting %></h1>
    </div>




    <div class="search_wrapper png" id="search_wrapper">
        <div class="bar" id="search_wrapper_bar">
            <form id="search_form">
                <input type="text" tabindex="" rel="Buscar" value="Buscar" name="search" id="search_input" onfocus="if(!window.tinysong&&this.value!=this.rel)this.value='';" onblur="if(!window.tinysong&&this.value=='')this.value=this.rel;">
                <a class="icon png" id="icon_button" href="/"><span>Search</span></a>
            </form>
        </div>
    </div>


        <div class="clear"></div>
    <div id="page_wrapper">
        <div class="box start" id="message_box">
            <div class="top">
                <div class="cap right"></div>
                <div class="cap left"></div>
            </div>
            <div class="message">
                <div id="message_text">
                    		<span class="text">
	    	Realiza tu búsqueda y pulsa <span class="strong">intro</span>.
	    </span>
                </div>
                <div class="loadinggraphic" id="loadinggraphic"></div> 
            </div>
            <div class="bottom">
                <div class="cap right"></div>
                <div class="cap left"></div>
            </div>
        </div>

        <div class="clear"></div>

        <div id="content_wrapper">
              
            
<!-- RHL061 / 489664 / 0 -->
    
        </div>
    </div>




    <div class="clear"></div>
    
    


    
</div>
