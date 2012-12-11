using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using umbraco.NodeFactory;
using umbraco.interfaces;
using TriphulcasLib;
using umbraco.cms.businesslogic.web;

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
                var property = new Document(Node.getCurrentNodeId()).getProperty("public");
                return property != null && property.Value.ToString() == "1";
            }
        }

        public bool IsLiveEditing
        {
            get
            {
                return umbraco.presentation.UmbracoContext.Current.LiveEditingContext.Enabled;
            }
        }

        public bool IsTrashed
        {
            get
            {
                return new Document(Node.getCurrentNodeId()).IsTrashed;
            }
        }
    }

}