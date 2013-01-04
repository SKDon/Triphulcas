<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserAdmin.ascx.cs" Inherits="nForum.usercontrols.nForum.membership.UserAdmin" %>

    <div id="forumloggedinstatus">    
        <%--<asp:LoginStatus ID="ctlLogin"
                     runat="server"
                     LoginText="User Login"
                     LogoutText="User Logout" OnLoggedOut="UmbracoLogout" /> / --%>
                     <asp:LoginName ID="ctlLoginName" runat="server" />
    </div>

    <div id="forumloggedinadmin">
        <ul>
            <li><a href="/activetopics.aspx">Temas activos</a></li>
            <li><a href="/yourtopics.aspx">Temas en los que participas</a></li>
            <li><a href="/editprofile.aspx">Indicar correo</a></li>
        </ul>
    </div>