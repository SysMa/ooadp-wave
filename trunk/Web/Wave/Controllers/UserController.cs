using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;
using System.Drawing;
using System.IO;

namespace Wave.Controllers
{
    public class UserController : Controller
    {
        private WaveWebEntities _db = new WaveWebEntities();

        public ActionResult LogOut()
        {
            Session.Clear();
            return RedirectToAction("Main", "Main");
        }

        //
        // GET: /User/ChangePwd/
        public ActionResult ChangePwd()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 3)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View();
        }

        //
        // POST: /User/ChangePwd/

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangePwd(ChangePwdModel passwordToChange)
        {
            if (!ModelState.IsValid)
                return View();
            string user = Session["waveAccount"].ToString();
            var account = (from m in _db.Users
                           where m.username == user
                           select m).First();

            if (account.upasswd != passwordToChange.original)
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
                account.upasswd = passwordToChange.password;

                try
                {
                    _db.ApplyCurrentValues<Users>(account.EntityKey.EntitySetName, account);
                    _db.SaveChanges();
                    TempData["SuccessMessage"] = "Your password has been sucessfully changed.";
                    return RedirectToAction("Main", "Main");
                }
                catch (Exception exception)
                {
                    TempData["ErrorMessage"] = "Password change has failed because: " + exception.Message;
                    return View();
                }
            }
        }

        //
        // GET: /User/ChangeInfo/

        public ActionResult ChangeInfo()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 3)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            string user = Session["waveAccount"].ToString();
            try
            {
                var account = (from m in _db.Users
                               where m.username == user
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
                return RedirectToAction("Main", "Main");
            }
        }

        //
        // POST: /User/ChangeInfo/

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangeInfo(Users userToEdit)
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
               
                if (Request.Files["avater_path"].FileName != "")
                {
                    Request.Files["avater_path"].SaveAs(Server.MapPath("~/Content/Images/pics/User_" + userToEdit.username + ".jpg"));
                }
                TempData["SuccessMessage"] = "Infomation has been changed.";
                return RedirectToAction("Main", "Main");
            }
            catch (Exception exception)
            {
                String path = Server.MapPath("~/Content/Images/pics/User_" + originalUser.username);
                if (System.IO.File.Exists(path))
                {
                    ViewData["avater_path"] = "~/Content/Images/pics/User_" + originalUser.username;
                }
                else
                {
                    ViewData["avater_path"] = "~/Content/Images/noavater.gif";
                }
                TempData["ErrorMessage"] = "User change has failed because: " + exception.Message;
                return View(originalUser);
            }
        }

        //
        // GET: /User/ViewMyActivity/

        public ActionResult ViewMyActivity()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 3)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View();
        }
    }
}
