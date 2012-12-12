using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TriphulcasLib;
using TriphulcasLib.UI;
using umbraco.cms.businesslogic.relation;

public partial class usercontrols_ArticleEditButton : TriphulcasPublicControl
{
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);

        //Extra logic: we only will show this control if the logged user is the article's owner
        if (Visible)
        {
            Visible = false;

            if (User != null && User is FacebookPrincipal)
            {
                RelationType type = RelationType.GetByAlias("userArticles");
                var relations = Relation.GetRelations(umbraco.NodeFactory.Node.getCurrentNodeId(), type);

                if (relations != null && relations.Length > 0)
                    if (relations[0].Parent.Id == (User as FacebookPrincipal).GetMember().Id)
                        Visible = true;
            }
        }
    }
}