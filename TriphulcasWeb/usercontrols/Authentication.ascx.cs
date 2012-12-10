using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebPages;
using Microsoft.Web.WebPages.OAuth;

using Facebook;
using TriphulcasLib;
using TriphulcasMvc;

public partial class usercontrols_Authentication : System.Web.UI.UserControl
{

    protected void Page_Load(object sender, EventArgs e)
        {
        if (Request.Params["comefromfucker"] == "true")
        {
            var result = OAuthWebSecurity.VerifyAuthentication("/authentication.aspx?comefromfucker=true");

            if (result.IsSuccessful)
            {
                FacebookId = result.ExtraData["id"];
                string link = new Uri(result.ExtraData["link"]).AbsolutePath.Substring(1);
                string email = "";
                string first_name = "";

                try
                {
                    //email request
                    var client = new FacebookClient(result.ExtraData["accesstoken"]);
                    //var me = (IDictionary<string,object>)client.Get("me");
                    //email = (string)me["email"];
                    dynamic me = client.Get("me", new { fields = "email, first_name" });
                    email = me.email;
                    first_name = me.first_name;
                }
                catch (FacebookOAuthException)
                {
                }

                if (String.IsNullOrEmpty(email))
                    email = String.Format("{0}@nomail.com", link);

                FacebookPrincipalSerializableModel model = new FacebookPrincipalSerializableModel()
                {
                    UserName = result.UserName,
                    FirstName = first_name,
                    UniqueLink = link,
                    EMail = email,
                    AccesToken = result.ExtraData["accesstoken"]
                };

                string userData = new JavaScriptSerializer().Serialize(model);

                var ticket = new FormsAuthenticationTicket(
                    1,
                    result.UserName,
                    DateTime.Now,
                    DateTime.Now.AddMinutes(30),
                    true,
                    userData,
                    FormsAuthentication.FormsCookiePath);

                string encryptedTicket = FormsAuthentication.Encrypt(ticket);

                //Cookie de autenticación. Almacenado el accesstoken
                Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket));

                LiteralTitle.Text = Resources.Resource1.WithoutProblems;
                LiteralText.Text = String.Format(Resources.Resource1.AuthenticationWelcomeMessage, result.UserName);
            }
            else
            {
                LiteralTitle.Text = Resources.Resource1.WithProblems; 
                LiteralText.Text = Resources.Resource1.TryAgainLater;
            }
        }
        else
        {
            if (OAuthWebSecurity.RegisteredClientData == null || OAuthWebSecurity.RegisteredClientData.Count == 0)
            {
                OAuthWebSecurity.RegisterFacebookClient(
                    appId: "397157543686506",
                    appSecret: "3571703fc763bc1b6610fd6c408fd9ac");
            }

            OAuthWebSecurity.RequestAuthentication("facebook", "/authentication.aspx?comefromfucker=true");
        }
    }

    private string facebookId = "";
    public string FacebookId { get { return facebookId; } set { facebookId = value; } }

}