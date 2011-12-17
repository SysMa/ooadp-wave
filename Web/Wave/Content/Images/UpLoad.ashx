<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Web;
using System.IO;
using Wave.Models;

public class Upload : IHttpHandler {

    private WaveWebEntities _db = new WaveWebEntities();
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Expires = -1;
        try
        {
            HttpPostedFile postedFile = context.Request.Files["Filedata"];
            
            string savepath = "";
            string tempPath = "";
            string actid = context.Request.QueryString["actid"];
            
            tempPath = System.Configuration.ConfigurationManager.AppSettings["FolderPath"]; 
            savepath = context.Server.MapPath(tempPath);
            savepath += "\\ActivityImages\\";
            savepath += "Activity_" + actid;
             
            if (!Directory.Exists(savepath))
                Directory.CreateDirectory(savepath);

            int id = int.Parse(actid);
            var pics = (from 
            string filename = postedFile.FileName;
            
            // name the file and folder Using Session
            filename = "User_lhb.jpg";
            postedFile.SaveAs(savepath + @"\" + filename);
            context.Response.Write(tempPath + "/" + filename);
            context.Response.StatusCode = 200;
        }
        catch (Exception ex)
        {
            context.Response.Write("Error: " + ex.Message);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}