using System;
using System.Web;
using System.Web.Security;
using System.Web.Script.Serialization;
using System.Security.Principal;

using Umbraco.Web;
using umbraco.BusinessLogic;

namespace TriphulcasLib
{
    public class TriphulcasAuthorizationModule : IHttpModule
    {
        public static Object locker = new Object();

        /// <summary>
        /// You will need to configure this module in the Web.config file of your
        /// web and register it with IIS before being able to use it. For more information
        /// see the following link: http://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpModule Members

        public void Dispose()
        {
            //clean-up code here.
        }

        public void Init(HttpApplication context)
        {
            // Below is an example of how you can handle LogRequest event and provide 
            // custom logging implementation for it
            context.LogRequest += new EventHandler(OnLogRequest);
            context.PostAuthenticateRequest += new EventHandler(context_PostAuthenticateRequest);
        }

        private MembershipUser Authorize(FacebookPrincipalSerializableModel model, out string[] roles)
        {
            MembershipUser mUser = null;
            roles = null;

            lock(locker) {

                //if (Membership.ValidateUser(model.UniqueLink,model.AccesToken)) {

                var col = Membership.FindUsersByName(model.UniqueLink);
                if (col != null && col.Count > 0)
                    foreach (MembershipUser user in col)
                    {
                        if (user.GetPassword() == model.AccesToken)
                            mUser = user;
                    }
                if (mUser != null)
                {
                    roles = Roles.GetRolesForUser(mUser.UserName);
                }
                if (mUser == null)
                {
                    //New user
                    mUser = Membership.CreateUser(model.UniqueLink, model.AccesToken, model.EMail);
                }
            }

            return mUser;
        }

        //After authentication, if successful, perform authorization
        void context_PostAuthenticateRequest(object sender, EventArgs e)
        {
            //Disregard backoffice requests:
            if (UmbracoContext.Current == null || UmbracoContext.Current.HttpContext.Request.Url.AbsolutePath.StartsWith("/umbraco")) //NOT WORKING!!!UmbracoContext.Current.IsFrontEndUmbracoRequest)
                return;

            HttpContext context = (sender as HttpApplication).Context;
         
            HttpCookie authCookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (authCookie != null)
            {
                //Extract the forms authentication cookie
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);

                // If caching roles in userData field then extract
                FacebookPrincipalSerializableModel model = new JavaScriptSerializer().Deserialize<FacebookPrincipalSerializableModel>(authTicket.UserData);

                //Search roles: TODO: implement with mail address
                MembershipUser mUser = null;
                string[] roles = null;

                mUser = Authorize(model, out roles);                

                // Create the IPrinciple instance
                IPrincipal principal = new FacebookPrincipal(model.UserName, roles)
                {
                    FirstName = model.FirstName,
                    AccesToken = model.AccesToken,
                    UniqueLink = model.UniqueLink,
                    EMail = model.EMail,
                    MembershipUser = mUser
                };

                // Set the context user 
                context.User = principal;

                if (principal.IsInRole("Triphulcas"))
                {
                    //if (String.IsNullOrEmpty(umbraco.BasePages.BasePage.umbracoUserContextID))
                    if (umbraco.BasePages.UmbracoEnsuredPage.CurrentUser == null)
                        // Hack. Set the Umbraco backoffice related user as logged - in
                        umbraco.BasePages.BasePage.doLogin(new User("triphulca"));
                }
            }
        }

        #endregion

        public void OnLogRequest(Object source, EventArgs e)
        {
            //custom logging logic can go here
        }
    }
}
