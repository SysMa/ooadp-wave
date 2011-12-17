using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;
using System.Drawing;
using System.IO;
using Wave.Helper;

namespace Wave.Controllers
{
    public class UserController : Controller
    {
        private WaveWebEntities _db = new WaveWebEntities();

        public ActionResult LogOut()
        {
            Session.Clear();
            return Redirect(Request.UrlReferrer.ToString());
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

                //String path = Request["hidden_path"];
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

            string user = Session["waveAccount"].ToString();
            try
            {
                var account = (from m in _db.Users
                               where m.username == user
                               select m).First();

                var activities = (from t in account.TakeActivity
                                  join m in _db.Activity
                                  on t.actid equals m.actid
                                  select m);
                ViewData["holding_acts"] = (from m in activities
                                            where m.actstate == 1
                                            select m).ToArray();
                ViewData["stoped_acts"] = (from m in activities
                                            where m.actstate == 2
                                            select m).ToArray();
                return View();
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("Main", "Main");
            }
        }

        /// <summary>
        /// 处理激活
        /// </summary>
        /// <param name="id">用户登录id</param>
        /// <param name="code">激活码</param>
        /// <returns></returns>
        public ActionResult Activation(string id, string code)
        {
            try
            {
                var users = (from m in _db.Users
                             where m.username == id
                             select m);

                if (users.Count() != 1)
                {
                    TempData["ErrorMessage"] = "Failed to Active";
                    return RedirectToAction("Main", "Main");
                }
                else if ( MD5Code.verifyMd5Hash(users.First().username, code) && users.First().ustate == 0)
                {
                    users.First().ustate = 1;
                    _db.ApplyCurrentValues<Users>(users.First().EntityKey.EntitySetName, users.First());
                    _db.SaveChanges();
                    TempData["SuccessMessage"] = "Active Successful";
                    return RedirectToAction("Main", "Main");
                }
                else if (MD5Code.verifyMd5Hash(users.First().username, code) && users.First().ustate != 0)
                {
                    TempData["WarningMessage"] = "You have already been actived. Keep an eye on your emails.";
                    return RedirectToAction("Main", "Main");
                }
                else
                {
                    TempData["ErrorMessage"] = "Time out. Sign up again, please.";
                    return RedirectToAction("Main", "Main");
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Failed to Active" + ex.Message;
                return RedirectToAction("Main", "Main");
            }
            TempData["ErrorMessage"] = "Failed to Active";
            return RedirectToAction("Main", "Main");
        }

        public ActionResult JoinActivity(int id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 3)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            string url = Request.UrlReferrer.ToString();
            string user = Session["waveAccount"].ToString();
            try
            {
                var account = (from m in _db.Users
                               where m.username == user
                               select m).First();

                var activity = (from m in _db.Activity
                                where m.actid == id
                                select m).First();

                if (activity.actstate != 1)
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }

                var temp = (from m in activity.TakeActivity
                            where m.username == user
                            select m);
                if (temp.Count() != 0)
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }

                TakeActivity ta = _db.CreateObject<TakeActivity>();
                ta.username = user;
                ta.actid = id;
                _db.TakeActivity.AddObject(ta);
                _db.SaveChanges();

                return RedirectToAction("ActivityDetails", "Activity", new { id = id, usertype = 3, username = user, url = url });
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("Main", "Main");
            }
        }

        [HttpPost]
        public ActionResult Rate(int id)
        {
            String username = Request.QueryString["username"];
            String url = Request.QueryString["url"];
            try
            {
                var activity = (from m in _db.Activity
                                where m.actid == id
                                select m).First();

                var temp = (from m in activity.TakeActivity
                            where m.username == username
                            select m).First();

                temp.orgscore = int.Parse(Request.Form["rate"]);

                _db.ApplyCurrentValues<TakeActivity>(temp.EntityKey.EntitySetName, temp);
                _db.SaveChanges();

                return RedirectToAction("ActivityDetails", "Activity", new { id = id, usertype = 3, username = username, url = url });
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return Redirect(url);
            }
        }
    }
}
