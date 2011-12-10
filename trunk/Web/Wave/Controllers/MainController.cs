using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Text.RegularExpressions;

namespace Wave.Controllers
{
    public class MainController : Controller
    {
        private WaveWebEntities _db = new WaveWebEntities();

        //
        // GET: /Default1/

        public ActionResult Main()
        {
            var activities = (from m in _db.Activity
                              where m.actstate == 1
                              select m);
            ViewData["actList"] = activities.ToArray();
            ViewData["orgList"] = _db.Org.ToArray();
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
                                if (account.First().apasswd != toCheck.password)
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
                                if (account.First().opasswd != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
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
                                if (account.First().upasswd != toCheck.password)
                                {
                                    TempData["ErrorMessage"] = "Check your password, please! ";
                                    return RedirectToAction("Main");
                                }
                                else
                                {
                                    Session["waveAccount"] = toCheck.account;
                                    Session["waveType"] = toCheck.type;
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

                string regexEmail = @"^\w+([-+.]?\w+)*@\w+([-.]?\w+)*\.\w+([-.]?\w+)*$ ";
                System.Text.RegularExpressions.RegexOptions options = ((System.Text.RegularExpressions.RegexOptions.IgnorePatternWhitespace
                    | System.Text.RegularExpressions.RegexOptions.Multiline)
                    | System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                System.Text.RegularExpressions.Regex regEmail = new System.Text.RegularExpressions.Regex(regexEmail, options);

                string email = userToCreate.uemail;
                if (regEmail.IsMatch(email))//email 填写符合正则表达式 "\\w{1,}@\\w{1,}\\.\\w{1,}"
                {
                   // successful
                }
                else
                {
                    TempData["ErrorMessage"] = "Registration failed! Your E-mail don't follow the usual fomat."; 
                    return View();
                }

                SmtpClient client = new SmtpClient();
                //获取或设置用于验证发件人身份的凭据。
                client.Credentials = new System.Net.NetworkCredential("2352695754@qq.com", "waveproject");
                //经过ssl(安全套接层)加密,163邮箱SSL协议端口号为465/994,关闭SSL时端口为25,
                //qq邮箱SSL协议端口号为465或587,关闭SSL时端口同样为25，不过用SSL加密后发送邮件都失败，具体原因不知
                //client.EnableSsl = true;        
                client.Port = 25;                //端口号
                client.Host = "smtp.qq.com";     //获取或设置用于 SMTP 事务的主机的名称或 IP 地址
                try
                {
                    client.Send(InitMailMessage("2352695754@qq.com", userToCreate.uemail));
                }
                catch (System.Net.Mail.SmtpException ex)
                {
                    TempData["ErrorMessage"] = "Confirm message failed to deliver." + ex.Message;
                    return View();
                }


                _db.AddToUsers(userToCreate);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Registration succeeds! Your can log in using the new username and password.";
                return RedirectToAction("Main");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Registration has failed because: " + exception.Message;
                return View();
            }
        }

        //
        // GET: /Main/OrgDetails/5

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

        public MailMessage InitMailMessage(string from, string to)
        {
            MailMessage mail = new MailMessage();

            mail.From = new MailAddress(from);  //发件人
            mail.To.Add(to);                  //收件人
            mail.Subject = "Wave Sign Up Confirm";         //主题
            mail.Body = "You are now one member of the wave website.";            //内容

            //邮件主题和正文的编码格式

            mail.SubjectEncoding = System.Text.Encoding.UTF8;
            mail.BodyEncoding = System.Text.Encoding.UTF8;


            mail.IsBodyHtml = true;                     //邮件正文允许html编码
            mail.Priority = MailPriority.Normal;        //优先级

            //密送——就是将信密秘抄送给收件人以外的人，所有收件人看不到密件抄送的地址
            mail.Bcc.Add("1050282973@qq.com");

            //抄送——就是将信抄送给收件人以外的人,所有的收件人可以在抄送地址处看到此信还抄送给谁
            // mail.CC.Add("1052647407@qq.com");

            // mail.Attachments.Add(new Attachment("D:\\1.doc"));     //添加附件

            return mail;

        }
    }
}
