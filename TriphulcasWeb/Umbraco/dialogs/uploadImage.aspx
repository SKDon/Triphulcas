<%@ Page Language="c#" MasterPageFile="../masterpages/umbracoDialog.Master" CodeBehind="uploadImage.aspx.cs"
    AutoEventWireup="True" Inherits="umbraco.dialogs.uploadImage" %>

<%@ Register TagPrefix="cc1" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagName="MediaUpload" TagPrefix="umb" Src="../controls/Images/UploadMediaImage.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        body, html
        {
            margin: 0px !important;
            padding: 0px !important;
        }
    </style>

    <script type="text/javascript">
        function uploadHandler(e) {

            triphulcasHandler(e.id);

            //get the tree object for the chooser and refresh
            if (parent && parent.jQuery && parent.jQuery.fn.UmbracoTreeAPI) {
                var tree = parent.jQuery("#treeContainer").UmbracoTreeAPI();
                tree.refreshTree();
            }
        }

        function triphulcasHandler(id) {
            $.get('/Facebook/AssociateNewMedia/' + id, function (answer) {
                if (answer.rc == false)
                    alert('Error al asociar el contenido!\n(La imagen no será visible en los listados)');
            });
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <umb:MediaUpload runat="server" ID="MediaUploader" OnClientUpload="uploadHandler" />
</asp:Content>
