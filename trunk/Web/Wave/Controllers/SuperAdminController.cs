using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;

namespace Wave.Controllers
{
    public class SuperAdminController : Controller
    {
        //
        // GET: /SuperAdmin/
        private WaveWebEntities _db = new WaveWebEntities();

        public ActionResult Index()
        {
            return View(_db.Admin.ToList());
        }

        //
        // GET: /SuperAdmin/Create

        public ActionResult Create()
        {
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
                _db.AddToAdmin(adminToCreate);
                _db.SaveChanges();
                return RedirectToAction("Index");
            } catch {
                TempData["ErrorMessage"] = "Create failed! ";
                return View();
            }
            
 
        }
        
        //
        // GET: /SuperAdmin/Edit/5
 
        public ActionResult Edit(String id)
        {
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
            catch
            {
                TempData["ErrorMessage"] = "Edit failed! ";
                return View(originalAdmin);
            }
           
 
        } 

        //
        // GET: /SuperAdmin/Delete/5
 
        public ActionResult Delete(String id)
        {
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
            catch
            {
                TempData["ErrorMessage"] = "Delete failed! ";
                return View();
            }
            
        }

        public ActionResult ChangePwd()
        {
            return View();
        }
    }
}
