using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using umbraco.NodeFactory;
using umbraco.interfaces;
using TriphulcasLib;

namespace TriphulcasLib.UI
{
    /// <summary>
    /// Summary description for TriphulcasUserControl
    /// </summary>
    public class TriphulcasUserControl : System.Web.UI.UserControl
    {
        public TriphulcasUserControl()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public FacebookPrincipal User
        {
            get
            {
                return HttpContext.Current.User as FacebookPrincipal;
            }
        }

        public bool IsPreview
        {
            get
            {
                return !String.IsNullOrEmpty(Request.Params["preview"]);
            }
        }

        public bool IsPublic
        {
            get
            {
                IProperty property = Node.GetCurrent().GetProperty("public");
                return property != null && property.Value != "";
            }
        }

        public bool IsLiveEditing
        {
            get
            {
                return umbraco.presentation.UmbracoContext.Current.LiveEditingContext.Enabled;
            }
        }
    }

}