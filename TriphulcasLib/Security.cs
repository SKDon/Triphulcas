using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using System.Web.Security;

using umbraco.cms.businesslogic.member;

namespace TriphulcasLib
{
    public interface ICustomPrincipal : IPrincipal
    {
        string UserName { get; set; }
        string FirstName { get; set; }
        string AccesToken { get; set; }
        string UniqueLink { get; set; }
        string EMail { get; set; }

    }

    public class FacebookPrincipal : ICustomPrincipal
    {
        #region IPrincipal Members

        public IIdentity Identity
        {
            get;
            private set;
        }

        public bool IsInRole(string role)
        {
            return (roles != null && roles.Contains(role));
        }

        #endregion

        public FacebookPrincipal(string name, string[] roles)
        {
            this.Identity = new GenericIdentity(name);
            this.roles = roles;
        }

        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string AccesToken { get; set; }
        public string UniqueLink { get; set; }
        public string EMail { get; set; }
        public MembershipUser MembershipUser { get; set; }
        private string[] roles;

        #region Umbraco Member conversion methods

        public Member GetMember()
        {
            return Member.GetMemberFromLoginNameAndPassword(UniqueLink, AccesToken);
        }

        #endregion

    }

    public class FacebookPrincipalSerializableModel
    {
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string AccesToken { get; set; }
        public string UniqueLink { get; set; }
        public string EMail { get; set; }
    }
}
