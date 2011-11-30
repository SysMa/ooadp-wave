using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Wave.Models
{
    public class ChangePwdModel
    {
        [Required(ErrorMessage="Original password is needed.")]
        [DataType(DataType.Password)]
        public string original { get; set; }

        [Required(ErrorMessage = "New password is needed.")]
        [DataType(DataType.Password)]
        public string password { get; set; }

        [Required(ErrorMessage = "Confirm password is needed.")]
        [DataType(DataType.Password)]
        public string confirmPwd { get; set; }
    }
}