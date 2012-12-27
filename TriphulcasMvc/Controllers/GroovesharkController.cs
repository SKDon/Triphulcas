using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Net;
using System.Web.Script.Serialization;

using System.Runtime.Remoting.Metadata.W3cXsd2001;
using Newtonsoft.Json.Serialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using umbraco.cms.businesslogic.web;


namespace TriphulcasMvc.Controllers
{
    public class GroovesharkController : Controller
    {
        private string user = "carmelo_player";
        private string secret = "b822a5bcda127fef6a58464205cdf840";
        private string api_host = "api.grooveshark.com/ws3.php";

        //
        // GET: /Grooveshark/
        [HttpGet]
        public ActionResult PlaySong(string songId)
        {
            if (GrooveSharkSessionId != null)
            {
                apiCall("startSession", Json(new { }), true, false);

                apiCall("getStreamKeyStreamServer", Json(new { songId = songId, country = GrooveSharkCountry, sessionID = GrooveSharkSessionId, lowBitrate = 0 }), false, true);
            }

            return Json("", JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetPlayList()
        {
            //List<String> temasId = new List<string>();
            //Document[] temas = GetTemasInGramola();
            //foreach (var tema in temas)
            //    temasId.Add(tema.getProperty("songID").Value.ToString());

            //return Json(temasId.ToArray<string>(), JsonRequestBehavior.AllowGet);

            //do the loading "Tema" content nodes stuff here
            return Json(new[] { "392740", "327326", "31030824" }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult Search(string term)
        {
            string message = @"<span class=""text"">
                    <span class=""strong"">Aquí tienes algunos resultados.</span>
                </span>";
            string tpl = @"<div class=""result_wrapper"" id=""result_wrapper"">{0}</div>";
//                <div id=""more_results"" class=""more_results"">
//                    <span><img src=""/img/results_more.png"" class=""png"">Más resultados</span>
//                </div>";
            string hitTpl = @"<ul class=""result"" rel=""{0}-search"">
	                <li class="""">
		                <div class=""sharesong"">
                            <span class=""button""></span>
                        </div>
        
		                <div class=""play"" id=""sr-{0}"" rel=""{0}"">
                            <span class=""button""></span>
                        </div>
		
		                <div class=""track"">
			                <ul>
				                <li class=""song"">{1}</li>
				                <li class=""artist"">{2}</li>
			                </ul>
		                </div>
		
		                <div class=""clear""></div>
	                </li>
                </ul>";
            string response = String.Empty;
            var url = String.Format("http://tinysong.com/s/{0}?format=json&limit=3&key=8d6c16b64219fb47cbc76ef54665662d", term);
            HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";

            try
            {
                var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    response = streamReader.ReadToEnd();
                }
            }
            catch (WebException e)
            {
            }

            //var json = Json(response);
            StringBuilder sb = new StringBuilder();
            var array = JArray.Parse(response);
            foreach (dynamic element in array)
            {
                sb.Append(string.Format(hitTpl, element.SongID, element.SongName, element.ArtistName));
            }


            return Json(new { message = message, html = String.Format(tpl, sb.ToString()), extraParams = new object() }, JsonRequestBehavior.AllowGet);
        }

        private Document[] GetTemasInGramola()
        {
            return Document.GetDocumentsOfDocumentType(DocumentType.GetByAlias("Tema").Id).OfType<Document>().OrderByDescending(d => d.UpdateDate).ToArray<Document>();
        }

        private string apiCall(string method, JsonResult parameters, bool https = false, bool hasParams = true)
        {
            string response = String.Empty;
            var payload = GetPayload(method, parameters, hasParams);
            string serializedPayload = new JavaScriptSerializer().Serialize(payload.Data);
            var sig = CreateMessageSig(serializedPayload, secret);
            var url = String.Format("{0}://{1}?sig={2}", https ? "https" : "http", api_host, sig);
            HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "POST";

            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                streamWriter.Write(serializedPayload);
                streamWriter.Close();
            }

            try
            {
                var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    response = streamReader.ReadToEnd();
                    //Dictionary<string,object>  retval = JsonFx.Json.JsonReader.Deserialize<Dictionary<string,object>>(response);

                    //return retval;
                }
            }
            catch (WebException e)
            {
            }

            return response;

        }

        private JsonResult GetPayload(string method, JsonResult parameters, bool hasParams = true)
        {
            if (hasParams)
                return Json(new { method = method, parameters = parameters.Data, header = (GrooveSharkSessionId != null && method != "startSession" ? (object)new { wsKey = user, sessionID = GrooveSharkSessionId } : new { wsKey = user }) });
            else
                return Json(new { method = method, parameters = new object[] { }, header = (GrooveSharkSessionId != null && method != "startSession" ? (object)new { wsKey = user, sessionID = GrooveSharkSessionId } : new { wsKey = user }) });
        }


        private string CreateMessageSig(string payloadJsonEncoded, string secret)
        {
            return ByteArrayToString(new HMACMD5(StringToByteArray(secret)).ComputeHash(new MemoryStream(System.Text.Encoding.UTF8.GetBytes(payloadJsonEncoded))));
        }

        private string ByteArrayToString(byte[] ba)
        {
            string hex = BitConverter.ToString(ba);
            return hex.Replace("-", "");
        }

        //public byte[] StringToByteArray(String hex)
        //{
        //    return JsonConvert.DeserializeObject<byte[]>(hex);
        //}

        public byte[] StringToByteArray(String hex)
        {
            int numberchars = hex.Length;
            byte[] bytes = new byte[numberchars / 2];
            for (int i = 0; i < numberchars; i += 2)
                bytes[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
            return bytes;
        }

        //public byte[] StringToByteArray(string value)
        //{
        //    SoapHexBinary shb = SoapHexBinary.Parse(value);
        //    return shb.Value;
        //}

        //public string ByteArrayToString(byte[] value)
        //{
        //    SoapHexBinary shb = new SoapHexBinary(value);
        //    return shb.ToString();
        //}

        public string GrooveSharkSessionId
        {
            get
            {
                if (Session["GrooveSharkSessionId"] == null)
                    Session["GrooveSharkSessionId"] = Request["ASP.NET_SessionId"];

                return (string)Session["GrooveSharkSessionId"];
            }
        }

        public string GrooveSharkCountry
        {
            get
            {
                if (Session["GrooveSharkCountry"] == null)
                {
                    apiCall("getCountry", Json(new object { }), false, false);
                }
                return (string)Session["GrooveSharkCountry"];
            }
        }

    }
}
