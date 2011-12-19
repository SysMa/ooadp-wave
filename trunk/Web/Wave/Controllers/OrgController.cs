using System;
using System.Linq;
using System.Web.Mvc;
using Wave.Models;
using Wave.Helper;

namespace Wave.Controllers
{
    public class OrgController : Controller
    {
        private WaveWebEntities _db = new WaveWebEntities();

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

        public ActionResult ChangePwd()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangePwd(ChangePwdModel passwordToChange)
        {
            if (!ModelState.IsValid)
                return View();
            string user = Session["waveAccount"].ToString();
            var account = (from m in _db.Org
                           where m.orgname == user
                           select m).First();

            string key = account.orgname;
            while (key.Length < 8)
            {
                key = key + key;
            }

            if ( DESCode.DecryptDES(account.opasswd, key) != passwordToChange.original)
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
                account.opasswd = DESCode.EncryptDES(passwordToChange.password, key);
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

        public ActionResult ChooseStyle()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            return View();
        }

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
                ViewData["activity"] = activity.actname;
                ViewData["id"] = activity.actid;
                return View(activity.TakeActivity.ToList());
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return View();
            }
        }

        //
        // GET: /Org/UserDetails/5

        public ActionResult UserDetails(int id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }

            String user = Session["waveAccount"] as String;
            String username = Request.QueryString["username"];
            try
            {
                var activity = (from m in _db.Activity
                                where m.actid == id
                                select m).First();
                if (activity.orgname != user || activity.actstate == 0)
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }

                var temp = (from m in activity.TakeActivity
                            where m.username == username
                            select m);
                if (temp.Count() == 0)
                {
                    Session.Clear();
                    return RedirectToAction("Main", "Main");
                }
                int rate = temp.First().userscore;
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

                var account = (from m in _db.Users
                               where m.username == username
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
                ViewData["act_state"] = activity.actstate;
                ViewData["id"] = id;
                return View(account);
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("Index");
            }
        }

        [HttpPost]
        public ActionResult Rate(int id)
        {
            String username = Request.QueryString["username"];
            try
            {
                var activity = (from m in _db.Activity
                                where m.actid == id
                                select m).First();

                var temp = (from m in activity.TakeActivity
                            where m.username == username
                            select m).First();

                temp.userscore = int.Parse(Request.Form["rate"]);

                _db.ApplyCurrentValues<TakeActivity>(temp.EntityKey.EntitySetName, temp);
                _db.SaveChanges();

                return RedirectToAction("ParticipatorDetails", new { id = id });
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Database has failed because: " + exception.Message;
                return RedirectToAction("UserDetails", new { id=id, username = username });
            }
        }

        public ActionResult Pick(int id)
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
                var imgs = (from m in _db.Images
                                where m.actid == id
                                select m);

                ViewData["imgs"] = imgs.ToArray();
                ViewData["actid"] = id;
                ViewData["url"] = url;
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Activity Deletion has failed because: " + exception.Message;
                return Redirect(url);
            }
            return View();
        }

        [HttpPost]
        public ActionResult Toogle(FormCollection post)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            int actid = int.Parse(Request.QueryString["actid"]);
            String pic = Request.QueryString["pic"];
            String url = Request.QueryString["url"];
            String change = "";

            var img = (from m in _db.Images
                       where m.actid == actid
                       where m.pic == pic
                       select m).First();
            try
            {
                if (img.picstate == 1)
                {
                    img.picstate = 0;
                    _db.ApplyCurrentValues<Images>(img.EntityKey.EntitySetName, img);
                    _db.SaveChanges();
                    change = "<input type='submit' value='Choose it.'/>";
                }
                else
                {
                    img.picstate = 1;
                    _db.ApplyCurrentValues<Images>(img.EntityKey.EntitySetName, img);
                    _db.SaveChanges();
                    change = "<input type='submit' value='Remove it.' />";
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Error happened while updating." + ex.Message;
                return RedirectToAction("Pick", new { id = actid, url = url });
            }
            return Content(change);
        }
        /*
        public ActionResult Removepics()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 2)
            {
                Session.Clear();
                return RedirectToAction("Main", "Main");
            }
            int actid = int.Parse(Request.QueryString["actid"]);
            String pic = Request.QueryString["pic"];
            String url = Request.QueryString["url"];

            var img = (from m in _db.Images
                       where m.actid == actid
                       where m.pic == pic
                       select m).First();

            img.picstate = 0;
            _db.ApplyCurrentValues<Images>(img.EntityKey.EntitySetName, img);
            _db.SaveChanges();
            return RedirectToAction("Pick", new { id = actid, url = url });
        }
        */
    }
}
