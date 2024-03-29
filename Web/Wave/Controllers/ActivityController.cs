﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;
using Wave.Helper;

namespace Wave.Controllers
{
    public class ActivityController : Controller
    {
        private Wave.Models.WaveWebEntities _db = new Models.WaveWebEntities();

        //
        // GET: /Activity/Details/5

        public ActionResult ActivityDetails(int id)
        {
            string type = Request.QueryString["usertype"];
            string username = Request.QueryString["username"];
            string url = Request.QueryString["url"];
            if (url == null)
            {
                url = Request.UrlReferrer.ToString();
            }
            try
            {
                var activity = (from m in _db.Activity
                               where m.actid == id
                               select m).First();

                if (type == "2")
                {
                    if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
                    {
                        Session.Clear();
                        return RedirectToAction("Main", "Main");
                    }

                    if (activity.orgname != username)
                    {
                        Session.Clear();
                        return RedirectToAction("Main", "Main");
                    }
                    if (activity.actstate == 0)
                    {
                        ViewData["state"] = "apply";
                    }
                    else
                    {
                        ViewData["state"] = "passed";
                        ViewData["part"] = activity.TakeActivity.ToArray();
                    }
                    ViewData["visitor"] = "org";
                }
                else if (type == "1")
                {
                    if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
                    {
                        Session.Clear();
                        return RedirectToAction("Main", "Main");
                    }

                    var review = (from m in activity.Admin
                                  where m.adminname == username
                                  select m);
                    if (review.Count() != 0)
                    {
                        ViewData["review"] = "true";
                    }
                    ViewData["visitor"] = "admin";
                }
                else if (type == "3" || type == "-1")
                {
                    var acts = (from m in
                                    (from m in _db.Activity
                                     where m.orgname == activity.orgname
                                     select m)
                                where m.actstate == 1
                                select m);

                    acts = (from m in acts
                            where m.actid != activity.actid
                            select m);

                    if (type == "-1")
                    {
                        ViewData["visitor"] = "guest";

                        ViewData["part"] = activity.TakeActivity.ToArray();
                    }
                    else
                    {
                        if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 3)
                        {
                            Session.Clear();
                            return RedirectToAction("Main", "Main");
                        }

                        var took = (from m in activity.TakeActivity
                                    where m.username == username
                                    select m);
                        if (took.Count() != 0)
                        {
                            ViewData["take"] = "true";
                            int rate = took.First().orgscore;
                            bool[] selected = { false, false, false, false, false };
                            if (rate != 0)
                            {
                                selected[rate - 1] = true;
                            }
                            else
                            {
                                selected[4] = true;
                            }
                            ViewData["selected"] = selected;
                        }

                        ViewData["visitor"] = "user";

                        var part = (from m in activity.TakeActivity
                                    where m.username != username
                                    select m);
                        ViewData["part"] = part.ToArray();
                    }

                    ViewData["oAct"] = acts.ToArray();
                    ViewData["type"] = type;
                    ViewData["username"] = username;
                }
                else
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }

                ViewData["returnUrl"] = url;

                String styleName = "Style";

                styleName += (activity.pageid + 1);

                var actpics = (from m in activity.Images.Where(i => i.picstate == 1)
                               select m.pic);

                ViewData["actpics"] = actpics.ToArray();

                return View(styleName, activity);
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return Redirect(url);
            }
        }

        //
        // GET: /Activity/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Activity/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /Activity/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Activity/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Activity/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Activity/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
