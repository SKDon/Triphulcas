using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using TriphulcasLib;

namespace nForum.BusinessLogic
{
    public class BaseTriphulcasUserControl : UserControl
    {
        public FacebookPrincipal TriphulcasUser
        {
            get
            {
                return HttpContext.Current.User as FacebookPrincipal;
            }
        }
    }
}
