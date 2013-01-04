<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FramedStartup.aspx.cs" Inherits="Umbraco_plugins_FramedStartup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ride with Triphulcas!</title>
</head>
<body style="margin:0">
<iframe id="home" src="/" style="border: 0; position:absolute; top:0; left:0; right:0; bottom:0; width:100%; height:100%" ></iframe>
<iframe id="player" src="/player.aspx" style="border: 0px; width: 0; height: 0;visibility:hidden;display:none"></iframe>

<%--    <script type="text/javascript">
        
            document.getElementById("player").onload = function () {
                alert("myframe is loaded");
            };
        
    </script>--%>
</body>
</html>
