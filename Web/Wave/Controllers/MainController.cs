using System;
using System.Linq;
using System.Web.Mvc;
using Wave.Helper;
using Wave.Models;

namespace Wave.Controllers
{
    public class MainController : Controller
    {
        private WaveWebEntities _db = new WaveWebEntities();

        public ActionResult Main()
        {
            try
            {
                var activities = (from m in _db.Activity
                                  where m.actstate == 1
                                  select m);
                ViewData["actList"] = activities.ToArray();
                ViewData["orgList"] = _db.Org.ToArray();
                return View();
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return View();
            }
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
                                string key = account.First().supname;
                                while (key.Length < 8)
                                {
                                    key = key + key;
                                }
                                if (DESCode.DecryptDES(account.First().spasswd, key) != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
                                    Session["waveAccount"] = toCheck.account;
                                    Session["waveType"] = toCheck.type;
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
                                string key = account.First().adminname;
                                while (key.Length < 8)
                                {
                                    key = key + key;
                                }
                                if (DESCode.DecryptDES(account.First().apasswd, key) != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
                                    Session["waveAccount"] = toCheck.account;
                                    Session["waveType"] = toCheck.type;
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
                                string key = account.First().orgname;
                                while (key.Length < 8)
                                {
                                    key = key + key;
                                }
                                if (DESCode.DecryptDES(account.First().opasswd, key) != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
                                    if (account.First().ostate == -1)
                                    {
                                        account.First().ostate = 0;
                                        _db.ApplyCurrentValues<Org>(account.First().EntityKey.EntitySetName, account.First());
                                        _db.SaveChanges();
                                    }

                                    Session["waveAccount"] = toCheck.account;
                                    Session["waveType"] = toCheck.type;
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
                                string key = account.First().username;
                                while (key.Length < 8)
                                {
                                    key = key + key;
                                }
                                if ( DESCode.DecryptDES(account.First().upasswd, key) != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else if (account.First().ustate == 0)
                                {
                                    TempData["WarningMessage"] = "Your need to active your account.";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
                                    Session["waveAccount"] = toCheck.account;
                                    Session["waveType"] = toCheck.type;

                                    if (account.First().ustate == -1)
                                    {
                                        account.First().ustate = 1;
                                        _db.ApplyCurrentValues<Users>(account.First().EntityKey.EntitySetName, account.First());
                                        _db.SaveChanges();
                                    }
                                    return Redirect(Request.UrlReferrer.ToString());
                                }
                            }
                        }
                        break;
                    default:
                        return View();
                        break;
                }
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Login has failed because: " + exception.Message;
                return RedirectToAction("Main");
            }
        }

        public ActionResult Register()
        {
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Register(Users userToCreate)
        {
            if (!ModelState.IsValid)
                return View();

            try
            {
                var users = (from m in _db.Users
                                where m.username == userToCreate.username
                                select m);

                if (users.Count() != 0)
                {
                    TempData["ErrorMessage"] = "User name exists! ";
                    return View();
                }
                if (userToCreate.upasswd != Request.Form["ConfirmPassword"])
                {
                    TempData["ErrorMessage"] = "Registration failed! Your passwords must match, please re-enter and try again.";
                    return View();
                }

                try
                {
                    string content = System.IO.File.ReadAllText(Server.MapPath("~/NewMemberEmail.txt"));
                    content = content.Replace("[Name]", userToCreate.username);
                    content = content.Replace("[LINK]", "<a href='http://" + Request.Url.Host + ":" + Request.Url.Port + "/User/Activation-" + Server.UrlEncode(userToCreate.username) + "-" + MD5Code.getMd5Hash(userToCreate.username) + "'>^_^Active^_^</a>");
                    content = content.Replace("[UserName]", userToCreate.username);
                    content = content.Replace("[Pwd]", userToCreate.upasswd);

                    if (!SendMail.send(userToCreate.uemail, content,Server, "Active"))
                    {
                        TempData["ErrorMessage"] = "Sorry. The format of your email address can't be recognized.";
                        return View();
                    };
                }
                catch(Exception ex)
                {
                    TempData["ErrorMessage"] = "Registration failed! Check your email again please." + ex.Message;
                    return View();
                }

                try
                {
                    string key = userToCreate.username;
                    while (key.Length < 8)
                    {
                        key = key + key;
                    }
                    userToCreate.upasswd = DESCode.EncryptDES(userToCreate.upasswd, key);
                    _db.AddToUsers(userToCreate);
                    _db.SaveChanges();
                    TempData["SuccessMessage"] = "Registration succeeds! Your can log in using the new username and password.";
                }
                catch (Exception ex)
                {
                    TempData["ErrorMessage"] = "The databse is unreachable. Try again later." + ex.Message;
                    return View();
                }
                
                return RedirectToAction("Main");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Registration has failed because: " + exception.Message;
                return View();
            }
        }

        public ActionResult OrgDetails(string id)
        {
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
                ViewData["org"] = org;
                return View();
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("Main");
            }
        }

        public ActionResult ViewActivities(string id)
        {
            try
            {
                var org = (from m in _db.Org
                           where m.orgname == id
                           select m).First();

                ViewData["holding_acts"] = (from m in org.Activity
                                            where m.actstate == 1
                                            select m).ToArray();
                ViewData["stoped_acts"] = (from m in org.Activity
                                           where m.actstate == 2
                                           select m).ToArray();
                return View();
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("Main");
            }
        }

        public ActionResult ForgotPassword()
        {
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ForgotPassword(LoginModel toCheck)
        {
            try
            {
                switch (toCheck.type)
                {
                    case 0:
                        {
                            TempData["WarningMessage"] = "I am sorry. But I can' help.";
                        }
                        break;
                    case 1:
                        {
                            TempData["WarningMessage"] = "I am sorry. Ask for your manager.";
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
                            }
                            else
                            {
                                try
                                {
                                    string content = "Your Password is " + account.First().opasswd;

                                    if (!SendMail.send(account.First().oemail, content, Server, "Default"))
                                    {
                                        TempData["ErrorMessage"] = "Encounter error while trying to send your password to your email..";
                                    };

                                    TempData["SuccessMessage"] = "An Email has been sent to you. Check it.";
                                }
                                catch (Exception ex)
                                {
                                    TempData["ErrorMessage"] = "Encounter error while trying to send your password to your email.." + ex.Message;
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
                            }
                            else
                            {
                                try
                                {
                                    string content = "Your Password is " + account.First().upasswd;

                                    if (!SendMail.send(account.First().uemail, content, Server, "Default"))
                                    {
                                        TempData["ErrorMessage"] = "Encounter error while trying to send your password to your email..";
                                    };

                                    TempData["SuccessMessage"] = "An Email has been sent to you. Check it.";
                                }
                                catch (Exception ex)
                                {
                                    TempData["ErrorMessage"] = "Encounter error while trying to send your password to your email.." + ex.Message;
                                }
                            }
                        }
                        break;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Encounter error." + ex.Message;
            }
            return RedirectToAction("Main");
        }

        public ActionResult Search(string searchKey)
        {
            int type = -1;
            string username = "1";
            if (Session["waveType"] != null)
            {
                type = (int)Session["waveType"];
            }
            if (Session["waveAccount"] != null)
            {
                username = (string)Session["waveAccount"];
            }

            if (Session["waveType"] != null)
            {
                if ((int)Session["waveType"] == 1 || (int)Session["waveType"] == 0 || (int)Session["waveType"] == 2)
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }
            }

            try
            {
                var acts = (from m in _db.Activity.Where(a => a.actstate == 1)
                            where m.actname.Contains(searchKey)
                            select m);

                var orgs = (from m in _db.Org.Where(o => o.ostate == 0)
                            where m.orgname.Contains(searchKey)
                            select m);

                ViewData["actList"] = acts.ToArray();
                ViewData["orgList"] = orgs.ToArray();
                ViewData["searchKey"] = searchKey;

                return View("Main");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("Main");
            }
        }
    }
}
