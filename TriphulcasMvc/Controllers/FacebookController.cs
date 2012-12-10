using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

using umbraco.cms.businesslogic.relation;
using umbraco.cms.businesslogic.member;
using umbraco.cms.businesslogic.web;
using umbraco.BusinessLogic;


using Facebook;
using TriphulcasLib;
using umbraco.presentation;



namespace TriphulcasMvc.Controllers
{
    public class FacebookController : Controller
    {

        //
        // GET: /Facebook/
        [HttpGet]
        public ActionResult GetProfile(string id)
        {            
            try
            {
                if (User != null && User is FacebookPrincipal)
                {
                    string target = String.IsNullOrEmpty(id) ? "me" : id;
                    var client = new FacebookClient((User as FacebookPrincipal).AccesToken);
                    dynamic result = client.Get(target, new { fields = "first_name,id" });

                    return Json(new
                    {
                        title = result.first_name,
                        url = String.Format(Resources.Resource1.FacebookPictureUrl, result.id),
                        text = User.IsInRole("Triphulcas") ? Resources.Resource1.SnippetTriphulcasWelcomeMessage : Resources.Resource1.SnippetWelcomeMessage,
                        triphulcas = User.IsInRole("Triphulcas")
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                    return null;
            }
            catch (FacebookOAuthException ex)
            {
                return Json(new
                {
                    title = "Facebook Oauth Exception",
                    url = String.Empty,
                    text = ex.Message,
                    triphulcas = false
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public ActionResult Index()
        {
            return Json(new { }, JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public ActionResult Logout(string accesstoken)
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index");            
        }

        [HttpGet]
        public ActionResult GetArticleLink()
        {
            if (User != null && User is FacebookPrincipal && (User as FacebookPrincipal).IsInRole("Triphulcas"))
            {
                string articleLink = String.Empty;
                int articleCount = 1;

                var currentUser = User as FacebookPrincipal;
                var memberId = currentUser.GetMember().Id;
                //1a.- Search non published related articles                                    

                RelationType type = RelationType.GetByAlias("userArticles");
                var relations = Relation.GetRelations(memberId, type);
                Document document;
                
                foreach (Relation relation in relations)
                {
                    document = new Document(relation.Child.Id);
                    
                    if ((document.getProperty("public").Value.ToString()) != "1")//can't do document.Published because we have to publish always in order to use canvas edition
                    {
                        //articleLink = String.Format("/umbraco/canvas.aspx?redir=/{0}.aspx", document.Id);
                        articleLink = String.Format("/{0}.aspx", document.Id);
                        break;
                    }
                    articleCount++;
                }

                //1b.- Create new article
                if (String.IsNullOrEmpty(articleLink))
                {
                    DocumentType docType = DocumentType.GetByAlias("Article");
                    var doc = Document.MakeNew(String.Format("{0}_articulo_{1}", currentUser.UniqueLink, articleCount), docType, umbraco.BusinessLogic.User.GetUser(1), -1);//user "triphulca"
                    Relation.MakeNew(memberId, doc.Id, type, "new article");
                    doc.Publish(umbraco.BusinessLogic.User.GetUser(1));//user "triphulca"
                    umbraco.library.UpdateDocumentCache(doc.Id);

                    //articleLink = String.Format("/umbraco/canvas.aspx?redir=/{0}.aspx", doc.Id);
                    articleLink = String.Format("/{0}.aspx", doc.Id);
                }

                //REAL ACTIVATION OF LIVE EDITING:
                UmbracoContext.Current.LiveEditingContext.Enabled = true;

                //2.- Return target link in canvas mode
                return Json(new { url = articleLink }, JsonRequestBehavior.AllowGet);
            }
            else 
                return null;
        }
    }
}
