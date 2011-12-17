<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Web;
using System.IO;
using System.Linq;
using Wave.Models;

public class Upload : IHttpHandler
{

    private WaveWebEntities _db = new WaveWebEntities();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Expires = -1;
        try
        {
            HttpPostedFile postedFile = context.Request.Files["Filedata"];

            string savepath = "";
            string tempPath = "";
            string actid = context.Request.QueryString["actid"];

            tempPath = "~/Content/Images/ActivityImages";
            savepath = context.Server.MapPath(tempPath);
            savepath += "\\Activity_" + actid;

            if (!Directory.Exists(savepath))
                Directory.CreateDirectory(savepath);

            int id = int.Parse(actid);

            string filename = System.DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss") +  "_" + postedFile.FileName;

            postedFile.SaveAs(savepath + @"\" + filename);

            Images images = _db.CreateObject<Images>();
            images.actid = id;
            images.pic = filename;
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

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
