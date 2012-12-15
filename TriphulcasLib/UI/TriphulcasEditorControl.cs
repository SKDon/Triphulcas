using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TriphulcasLib.UI
{
    public class TriphulcasEditorControl : TriphulcasUserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //Security validation over session timed out
            if (IsLiveEditing && User == null)
                Response.Redirect("/");

            if (IsTrashed)
                this.Visible = false;
            else
                if ((!IsLiveEditing && IsPublic) || (IsLiveEditing && IsPreview))
                    this.Visible = false;
                else
                    this.Visible = true;
        }
    }
}
