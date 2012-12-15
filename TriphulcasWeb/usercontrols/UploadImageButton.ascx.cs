using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TriphulcasLib;
using TriphulcasLib.UI;
using umbraco.cms.businesslogic.relation;

public partial class usercontrols_UploadImageButton : TriphulcasPublicControl
{
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);

        //Extra logic: we only will show this control if the logged user is a genuine triphulca
        if (!IsTriphulcas)
            Visible = false;
    }
}