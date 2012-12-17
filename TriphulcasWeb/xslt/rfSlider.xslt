<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:msxml="urn:schemas-microsoft-com:xslt"
  xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" xmlns:Redengine.Global.XsltExtensions="urn:Redengine.Global.XsltExtensions" 
  exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets Redengine.Global.XsltExtensions ">


<xsl:output method="xml" omit-xml-declaration="yes"/>
<xsl:param name="currentPage"/>
<xsl:template match="/">

<div id="placeholder" >  
  <div class="rfslidemask">   
    <ul class="rfslides" >
        <xsl:for-each select="$currentPage/RF-Slide">
        <li class="rfslide" style="background:url({image}) no-repeat 0px 0px;" >
          <xsl:if test="url != ''">
            <xsl:variable name="window">
              <xsl:choose>
              <xsl:when test="linkTarget = 'New Browser'">
                _blank
              </xsl:when>
              <xsl:otherwise>
                
              </xsl:otherwise>
              </xsl:choose>
          </xsl:variable>
<a href="{url}" target="{$window}"><xsl:value-of select="title"/></a>
</xsl:if>

        </li>
        </xsl:for-each>
    </ul>
  </div>
  <a class="rfprev"  >
    <img src="/css/images/prev.png" width="40" height="40"/>
  </a>
  <a class="rfnext" >
      <img src="/css/images/next.png" width="40" height="40"/>
  </a>
</div>
  
<xsl:value-of select="umbraco.library:RegisterJavaScriptFile('jQuery1.6', ' http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.2.min.js')"/>  
<xsl:value-of select="umbraco.library:RegisterJavaScriptFile('rfSlider', ' /scripts/rocketfuel/rfslider.js')"/>
<xsl:value-of select="umbraco.library:RegisterStyleSheetFile('rfSliderStyle', '/css/rfslider.css')"/>

<script type="text/javascript">    
$(document).ready(function() {
  $('#placeholder').rfSlider('init',{'sliderwidth' : 400,'sliderheight' : 200});
});
</script>

</xsl:template>

</xsl:stylesheet>