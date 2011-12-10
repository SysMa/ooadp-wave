using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wave.Models;
using System.IO;
using System.Net.Mail;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Text.RegularExpressions;

namespace Wave.Helper
{
    public static class SendMail
    {
        static string from = "2352695754@qq.com";
        static string from_pwd = "waveproject";
        static int from_port = 25;
        static string from_server = "smtp.qq.com";

        public static MailMessage InitMailMessage(string to, string message)
        {
            MailMessage mail = new MailMessage();

            mail.From = new MailAddress(from);  //发件人
            mail.To.Add(to);                  //收件人
            mail.Subject = "Wave Website";         //主题
            mail.Body = message;            //内容

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

        public static bool send(string to, string message)
        {
            string regexEmail = @"^\w+([-+.]?\w+)*@\w+([-.]?\w+)*\.\w+([-.]?\w+)*$ ";
            System.Text.RegularExpressions.RegexOptions options = ((System.Text.RegularExpressions.RegexOptions.IgnorePatternWhitespace
                | System.Text.RegularExpressions.RegexOptions.Multiline)
                | System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regEmail = new System.Text.RegularExpressions.Regex(regexEmail, options);

            if (!regEmail.IsMatch(to))   //email 填写符合正则表达式 "\\w{1,}@\\w{1,}\\.\\w{1,}"
            {
                return false;
            }

            SmtpClient client = new SmtpClient();
            //获取或设置用于验证发件人身份的凭据。
            client.Credentials = new System.Net.NetworkCredential(from, from_pwd);
            //经过ssl(安全套接层)加密,163邮箱SSL协议端口号为465/994,关闭SSL时端口为25,
            //qq邮箱SSL协议端口号为465或587,关闭SSL时端口同样为25，不过用SSL加密后发送邮件都失败，具体原因不知
            //client.EnableSsl = true;        
            client.Port = from_port;                //端口号
            client.Host = from_server;     //获取或设置用于 SMTP 事务的主机的名称或 IP 地址
            try
            {
                client.Send(InitMailMessage(to, message));
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                throw ex;
            }
            return true;
        }
    }
}