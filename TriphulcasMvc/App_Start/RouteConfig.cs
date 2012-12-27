using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace TriphulcasMvc
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            //routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

    //        routes.MapRoute(
    //"Grooveshark Controller to play streaming music",
    //"Grooveshark/PlaySong/{songId}",
    //new { controller = "Grooveshark", action = "PlaySong" },
    //new { songId = @"\d{6}" }
    //);

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{accesstoken}",
                defaults: new { controller = "Facebook", action = "GetProfile", accesstoken = UrlParameter.Optional }
            );
        }
    }
}