using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Wave.Controllers
{
    public class ActivityController : Controller
    {
        private Wave.Models.WaveWebEntities _db = new Models.WaveWebEntities();

        //
        // GET: /Activity/

        public ActionResult Index()
        {
            return View(_db.Activity.ToList());
        }

        //
        // GET: /Activity/Details/5

        public ActionResult ActivityDetails(int id)
        {
            string type = Request.QueryString["type"];
            string username = Request.QueryString["username"];
            try
            {
                var activity = (from m in _db.Activity
                               where m.actid == id
                               select m).First();
                if (type == "2")
                {
                    if (activity.orgname != username)
                    {
                        Session.Clear();
                        return RedirectToAction("Main", "Main");
                    }
                }
                else if (type == "1")
                {
                }
                else if (type == "3")
                {
                }
                else if (type == "-1")
                {
                }
                return View(activity);
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return View();
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
