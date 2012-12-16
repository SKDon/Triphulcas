using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Mvc;
using System.Web.Routing;

using umbraco.BusinessLogic;

/// <summary>
/// MVC routing. Should move to TriphulcasHttpApplication!!
/// </summary>
public class TriphulcasAppBase : ApplicationBase
{
    //Instantiated at startup:
    public TriphulcasAppBase()
    {
        RouteTable.Routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

        RouteTable.Routes.MapRoute(
    "Triphulcas Controller Associate media to user",
    "Facebook/AssociateNewMedia/{mediaId}",
       new { controller = "Facebook", action = "AssociateNewMedia" }
        );

        RouteTable.Routes.MapRoute(
    "Triphulcas Controller Get Link By Article Id",
    "Facebook/GetArticleLinkById/{articleId}",
       new { controller = "Facebook", action = "GetArticleLinkById" }
        );

        RouteTable.Routes.MapRoute(
"Triphulcas Controller Get Profile by facebook user Id",
"Facebook/GetProfile/{id}",
new { controller = "Facebook", action = "GetProfile" }
);

        RouteTable.Routes.MapRoute(
"Triphulcas Controller Get Header (smaller) Profile by facebook user Id",
"Facebook/GetHeaderProfile/{id}",
new { controller = "Facebook", action = "GetHeaderProfile" }
);

        RouteTable.Routes.MapRoute(
            name: "Facebook Controller Any Action",
            url: "Facebook/{action}/{accesstoken}",
            defaults: new { controller = "Facebook", action = "Index", accesstoken = UrlParameter.Optional }
        );

        var app = new TriphulcasHttpApplication();
    }
}