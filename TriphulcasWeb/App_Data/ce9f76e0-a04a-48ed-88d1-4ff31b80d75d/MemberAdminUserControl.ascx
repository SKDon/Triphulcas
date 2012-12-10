<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="MemberAdminUserControl.ascx.cs"
    Inherits="BP.Umb.Dashboard.MemberAdmin.MemberAdminUserControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script>
    $(document).ready(function () {
        $("#SearchTabs").tabs();
        $("#OpTabs").tabs();
    });
</script>
<script language="javascript">
    function SelectAllCheckboxes(spanChk) {
        // Added as ASPX uses SPAN for checkbox
        var oItem = spanChk.children;
        var theBox = (spanChk.type == "checkbox") ? spanChk : spanChk.children.item[0];
        xState = theBox.checked;
        elm = theBox.form.elements;
        for (i = 0; i < elm.length; i++)
            if (elm[i].type == "checkbox" && elm[i].id != theBox.id) {
                //elm[i].click();
                if (elm[i].checked != xState)
                    elm[i].click();
                //elm[i].checked=xState;
            }
    }
</script>
<script type="text/javascript" language="javascript">
    function ConfirmOnDelete() {
        if (confirm("Are you sure you want to apply the change on the selected members?") == true)
            return true;
        else
            return false;
    }
</script>

<asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
    <asp:View ID="ViewConfig" runat="server">
        <p>
        </p>
        <div style="float: left">
            <a href="http://www.blackpoint.dk">
                <img src="/usercontrols/BP.Umb.Dashboard/images/bplogo.png" alt="Blackpoint" /></a></div>
        <div>
            <h1 style="padding-top: 15px; padding-left: 70px;">
                Member Admin</h1>
        </div>
        <p>
        
        </p>
        <div id="SearchTabs">
            <ul>
                <li><a href="#SearchTab1"><span>Group filter</span></a></li>
                <li><a href="#SearchTab2"><span>Search</span></a></li>
            </ul>
            <div id="SearchTab1">
                <p class="guiDialogNormal">
                    <asp:ListBox ID="MemberGroupListBox" runat="server" DataTextField="text" DataValueField="text"
                        Rows="6" SelectionMode="Multiple" Width="239px"></asp:ListBox>
                    <asp:CheckBox ID="ReverseFilterCheckBox" runat="server" Text="Reverse filter" />
                    <asp:Button ID="ButtonGetData" runat="server" OnClick="ButtonGetData_Click" Text="Get data" />
                </p>
            </div>
            <div id="SearchTab2">
                <div class="guiDialogNormal">
                    <div>
                        <asp:Label ID="LabelListTypes" runat="server" Width="200px">Member Type: </asp:Label>
                        <asp:DropDownList ID="DropDownListTypes" runat="server" AutoPostBack="True" OnKeyUp="this.blur();"
                            OnSelectedIndexChanged="DropDownListTypes_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div><br />
                    <div>
                        <asp:UpdatePanel ID="regionPanel" runat="server" UpdateMode="Conditional">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="DropDownListTypes" EventName="SelectedIndexChanged" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:Label ID="LabelListTypeFields" runat="server" Width="200px" style="vertical-align: top;">Search Member Type Properties: </asp:Label>
                                <asp:ListBox ID="ListBoxListTypeFields" runat="server" SelectionMode="Multiple" Rows="8">
                                </asp:ListBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <p>
                    </p>
                    <asp:Label ID="Label1" runat="server">Search text: </asp:Label>
                    <asp:TextBox ID="TextBoxSearchQuery" runat="server" Width="250px"></asp:TextBox>
                    <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBoxSearchQuery"
                        ErrorMessage="You must enter a name or an email address" ValidationExpression="\w+([-+.]\w+)*(@\w+([-.]\w+)*(\.)?\w+([-.]\w+)*)?">
                    </asp:RegularExpressionValidator>  --%>
                    <asp:Button ID="ButtonSearch" runat="server" OnClick="ButtonSearch_Click" Text="Search" />
                </div>
            </div>
        </div>
        <br />
        <%--   <asp:Panel ID="PanelWait" HorizontalAlign="Center" Visible="false" runat="server">
        <img src="/usercontrols/BP.Umb.Dashboard/images/progress-indicator.gif" alt="Please wait ..."/>
   </asp:Panel>
        --%>
        <div class="ui-tabs ui-widget ui-widget-content ui-corner-all">
            <h3>
                Member result</h3>
            <br />
            <asp:Label ID="LabelMemberCount" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="LabelDebug" runat="server" Text=""></asp:Label>

            <asp:GridView ID="ResultGrid" runat="server"  Visible="True" Width="100%" AllowPaging="true"
                PageSize="10" EnableViewState="True" OnRowDataBound="ResultGrid_RowDataBound"
                OnPageIndexChanging="ResultGrid_PageIndexChanging" OnSortCommand="ResultGrid_SortCommand"
                ShowFooter="True" OnRowCreated="ResultGrid_RowCreated" OnPreRender="ResultGrid_PreRender">
                <AlternatingRowStyle BackColor="#E0E0E0" />
                <HeaderStyle BackColor="Silver"></HeaderStyle>
                <FooterStyle BackColor="Silver" />
                <PagerSettings Mode="Numeric" PageButtonCount="5" />
                <Columns>
                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSelection" runat="server" />
                        </ItemTemplate>
                        <HeaderTemplate>
                            <input id="chkAll" onclick="javascript:SelectAllCheckboxes(this);" runat="server" type="checkbox" />
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
 
            
            <%--
            <asp:DataGrid ID="ResultGrid1" runat="server" Visible="True" Width="100%" AllowPaging="true"
                PageSize="250" EnableViewState="True" OnItemDataBound="ResultGrid_ItemDataBound"
                OnPageIndexChanged="ResultGrid_PageIndexChanged" OnSortCommand="ResultGrid_SortCommand"
                ShowFooter="True" OnItemCreated="ResultGrid_ItemCreated" OnPreRender="ResultGrid_PreRender">
                <AlternatingRowStyle BackColor="#E0E0E0"></AlternatingItemStyle>
                <HeaderStyle BackColor="Silver"></HeaderStyle>
                <FooterStyle BackColor="Silver" />
                <Columns>
                    <asp:TemplateColumn HeaderText="Select" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSelection" runat="server" />
                        </ItemTemplate>
                        <HeaderTemplate>
                            <input id="chkAll" onclick="javascript:SelectAllCheckboxes(this);" runat="server"
                                type="checkbox" />
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateColumn>
                </Columns>
                <PagerStyle Mode="NumericPages" PageButtonCount="5" />
            </asp:DataGrid>
            --%>

        </div>
        <br />
        <div class="ui-tabs ui-widget ui-widget-content ui-corner-all">
            <h3>
                Member selection operations</h3>
            <br />
            <div id="OpTabs">
                <ul>
                    <li><a href="#OpTab1"><span>Delete members</span></a></li>
                    <li><a href="#OpTab2"><span>Export members</span></a></li>
                    <li><a href="#OpTab3"><span>Change groups</span></a></li>
                </ul>
                <div id="OpTab1">
                    <p class="guiDialogNormal">
                        <asp:Button ID="BtnApplyDelete" runat="server" Text="Delete selection..." OnClick="BtnApplyDelete_Click" />
                    </p>
                </div>
                <div id="OpTab2">
                    <p class="guiDialogNormal">
                        <asp:Label ID="Label2" runat="server" Text="Separator char: "></asp:Label>
                        <asp:TextBox ID="TextBoxExportSeparator" runat="server" MaxLength="1" 
                            Width="20px">;</asp:TextBox>
                        <br />
                        <asp:Button ID="BtnApplyExport" runat="server" Text="Export..." OnClick="BtnApplyExport_Click" />                        
                    </p>
                </div>
                <div id="OpTab3">
                    <div style="float: left;">
                        Add groups:<br />
                        &nbsp;<asp:ListBox ID="ListBoxAddGroup" runat="server" Rows="6" SelectionMode="Multiple"
                            DataTextField="text" DataValueField="text" Width="239px" ToolTip="Add to group">
                        </asp:ListBox>
                    </div>
                    <div>
                        Remove groups:<br />
                        &nbsp;<asp:ListBox ID="ListBoxRemoveGroup" runat="server" Rows="6" SelectionMode="Multiple"
                            DataTextField="text" DataValueField="text" Width="239px" ToolTip="Remove from group">
                        </asp:ListBox>
                    </div>
                    <i>Select one or more groups from the lists to add / remove the members to / from the
                        groups.</i>
                    <asp:Button ID="BtnApplyGroupChanges" runat="server" Text="Apply changes on selection..."
                        OnClick="BtnApplyGroupChanges_Click" />
                </div>
            </div>
            <br />
        </div>
    </asp:View>
    <asp:View ID="ViewConfirm" runat="server">
        <h3>
            Confirm operation</h3>
        <p>
            <asp:Label ID="LabelConfirmMessage" runat="server" Text="Label"></asp:Label></p>
        <asp:Button ID="BtnBackFromConfirm" runat="server" Text="<< Back" OnClick="BtnBackFromConfirm_Click" />
        <asp:Button ID="BtnConfirmOperation" runat="server" Text="Confirm operation" OnClick="BtnConfirmOperation_Click" />
    </asp:View>
    <asp:View ID="ViewStatus" runat="server">
        <h3>
            Operation status:</h3>
        <p>
            <asp:Label ID="LabelOperationStatus" runat="server" Text="Label"></asp:Label></p>
        <asp:Button ID="BtnOperationStatusOk" runat="server" Text="OK" OnClick="BtnOperationStatusOk_Click" />
    </asp:View>
</asp:MultiView>
