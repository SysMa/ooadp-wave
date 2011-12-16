using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;

namespace Wave.Controllers
{
    public class OrgController : Controller
    {
        private WaveWebEntities _db = new WaveWebEntities();

        //
        // GET: /Org/

        public ActionResult Index()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            string user = Session["waveAccount"].ToString();
            try
            {
                var account = (from m in _db.Org
                               where m.orgname == user
                               select m).First();
                ViewData["applied_acts"] = (from m in account.Activity
                                            where m.actstate == 0
                                            select m).ToArray();
                ViewData["holding_acts"] = (from m in account.Activity
                                            where m.actstate == 1
                                            select m).ToArray();
                ViewData["stoped_acts"] = (from m in account.Activity
                                           where m.actstate == 2
                                           select m).ToArray();
                return View();
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("Index");
            }
        }

        public ActionResult LogOut()
        {
            Session.Clear();
            return RedirectToAction("Main", "Main");
        }

        //
        // GET: /Org/ChangePwd/
        public ActionResult ChangePwd()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View();
        }

        //
        // POST: /Org/ChangePwd/

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangePwd(ChangePwdModel passwordToChange)
        {
            if (!ModelState.IsValid)
                return View();
            string user = Session["waveAccount"].ToString();
            var account = (from m in _db.Org
                           where m.orgname == user
                           select m).First();

            if (account.opasswd != passwordToChange.original)
            {
                TempData["ErrorMessage"] = "Your original passwords do not match, please retype it and try again. ";
                return View();
            }
            else if (passwordToChange.password != passwordToChange.confirmPwd)
            {
                TempData["ErrorMessage"] = "Your new passwords do not match, please retype them and try again. ";
                return View();
            }
            else
            {
                account.opasswd = passwordToChange.password;

                try
                {
                    _db.ApplyCurrentValues<Org>(account.EntityKey.EntitySetName, account);
                    _db.SaveChanges();
                    TempData["SuccessMessage"] = "Your password has been sucessfully changed.";
                    return RedirectToAction("Index");
                }
                catch (Exception exception)
                {
                    TempData["ErrorMessage"] = "Password change has failed because: " + exception.Message;
                    return View();
                }
            }
        }

        //
        // GET: /Org/ChangeInfo/

        public ActionResult ChangeInfo()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            string user = Session["waveAccount"].ToString();
            try
            {
                var account = (from m in _db.Org
                               where m.orgname == user
                               select m).First();
                String path = Server.MapPath("~/Content/Images/pics/Org_" + account.orgname + ".jpg");
                if (System.IO.File.Exists(path))
                {
                    ViewData["avater_path"] = "~/Content/Images/pics/Org_" + account.orgname + ".jpg";
                }
                else
                {
                    ViewData["avater_path"] = "~/Content/Images/noavater.gif";
                }
                return View(account);
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("Index");
            }
        }

        //
        // POST: /Org/ChangeInfo/

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangeInfo(Org orgToEdit)
        {
            var originalOrg = (from m in _db.Org
                                where m.orgname == orgToEdit.orgname
                                select m).First();
            if (!ModelState.IsValid)
                return View(originalOrg);

            try
            {
                _db.ApplyCurrentValues<Org>(originalOrg.EntityKey.EntitySetName, orgToEdit);
                _db.SaveChanges();

                if (Request.Files["avater_path"].FileName != "")
                {
                    Request.Files["avater_path"].SaveAs(Server.MapPath("~/Content/Images/pics/Org_" + orgToEdit.orgname + ".jpg"));
                }
                TempData["SuccessMessage"] = "Infomation has been changed.";
                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                String path = Server.MapPath("~/Content/Images/pics/User_" + originalOrg.orgname);
                if (System.IO.File.Exists(path))
                {
                    ViewData["avater_path"] = "~/Content/Images/pics/Org_" + originalOrg.orgname + ".jpg";
                }
                else
                {
                    ViewData["avater_path"] = "~/Content/Images/noavater.gif";
                }
                TempData["ErrorMessage"] = "User change has failed because: " + exception.Message;
                return View(originalOrg);
            }
        }

        //
        // GET: /Org/ChooseStyle

        public ActionResult ChooseStyle()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View();
        }

        //
        // GET: /Org/ApplyActivities

        public ActionResult ApplyActivities(int pageid)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            ViewData["pageid"] = pageid;
            return View();
        } 

        //
        // POST: /Org/ApplyActivities

        [HttpPost]
        public ActionResult ApplyActivities(Activity activity)
        {
            if (!ModelState.IsValid)
                return View();
            string user = Session["waveAccount"].ToString();
            try
            {
                var account = (from m in _db.Org
                               where m.orgname == user
                               select m).First();
                activity.orgname = account.orgname;
                _db.AddToActivity(activity);
                _db.SaveChanges();
                if (Request.Files["avater_path"].FileName != "")
                {
                    Request.Files["avater_path"].SaveAs(Server.MapPath("~/Content/Images/pics/Activity_" + activity.actid + ".jpg"));
                }
                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Activity apply has failed because: " + exception.Message;
                return View();
            }
        }
        
        //
        // GET: /Org/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Org/Edit/5

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
        // GET: /Org/Delete/5
 
        public ActionResult DeleteActivity(int id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            String url = Request.QueryString["url"];
            String user = Session["waveAccount"] as String;
            try
            {
                var account = (from m in _db.Org
                               where m.orgname == user
                               select m).First();

                var activity = (from m in _db.Activity
                                where m.actid == id
                                select m).First();

                if (activity.orgname != account.orgname)
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }
                if (activity.actstate != 0)
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }
                _db.DeleteObject(activity);
                _db.SaveChanges();
                return Redirect(url);
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Activity Deletion has failed because: " + exception.Message;
                return Redirect(url);
            }
        }

        public ActionResult ParticipatorDetails(int id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            String user = Session["waveAccount"] as String;
            try
            {
                var account = (from m in _db.Org
                               where m.orgname == user
                               select m).First();

                var activity = (from m in _db.Activity
                                where m.actid == id
                                select m).First();

                if (activity.orgname != account.orgname)
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }
                if (activity.actstate == 0)
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }
                return View(activity.TakeActivity.ToList());
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return View();
            }
        }

        //
        // POST: /Org/Delete/5

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
