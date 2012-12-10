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
            name: "Facebook Controller",
            url: "Facebook/{action}/{accesstoken}",
            defaults: new { controller = "Facebook", action = "Index", accesstoken = UrlParameter.Optional }
        );

        var app = new TriphulcasHttpApplication();
    }    
}