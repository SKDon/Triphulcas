using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

using umbraco.BusinessLogic;
using umbraco.cms.businesslogic.member;

using System.Web.WebPages;


using System.Web.Security;
using Facebook;

using TriphulcasLib.UI;

public partial class usercontrols_TestUC : TriphulcasSnippet
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool isSomeoneLoggedIn = System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
        var member = System.Web.Security.Membership.GetUser();
        

        //MemberGroup[] array = MemberGroup.GetAll;
        //string[] array2 = Roles.GetAllRoles();
    }
}