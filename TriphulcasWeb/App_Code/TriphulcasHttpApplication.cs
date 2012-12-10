using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using Umbraco.Web;

/// <summary>
/// Summary description for TriphulcasHttpApplication
/// </summary>
public class TriphulcasHttpApplication : UmbracoApplication
{
    public TriphulcasHttpApplication()
    {
        //
        // TODO: Add constructor logic here
        //
        base.AuthenticateRequest += new EventHandler(TriphulcasHttpApplication_AuthenticateRequest);        
    }

    //Authorization perform:
    void TriphulcasHttpApplication_AuthenticateRequest(object sender, EventArgs e)
    {

        //Doesn't seem work.


    }

}

