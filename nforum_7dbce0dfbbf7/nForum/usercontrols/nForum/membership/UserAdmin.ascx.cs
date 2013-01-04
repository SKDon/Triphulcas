using System;
using System.Web.UI;
using nForum.BusinessLogic;
using TriphulcasLib;

namespace nForum.usercontrols.nForum.membership
{
    public partial class UserAdmin : BaseTriphulcasUserControl
    {
        protected void UmbracoLogout(object sender, EventArgs e)
        {
            MembershipHelper.LogoutMember();
        }
    }


}