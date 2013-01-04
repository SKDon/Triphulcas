<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImageHomeSlider.ascx.cs" Inherits="usercontrols_ImageHomeSlider" %>

    <script src="/scripts/rocketfuel/rfsliderHome.js" type="text/javascript"></script>    
    <link href="/css/rfsliderHome.css" type="text/css" rel="stylesheet" />

<div id="placeholder" >  
  <div class="rfslidemask">   
    <ul class="rfslides" style="margin-left: 0px;">
        
<asp:Repeater ID="images" ItemType="umbraco.cms.businesslogic.media.Media" runat="server">
                        <ItemTemplate>
        <li class="rfslide" style="background:url(/ImageGen.ashx?class=home&image=<%#Item.getProperty("umbracoFile").Value.ToString()%>) no-repeat 0px 0px;" ><%--css stretch: background-size:auto 800px;--%>
          <%--<xsl:if test="url != ''">

<a href="{url}" target="_blank"><xsl:value-of select="title"/></a>
</xsl:if>--%>

        </li>
        </ItemTemplate>
    </asp:Repeater>
    </ul>
  </div>
  <a class="rfprev"  >
    <img src="/css/images/prev.png" width="0" height="0"/>
  </a>
  <a class="rfnext" >
      <img src="/css/images/next.png" width="0" height="0"/>
  </a>
</div>
  

<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery('#placeholder').rfSlider('init', { 'sliderwidth': 1000, 'sliderheight': 400, 'transition': true, 'slidetransition':'fade' });
    });
</script>
