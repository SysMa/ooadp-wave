using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Wave.Models
{
    public class LoginModel
    {
        public string account { get; set; }
        public string password { get; set; }
        public int type { get; set; }
    }
}