<%@ WebHandler Language="c#" Class="RequestHandler" %>

using System.Reflection;
using System.Web;
using System;

public class RequestHandler : System.Web.IHttpHandler
{
    public bool IsReusable
    {
        get { return false; }
    }

    public void ProcessRequest(System.Web.HttpContext context)
    {

        System.Web.HttpContext.Current = new System.Web.HttpContext(CreateRequest(context), context.Response);
        //context.Request
        var fakeContext = System.Web.HttpContext.Current;
        //fakeContext.Request.ServerVariables["HTTP_HOST"] = "localhost";        
        ImageGen.ImageGenQueryStringParser parser = new ImageGen.ImageGenQueryStringParser();
        parser.Process(fakeContext);
        parser = null;

        //fakeContext.Response.OutputStream
    }

    public System.Web.HttpRequest CreateRequest(System.Web.HttpContext context)
    {
        string currentHostName = context.Request.ServerVariables["HTTP_HOST"];
        var request = new System.Web.HttpRequest(context.Request.FilePath, context.Request.Url.ToString().Replace(currentHostName, "localhost"), context.Request.QueryString.ToString());

        BindingFlags temp = BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Static;

        MethodInfo addStatic = null;
        MethodInfo makeReadOnly = null;
        MethodInfo makeReadWrite = null;

        Type type = context.Request.ServerVariables.GetType();
        MethodInfo[] methods = type.GetMethods(temp);
        foreach (MethodInfo method in methods)
        {
            switch (method.Name)
            {
                case "MakeReadWrite": makeReadWrite = method;
                    break;
                case "MakeReadOnly": makeReadOnly = method;
                    break;
                case "AddStatic": addStatic = method;
                    break;
            }
        }


        makeReadWrite.Invoke(request.ServerVariables, null);


        int loop1, loop2;
        System.Collections.Specialized.NameValueCollection coll;        

        // Load ServerVariable collection into NameValueCollection object.
        coll = context.Request.ServerVariables;
        // Get names of all keys into a string array. 
        String[] arr1 = coll.AllKeys;
        for (loop1 = 0; loop1 < arr1.Length; loop1++)
        {
            String[] arr2 = coll.GetValues(arr1[loop1]);
            for (loop2 = 0; loop2 < arr2.Length; loop2++)
            {
                addStatic.Invoke(request.ServerVariables, new string[] { arr1[loop1], arr2[loop2].Replace(currentHostName, "localhost") });
            }
        }

        makeReadOnly.Invoke(request.ServerVariables, null);
        return request;
    }


}

