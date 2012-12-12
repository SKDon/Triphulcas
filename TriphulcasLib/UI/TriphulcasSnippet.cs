using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TriphulcasLib.UI
{
    public class TriphulcasSnippet : TriphulcasUserControl
    {
        public virtual bool RightSide { get; set; }

        private int width = 494;
        public virtual int SnippetWidth { get { return width; } set { width = value; } }

        public string ClassName
        {
            get
            {
                var className = new StringBuilder("sticker");

                if (RightSide)
                    className.Append(" floatRight");

                return className.ToString();
            }
        }
    }
}
