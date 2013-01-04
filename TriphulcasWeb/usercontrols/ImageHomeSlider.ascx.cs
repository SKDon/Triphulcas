using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TriphulcasLib.UI;
using umbraco.cms.businesslogic.media;
using umbraco.cms.businesslogic.member;
using umbraco.cms.businesslogic.relation;

public partial class usercontrols_ImageHomeSlider : TriphulcasPublicControl
{
    protected void Page_Load(object sender, EventArgs e)
    {



        images.DataSource = GetCachedMedia();
        images.DataBind();
    }



    public Media[] GetCachedMedia()
    {
        if (Cache["allImages"] == null)
        {
            string[] userNames = Roles.GetUsersInRole("Triphulcas");
            RelationType type = RelationType.GetByAlias("userMedia");
            var _allImages = new List<Media>();

            foreach (string userName in userNames)
            {
                var member = Member.GetMemberByName(userName, false);
                if (member != null && member.Length > 0)
                {
                    var relations = Relation.GetRelations(member[0].Id, type);

                    if (relations != null && relations.Length > 0)
                    {
                        foreach (var relation in relations)
                        {
                            var media = new Media(relation.Child.Id);
                            _allImages.Add(media);
                        }
                    }
                }
            }

            //kludgy & clumsy fast approach for popup-viewer
            Cache["allImages"] = _allImages;
        }

        Random rnd = new Random();
        return (Cache["allImages"] as List<Media>).ToArray<Media>().OrderBy(x => rnd.Next()).ToArray();
        //return (Cache["allImages"] as List<Media>).ToArray();
        
    }

}