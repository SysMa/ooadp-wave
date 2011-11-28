using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;

namespace Wave.Controllers
{
    public class MainController : Controller
    {
        //
        // GET: /Default1/
        private WaveWebEntities _db = new WaveWebEntities();

        public ActionResult Main()
        {
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Login(LoginModel toCheck)
        {
            if (!ModelState.IsValid)
                return RedirectToAction("Main");
            try
            {
                switch (toCheck.type)
                {
                    case 0:
                        {
                            var account = (from m in _db.SuperAdmin
                                           where m.supname == toCheck.account
                                           select m);
                            if (account.Count() == 0)
                            {
                                TempData["ErrorMessage"] = "Check your account, please! ";
                                return RedirectToAction("Main");
                            }
                            else
                            {
                                if (account.First().spasswd != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
                                    Session["account"] = toCheck.account;
                                    Session["type"] = toCheck.type;
                                    //return View("../SuperAdmin/Index", _db.Admin.ToList());
                                    return RedirectToAction("Index", "SuperAdmin");
                                }
                            }
                        }
                        break;
                    case 1:
                        {
                            var account = (from m in _db.Admin
                                           where m.adminname == toCheck.account
                                           select m);
                            if (account.Count() == 0)
                            {
                                TempData["ErrorMessage"] = "Check your account, please! ";
                                return RedirectToAction("Main");
                            }
                            else
                            {
                                if (account.First().apasswd != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
                                    Session["account"] = toCheck.account;
                                    Session["type"] = toCheck.type;
                                    //return View("../SuperAdmin/Index", _db.Admin.ToList());
                                    return RedirectToAction("Index", "Admin");
                                }
                            }
                        }
                        break;
                    case 2:
                        {
                            var account = (from m in _db.Org
                                           where m.orgname == toCheck.account
                                           select m);
                            if (account.Count() == 0)
                            {
                                TempData["ErrorMessage"] = "Check your account, please! ";
                                return RedirectToAction("Main");
                            }
                            else
                            {
                                if (account.First().opasswd != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
                                    Session["account"] = toCheck.account;
                                    Session["type"] = toCheck.type;
                                    //return View("../SuperAdmin/Index", _db.Admin.ToList());
                                    return RedirectToAction("Index", "Org");
                                }
                            }
                        }
                        break;
                    case 3:
                        {
                            var account = (from m in _db.Users
                                           where m.username == toCheck.account
                                           select m);
                            if (account.Count() == 0)
                            {
                                TempData["ErrorMessage"] = "Check your account, please! ";
                                return RedirectToAction("Main");
                            }
                            else
                            {
                                if (account.First().upasswd != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
                                    Session["account"] = toCheck.account;
                                    Session["type"] = toCheck.type;
                                    //return View("../SuperAdmin/Index", _db.Admin.ToList());
                                    return RedirectToAction("Index", "User");
                                }
                            }
                        }
                        break;
                    default:
                        return View();
                        break;
                }
            }
            catch
            {
                TempData["ErrorMessage"] = "Database failed! ";
                return RedirectToAction("Main");
            }
        }

        //
        // GET: /SuperAdmin/Create

        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /SuperAdmin/Create

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Register(Users userToCreate)
        {
            if (!ModelState.IsValid)
                return View();

            try
            {
                _db.AddToUsers(userToCreate);
                _db.SaveChanges();
                return RedirectToAction("Main");
            }
            catch
            {
                TempData["ErrorMessage"] = "Register failed! ";
                return View();
            }
        }
    }
}
