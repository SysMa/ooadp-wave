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

        public ActionResult LogOut()
        {
            Session.Clear();
            return RedirectToAction("Main", "Main");
        }

        public ActionResult Index()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 1)
            {
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
                return RedirectToAction("Main", "Main");
            }

            try
            {
                var account = (from m in _db.Users
                               where m.username == id
                               select m).First();
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
                return RedirectToAction("Main", "Main");
            }
            try
            {
                var account = (from m in _db.Users
                               where m.username == id
                               select m).First();
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
                return RedirectToAction("Main", "Main");
            }

            try
            {
                var account = (from m in _db.Users
                               where m.username == id
                               select m).First();
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
                return RedirectToAction("Main", "Main");
            }

            try
            {
                var org = (from m in _db.Org
                           where m.orgname == id
                           select m).First();
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
                return RedirectToAction("Main", "Main");
            }
            try
            {
                var account = (from m in _db.Org
                               where m.orgname == id
                               select m).First();
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
                return RedirectToAction("OrgDetail", new { id = orgToEdit.orgname });
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
                return RedirectToAction("Main", "Main");
            }

            try
            {
                var account = (from m in _db.Org
                               where m.orgname == id
                               select m).First();
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

    }
}
