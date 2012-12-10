using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TriphulcasLib.UI
{
    public class TriphulcasPublicControl : TriphulcasUserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((!IsLiveEditing && IsPublic) || (IsLiveEditing && IsPreview))
                this.Visible = true;
            else
                this.Visible = false;
        }
    }
}
