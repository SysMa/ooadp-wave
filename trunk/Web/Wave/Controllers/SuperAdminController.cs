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
        // GET: /SuperAdmin/Details/5

        public ActionResult Details(int id)
        {
            return View();
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

            //adminToEdit.apasswd = "oooooooooo";
            try
            {
                _db.ApplyCurrentValues<Admin>(originalAdmin.EntityKey.EntitySetName, adminToEdit);
                //_db.ApplyPropertyChanges(originalMovie.EntityKey.EntitySetName, movieToEdit);

                _db.ApplyCurrentValues<Admin>(originalAdmin.EntityKey.EntitySetName, adminToEdit);

                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
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
                return View(originalAdmin);

            try
            {
                _db.DeleteObject(originalAdmin);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return RedirectToAction("Index");
            }
            
        }

        //
        // POST: /SuperAdmin/Delete/5

        [HttpPost]
        public ActionResult Delete(String id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
                var originalAdmin = (from m in _db.Admin
                                     where m.adminname == id
                                     select m).First();

                if (!ModelState.IsValid)
                    return View(originalAdmin);
                _db.DeleteObject(originalAdmin);
                _db.SaveChanges();

                return RedirectToAction("Index");
            }
            catch
            {
                return RedirectToAction("Index");
            }
        }

        public ActionResult ChangePwd()
        {
            return View();
        }
    }
}
