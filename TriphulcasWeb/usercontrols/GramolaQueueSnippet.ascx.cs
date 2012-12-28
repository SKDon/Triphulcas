using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

using umbraco.BusinessLogic;
using umbraco.cms.businesslogic.member;

using System.Web.WebPages;


using System.Web.Security;
using Facebook;

using TriphulcasLib.UI;
using TriphulcasMvc.Controllers;
using umbraco.cms.businesslogic.web;
using umbraco.cms.businesslogic.relation;

public partial class GramolaQueue : TriphulcasPublicControl
{
    protected override void OnLoad(EventArgs e)
    {
            base.OnLoad(e);

            results.DataSource = GetPlaylistSongs();
            results.DataBind();
    }

    public List<SongRepeaterInfo> GetPlaylistSongs()
    {
        var temasList = new List<SongRepeaterInfo>();
        Document[] temas = GroovesharkController.GetTemasInGramola();
        foreach (var tema in temas)
            temasList.Add(new SongRepeaterInfo() {
                Thumbnail = GetAuthorThumbnailUrl(tema.Id),
                SongInfo = new GroovesharkController.JsonSong() { 
                    SongID = tema.getProperty("songID").Value.ToString(), 
                    SongName = tema.getProperty("songName").Value.ToString(), 
                    ArtistName = tema.getProperty("artistName").Value.ToString() 
                }});

        return temasList;
    }

    public string GetAuthorThumbnailUrl(int documentId)
    {
        string thmbUrl = "/img/unknown.gif";
        RelationType type = RelationType.GetByAlias("userSongs");
        var relations = Relation.GetRelations(documentId, type);

        if (relations != null && relations.Length > 0)
            thmbUrl = String.Format(Resources.Resource1.FacebookSquarePictureUrl, relations[0].Parent.Text);

        return thmbUrl;
    }   

    public class SongRepeaterInfo
    {
        public string Thumbnail { get; set; }
        public GroovesharkController.JsonSong SongInfo { get; set; }
    }
}