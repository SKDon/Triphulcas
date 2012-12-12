using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facebook;
using TriphulcasLib.UI;
using umbraco.cms.businesslogic.relation;
using umbraco.cms.businesslogic.web;
using umbraco.Linq.Core;
using umbraco.NodeFactory;

public partial class usercontrols_ArticlesSnippet : TriphulcasSnippet
{
    /// <summary>
    /// It seems we're not receiving parameter values from Umbraco. Maybe this is because we're using a Web Site instead of a Web App Prj?
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        base.SnippetWidth = 380;
        articles.DataSource = GetLatestArticles();
        articles.DataBind();
    }

    public Document [] GetLatestArticles()
    {
        //new Document(Node.getCurrentNodeId())
        return Document.GetDocumentsOfDocumentType(DocumentType.GetByAlias("Article").Id).OfType<Document>().OrderByDescending(d => d.UpdateDate).Take(5).ToArray<Document>();
        //return Node.GetCurrent().Children.OfType<Node>().Where(t => t.NodeTypeAlias == "Article").OrderBy(n => n.UpdateDate).Take(5).ToArray<Node>();
    }

    public string GetAuthorThumbnailUrl(int documentId)
    {
        string thmbUrl = "/img/unknown.gif";
        RelationType type = RelationType.GetByAlias("userArticles");
        var relations = Relation.GetRelations(documentId, type);

        if (relations != null && relations.Length > 0)
            thmbUrl = String.Format(Resources.Resource1.FacebookSquarePictureUrl, relations[0].Parent.Text);

        return thmbUrl;
    }    

    public override int SnippetWidth
    {
        get
        {
            return base.SnippetWidth;
        }
        set
        {
            base.SnippetWidth = value;
        }
    }

    public override bool RightSide
    {
        get
        {
            return base.RightSide;
        }
        set
        {
            base.RightSide = value;
        }
    }
}