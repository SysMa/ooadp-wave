using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;

namespace Wave.Controllers
{
    public class AdminController : Controller
    {
        //
        // GET: /Admin/
        private Wave.Models.WaveWebEntities _db = new Models.WaveWebEntities();

        //
        // GET: /Admin/ChangeInfo/5

        public ActionResult ChangeInfo()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            String id = Session["waveAccount"].ToString();

            var adminToEdit = (from m in _db.Admin
                               where m.adminname == id
                               select m).First();

            return View(adminToEdit);
        }

        //
        // POST: /Admin/ChangeInfo/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangeInfo(Admin adminToEdit)
        {
            var originalAdmin = (from m in _db.Admin
                                 where m.adminname == adminToEdit.adminname
                                 select m).First();
            if (!ModelState.IsValid)
                return View(originalAdmin);

            try
            {
                _db.ApplyCurrentValues<Admin>(originalAdmin.EntityKey.EntitySetName, adminToEdit);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Infomation has been changed.";
                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Information change has failed because: " + exception.Message;
                return View(originalAdmin);
            }
        }

        //
        // GET: /Admin/ChangePwd/
        public ActionResult ChangePwd()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View();
        }

        //
        // POST: /Admin/ChangePwd/

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangePwd(ChangePwdModel passwordToChange)
        {
            if (!ModelState.IsValid)
                return View();
            string user = Session["waveAccount"].ToString();
            var account = (from m in _db.Admin
                           where m.adminname == user
                           select m).First();

            if (account.apasswd != passwordToChange.original)
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
                account.apasswd = passwordToChange.password;

                try
                {
                    _db.ApplyCurrentValues<Admin>(account.EntityKey.EntitySetName, account);
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

        public ActionResult ReviewActivities()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            try
            {
                var activities = (from m in _db.Activity
                                  where m.actstate == 0
                                  select m);
                return View(activities.ToList());
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

        public ActionResult Index()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View(_db.Users.ToList());
        }

        //
        // GET: /Admin/UserDetails/5

        public ActionResult UserDetails(string id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            try
            {
                var account = (from m in _db.Users
                               where m.username == id
                               select m).First();
                String path = Server.MapPath("~/Content/Images/pics/User_" + account.username + ".jpg");
                if (System.IO.File.Exists(path))
                {
                    ViewData["avater_path"] = "~/Content/Images/pics/User_" + account.username + ".jpg";
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
        // GET: /Admin/CreateUser

        public ActionResult CreateUser()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View();
        } 

        //
        // POST: /Admin/CreateUser

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CreateUser(Users userToCreate)
        {
            if (!ModelState.IsValid)
                return View();

            try
            {
                var user = (from m in _db.Users
                             where m.username == userToCreate.username
                             select m);

                if (user.Count() != 0)
                {
                    TempData["ErrorMessage"] = "User name exists! ";
                    return View();
                }
                if (userToCreate.upasswd != Request.Form["ConfirmPassword"])
                {
                    TempData["ErrorMessage"] = "User creation failed! Passwords must match, please re-enter and try again.";
                    return View();
                }
                _db.AddToUsers(userToCreate);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "User creation succeeds!";
                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "User creation has failed because: " + exception.Message;
                return View();
            }
        }
        
        //
        // GET: /Admin/EditUser/5
 
        public ActionResult EditUser(string id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            try
            {
                var account = (from m in _db.Users
                               where m.username == id
                               select m).First();
                String path = Server.MapPath("~/Content/Images/pics/User_" + account.username + ".jpg");
                if (System.IO.File.Exists(path))
                {
                    ViewData["avater_path"] = "~/Content/Images/pics/User_" + account.username + ".jpg";
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
        // POST: /Admin/EditUser/5

        [HttpPost]
        public ActionResult EditUser(Users userToEdit)
        {
            var originalUser = (from m in _db.Users
                                where m.username == userToEdit.username
                                select m).First();
            if (!ModelState.IsValid)
                return View(originalUser);

            try
            {
                _db.ApplyCurrentValues<Users>(originalUser.EntityKey.EntitySetName, userToEdit);
                _db.SaveChanges();
                return RedirectToAction("UserDetails", new { id = userToEdit.username });
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "User change has failed because: " + exception.Message;
                return View(originalUser);
            }
        }

        //
        // GET: /Admin/DeleteUser/5
 
        public ActionResult DeleteUser(string id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            try
            {
                var account = (from m in _db.Users
                               where m.username == id
                               select m).First();
                String path = Server.MapPath("~/Content/Images/pics/User_" + account.username + ".jpg");
                if (System.IO.File.Exists(path))
                {
                    ViewData["avater_path"] = "~/Content/Images/pics/User_" + account.username + ".jpg";
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
        // POST: /Admin/DeleteUser/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DeleteUser(string id, Users user)
        {
            var userToDelete = (from m in _db.Users
                        where m.username == id
                        select m).First();

            if (!ModelState.IsValid)
                return View(userToDelete);

            try
            {
                _db.DeleteObject(userToDelete);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Deletion has failed because: " + exception.Message;
                return View(userToDelete);
            }
        }

        public ActionResult Orgs()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View(_db.Org.ToList());
        }

        //
        // GET: /Admin/OrgDetails/5

        public ActionResult OrgDetails(string id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            try
            {
                var org = (from m in _db.Org
                           where m.orgname == id
                           select m).First();
                String path = Server.MapPath("~/Content/Images/pics/Org_" + org.orgname + ".jpg");
                if (System.IO.File.Exists(path))
                {
                    ViewData["avater_path"] = "~/Content/Images/pics/Org_" + org.orgname + ".jpg";
                }
                else
                {
                    ViewData["avater_path"] = "~/Content/Images/noavater.gif";
                }
                return View(org);
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("Orgs");
            }
        }

        //
        // GET: /Admin/CreateOrg

        public ActionResult CreateOrg()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View();
        }

        //
        // POST: /Admin/CreateOrg

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CreateOrg(Org orgToCreate)
        {
            if (!ModelState.IsValid)
                return View();

            try
            {
                var org = (from m in _db.Org
                             where m.orgname == orgToCreate.orgname
                             select m);

                if (org.Count() != 0)
                {
                    TempData["ErrorMessage"] = "Org name exists! ";
                    return View();
                }
                if (orgToCreate.opasswd != Request.Form["ConfirmPassword"])
                {
                    TempData["ErrorMessage"] = "Org creation failed! Passwords must match, please re-enter and try again.";
                    return View();
                }
                _db.AddToOrg(orgToCreate);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Org creation succeeds!";
                return RedirectToAction("Orgs");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Org creation has failed because: " + exception.Message;
                return View();
            }
        }

        //
        // GET: /Admin/EditOrg/5

        public ActionResult EditOrg(string id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            try
            {
                var account = (from m in _db.Org
                               where m.orgname == id
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
                return RedirectToAction("Orgs");
            }
        }

        //
        // POST: /Admin/EditOrg/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult EditOrg(Org orgToEdit)
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
                return RedirectToAction("OrgDetails", new { id = orgToEdit.orgname });
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Org change has failed because: " + exception.Message;
                return View(originalOrg);
            }
        }

        //
        // GET: /Admin/DeleteOrg/5

        public ActionResult DeleteOrg(string id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            try
            {
                var account = (from m in _db.Org
                               where m.orgname == id
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
                return RedirectToAction("Orgs");
            }
        }

        //
        // POST: /Admin/DeleteOrg/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DeleteOrg(String id, Org org)
        {
            var orgToDelete = (from m in _db.Org
                       where m.orgname == id
                       select m).First();

            if (!ModelState.IsValid)
                return View(orgToDelete);

            try
            {
                _db.DeleteObject(orgToDelete);
                _db.SaveChanges();
                return RedirectToAction("Orgs");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Deletion has failed because: " + exception.Message;
                return View(orgToDelete);
            }
        }

        public ActionResult PassActivity(int id)
        {
            String url = Request.QueryString["url"];

            try
            {
                String username = Session["waveAccount"] as String;

                var admin = (from m in _db.Admin
                             where m.adminname == username
                             select m).First();

                var activity = (from m in _db.Activity
                                where m.actid == id
                                select m).First();

                activity.Admin.Add(admin);
                if (activity.Admin.Count() >= _db.Admin.Count())
                {
                    activity.actstate = 1;
                }

                _db.ApplyCurrentValues<Activity>(activity.EntityKey.EntitySetName, activity);
                _db.SaveChanges();
                return RedirectToAction("Orgs");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Activity review has failed because: " + exception.Message;
                return Redirect(url);
            }
        }
    }
}
