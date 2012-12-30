using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TriphulcasLib;
using TriphulcasLib.UI;
using umbraco.cms.businesslogic.relation;
using umbraco.cms.businesslogic.web;
using System.Text.RegularExpressions;

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

    public string GetFacebookPostUrl()
    {
        var article = new Document(umbraco.NodeFactory.Node.getCurrentNodeId());
        return String.Format("https://www.facebook.com/dialog/feed?app_id={0}&link={1}&picture={2}&name={3}&caption={4}&description={5}&redirect_uri={6}",
            Resources.Resource1.FacebookTriphulcasAppID,
            Request.Url,
            GetFirstImageUrl(article.getProperty("articulo").Value.ToString()),
            article.getProperty("titulo").Value.ToString(),
            article.getProperty("introduccion").Value.ToString(),
            Resources.Resource1.TriphulcasPressNote,
            String.Format("http://{0}/popupcloser?action=facebook_publish", Request.Url.Host)
            );
    }

    private string GetFirstImageUrl(string htmlContent)
    {
        string defaultImageUrl = String.Format("http://{0}/img/Tripulcas480.png", Request.Url.Host);
        string pattern = "<img src=\"(?<url>[^\"]+)\"";
        var match = Regex.Match(htmlContent, pattern);
        if (match.Success)
            defaultImageUrl = String.Format("http://{0}{1}", Request.Url.Host, match.Groups["url"].Value);
        return defaultImageUrl;
    }
}