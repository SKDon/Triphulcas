<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImageSlider.aspx.cs" Inherits="pages_ImageSlider" %>
<%@ Register TagPrefix="ui" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="umb" Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Imágenes</title>

    <ui:UmbracoClientDependencyLoader runat="server" id="ClientLoader" />
	
	<umb:JsInclude ID="JsInclude3" runat="server" FilePath="ui/jquery.js" PathNameAlias="UmbracoClient" Priority="0" />
	<umb:JsInclude ID="JsInclude9" runat="server" FilePath="Application/jQuery/jquery.noconflict-invoke.js" PathNameAlias="UmbracoClient" Priority="1" />

    <script src="/scripts/rocketfuel/rfslider.js" type="text/javascript"></script>    
    <link href="/css/rfslider.css" type="text/css" rel="stylesheet" />

</head>
<body>
<div id="placeholder" >  
  <div class="rfslidemask">   
    <ul class="rfslides" style="margin-left: <%=Margin%>px;">
        
<asp:Repeater ID="images" ItemType="umbraco.cms.businesslogic.media.Media" runat="server">
                        <ItemTemplate>
        <li class="rfslide" style="background:url(/ImageGen.ashx?image=<%#Item.getProperty("umbracoFile").Value.ToString()%>) no-repeat 0px 0px;" ><%--css stretch: background-size:auto 800px;--%>
          <%--<xsl:if test="url != ''">

<a href="{url}" target="_blank"><xsl:value-of select="title"/></a>
</xsl:if>--%>

        </li>
        </ItemTemplate>
    </asp:Repeater>
    </ul>
  </div>
  <a class="rfprev"  >
    <img src="/css/images/prev.png" width="40" height="40"/>
  </a>
  <a class="rfnext" >
      <img src="/css/images/next.png" width="40" height="40"/>
  </a>
</div>
  

<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery('#placeholder').rfSlider('init', { 'sliderwidth': 1000, 'sliderheight': 800, 'transition': false });
    });
</script>
</body>
</html>
