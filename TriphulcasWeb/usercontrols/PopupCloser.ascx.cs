using System;
using System.Collections.Generic;
using System.Linq;
using System.Resources;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class usercontrols_PopupCloser : System.Web.UI.UserControl
{
    ResourceManager resxManager = new ResourceManager("TriphulcasMvc.MVCCustomResources.Resource1", typeof(Resources.Resource1).Assembly);

    protected void Page_Load(object sender, EventArgs e)
    {
        LiteralAction.Text = resxManager.GetString(Request.Params["action"]);
        LiteralTitle.Text = String.IsNullOrEmpty(Request.Params["error"]) ? Resources.Resource1.WithoutProblems : Resources.Resource1.WithProblems;
        if (!String.IsNullOrEmpty(Request.Params["message"]))
            LiteralText.Text = resxManager.GetString(Request.Params["message"]);
        
    }
}