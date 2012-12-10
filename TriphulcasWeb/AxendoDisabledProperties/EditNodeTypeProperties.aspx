<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="/umbraco/masterpages/umbracoPage.Master"
  CodeBehind="EditNodeTypeProperties.aspx.cs" Inherits="Axendo.Umb.DisabledProperties.EditNodeTypeProperties" %>
<%@ Register TagPrefix="ui" Namespace="umbraco.uicontrols" Assembly="controls" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
  <ui:UmbracoPanel ID="pnlUmbraco" runat="server" hasMenu="true" Text="Disable properties"
    Width="608px">
    <ui:Pane ID="pnl1" Style="padding: 10px; overflow:auto; text-align: left;" runat="server" Text="Select properties to disable">
      <asp:GridView CellSpacing="5" GridLines="None" ID="GridViewProperties" runat="server" AutoGenerateColumns="False" DataKeyNames="UserTypeId"
        AllowPaging="False" OnRowEditing="GridViewProperties_RowEditing" OnRowUpdating="GridViewProperties_RowUpdating" OnRowCancelingEdit="GridViewProperties_RowCancelingEdit" AutoGenerateEditButton="true" EnableViewState="False">
        <Columns>
        </Columns>
      </asp:GridView>
    </ui:Pane>
  </ui:UmbracoPanel>
</asp:Content>
