using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

using umbraco.BusinessLogic;
using umbraco.cms.businesslogic.member;
using umbraco.Linq.Core;
using umbraco.cms.businesslogic.relation;
using umbraco.cms.businesslogic.web;
using System.Web.WebPages;


using System.Web.Security;
using Facebook;

using TriphulcasLib.UI;
using umbraco.cms.businesslogic.media;
using System.Collections;

public partial class ImageListerSnippet : TriphulcasPublicControl
{    
    private Dictionary<string,List<Media>> _imagesByUser = null;
    private Dictionary<int, string> _usersByImage = null;
    private List<Media> _allImages = null;

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
       
        string[] userNames = Roles.GetUsersInRole("Triphulcas");
        RelationType type = RelationType.GetByAlias("userMedia");
        _imagesByUser = new Dictionary<string, List<Media>>(userNames.Length);
        _usersByImage = new Dictionary<int, string>();
        _allImages = new List<Media>();
        var comparer = new MediaComparer();

        foreach (string userName in userNames)
        {
            var member = Member.GetMemberByName(userName, false);
            if (member != null && member.Length > 0)
            {
                _imagesByUser[userName] = new List<Media>();

                var relations = Relation.GetRelations(member[0].Id, type);

                if (relations != null && relations.Length > 0)
                {
                    foreach (var relation in relations)
                    {
                        var media = new Media(relation.Child.Id);
                        _imagesByUser[userName].Add(media);
                        _usersByImage[media.Id] = userName;
                        _allImages.Add(media);
                    }

                    _imagesByUser[userName].Sort(comparer);
                }
            }
        }

        _allImages.Sort(comparer);

        users.DataSource = GetUserNamesWithImagesOrderedByCreationDate();
        users.DataBind();

    }

    public class MediaComparer : IComparer<Media>
    {

        #region IComparer<Media> Members

        public int Compare(Media x, Media y)
        {
            return x.CreateDateTime.CompareTo(y.CreateDateTime) * -1;
        }

        #endregion
    }

    public IEnumerable<Media> GetAllImagesOrderedByCreationDate()
    {
        return Media.GetMediaOfMediaType(MediaType.GetByAlias("Image").Id).OrderByDescending(m => m.CreateDateTime);
    }

    public string[] GetUserNamesWithImagesOrderedByCreationDate()
    {
        var userNames = new List<string>();
        foreach (var media in _allImages)
        {
            var userName = _usersByImage[media.Id];
            if (!userNames.Contains(userName))
                userNames.Add(userName);
        }
        return userNames.ToArray();
    }

    public Media[] GetImagesByMemberName(string name)
    {
        return _imagesByUser[name].ToArray();
    }
    protected void users_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item) ||
    (e.Item.ItemType == ListItemType.AlternatingItem))
        {
            // inner repeater:
            Repeater child = (Repeater)e.Item.FindControl("images");
            
            child.DataSource = GetImagesByMemberName(e.Item.DataItem.ToString());
            child.DataBind();
        }
    }
}