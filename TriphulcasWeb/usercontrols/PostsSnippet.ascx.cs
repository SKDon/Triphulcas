using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facebook;
using TriphulcasLib.UI;
using umbraco.cms.businesslogic.member;
using umbraco.cms.businesslogic.relation;
using umbraco.cms.businesslogic.web;
using umbraco.Linq.Core;
using umbraco.NodeFactory;

public partial class usercontrols_PostListSnippet : TriphulcasSnippet
{
    /// <summary>
    /// It seems we're not receiving parameter values from Umbraco. Maybe this is because we're using a Web Site instead of a Web App Prj?
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        base.SnippetWidth = 494;
        articles.DataSource = GetLatestPosts();
        articles.DataBind();
    }

    public Document [] GetLatestPosts()
    {
        //new Document(Node.getCurrentNodeId())
        var posts = Document.GetDocumentsOfDocumentType(DocumentType.GetByAlias("ForumPost").Id).OfType<Document>().OrderByDescending(d => d.UpdateDate).Take(5).ToArray<Document>();
        return posts;
        //return Node.GetCurrent().Children.OfType<Node>().Where(t => t.NodeTypeAlias == "Article").OrderBy(n => n.UpdateDate).Take(5).ToArray<Node>();        
    }

    public string GetTopicName(Document post)
    {
        return new Document(post.ParentId).Text;
    }

    public string GetPostDateTime(Document post)
    {
        return String.Format("{0} a las {1}:{2}",
            (post.UpdateDate.Date == DateTime.Now.Date) ? "Hoy" :
                String.Format("El {0}", post.UpdateDate.ToShortDateString()),
            post.UpdateDate.TimeOfDay.Hours.ToString(),
            post.UpdateDate.TimeOfDay.Minutes.ToString());
    }

    public string GetAuthorThumbnailUrl(int documentId)
    {
        string thmbUrl = "/img/unknown.gif";

        try
        {
            thmbUrl = String.Format(Resources.Resource1.FacebookSquarePictureUrl, new Member(documentId).Text);
        }
        catch { }

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