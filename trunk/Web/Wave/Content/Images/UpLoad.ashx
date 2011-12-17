<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Web;
using System.IO;
using System.Linq;
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
            var pics = (from m in _db.Images
                        where m.actid == id
                        select m);
            int picid = pics.Count() + 1;
            
            string filename = string.Format("{0:000}", picid) + ".jpg";
            
            postedFile.SaveAs(savepath + @"\" + filename);

            Images images = _db.CreateObject<Images>();
            images.actid = id;
            images.picid = picid;
            _db.AddToImages(images);
            _db.SaveChanges();
            
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