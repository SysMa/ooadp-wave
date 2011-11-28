using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Wave.Models;

namespace Wave.Models
{
    public class ChangePwdModel
    {
        public string original { get; set; }
        public string password { get; set; }
        public string confirmPwd { get; set; }
    }
}