﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;

namespace Wave.Controllers
{
    public class SuperAdminController : Controller
    {
        private WaveWebEntities _db = new WaveWebEntities();

        //
        // GET: /SuperAdmin/

        public ActionResult Index()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 0)
            {
                return RedirectToAction("Main", "Main");
            }
            return View(_db.Admin.ToList());
        }

        //
        // GET: /SuperAdmin/Create

        public ActionResult Create()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 0)
            {
                return RedirectToAction("Main", "Main");
            }
            return View();
        } 

        //
        // POST: /SuperAdmin/Create

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(Admin adminToCreate)
        {
            if (!ModelState.IsValid)
                return View();

            try
            {
                var admin = (from m in _db.Admin
                                     where m.adminname == adminToCreate.adminname
                                     select m);
                if (admin.Count() != 0)
                {
                    TempData["ErrorMessage"] = "Administrator name exists, please retype it and try again! ";
                    return View();
                }
                _db.AddToAdmin(adminToCreate);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Admin creation has failed because: " + exception.Message;
                return View();
            }
        }
        
        //
        // GET: /SuperAdmin/Edit/5
 
        public ActionResult Edit(String id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 0)
            {
                return RedirectToAction("Main", "Main");
            }

            var adminToEdit = (from m in _db.Admin 
                              where m.adminname == id
                              select m).First();

            return View(adminToEdit);
        }

        //
        // POST: /SuperAdmin/Edit/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(Admin adminToEdit)
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
                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Admin change has failed because: " + exception.Message;
                return View(originalAdmin);
            }
        } 

        //
        // GET: /SuperAdmin/Delete/5

        public ActionResult Delete(String id)
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 0)
            {
                return RedirectToAction("Main", "Main");
            }

            var originalAdmin = (from m in _db.Admin
                                 where m.adminname == id
                                 select m).First();

            if (!ModelState.IsValid)
                return View();

            try
            {
                _db.DeleteObject(originalAdmin);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                TempData["ErrorMessage"] = "Deletion has failed because: " + exception.Message;
                return View();
            }
            
        }

        //
        // GET: /SuperAdmin/ChangePwd/
        public ActionResult ChangePwd()
        {
            if (Session["waveType"] == null || Session["waveAccount"] == null || (int)Session["waveType"] != 0)
            {
                return RedirectToAction("Main", "Main");
            }
            return View();
        }

        //
        // POST: /SuperAdmin/ChangePwd/

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangePwd(ChangePwdModel passwordToChange)
        {
            if (!ModelState.IsValid)
                return View();
            string superAdmin = Session["waveAccount"].ToString();
            var account = (from m in _db.SuperAdmin
                                 where m.supname == superAdmin
                                 select m).First();

            if (account.spasswd != passwordToChange.original)
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
                account.spasswd = passwordToChange.password;

                try
                {
                    _db.ApplyCurrentValues<SuperAdmin>(account.EntityKey.EntitySetName, account);
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

        public ActionResult LogOut()
        {
            Session.Clear();
            return RedirectToAction("Main", "Main");
        }
    }
}