<%@ Control Language="C#" EnableViewState="false" AutoEventWireup="true" CodeBehind="FacebookFacepile.ascx.cs" Inherits="NWS.FacebookSocialPlugins.UserControls.FacebookFacepile" %>
<div id="NWS_<%= GetId() %>" class="NWS_FacebookFacepile"></div>
<script type="text/javascript">
    NWS_Obj = new Array();
    NWS_Obj[0] = '<%= GetIframeScriptUrl()%>';
    NWS_Obj[1] = 'NWS_<%= GetId() %>';
    NWS_Obj[2] = <%= PluginHeight %>;
    NWS_Obj[3] = <%= PluginWidth %>; 
    NWS_ALL[NWS_ALL.length] = NWS_Obj;
</script>