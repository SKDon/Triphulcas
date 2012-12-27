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

public partial class GramolaSnippet : TriphulcasPublicControl
{
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);

        //Extra logic: we only will show this control if the logged user is a genuine triphulca
        if (!IsTriphulcas)
            Visible = false;

    }
}