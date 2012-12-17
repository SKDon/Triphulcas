using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using umbraco.cms.businesslogic.media;

public partial class pages_ImageSlider : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        images.DataSource = GetCachedMediaByUser(UserName);
        images.DataBind();
    }

    public Media[] GetCachedMediaByUser(string user)
    {
        return (Cache["gallery"] as Dictionary<string, List<Media>>)[user].ToArray();
    }

    public string UserName { get { return Request.Params["userName"]; } }

    public int Margin
    {
        get
        {
            int margin = 0;
            if (!String.IsNullOrEmpty(Request.Params["page"]))
            {
                try
                {
                    margin = Int32.Parse(Request.Params["page"]) * -1000;
                }
                catch { }
            }
            return margin;
        }
    }

}