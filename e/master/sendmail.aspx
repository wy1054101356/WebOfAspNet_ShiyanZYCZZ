<% @ Page Language="C#"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Import NameSpace="System.Net"%>
<% @ Import NameSpace="System.Net.Mail"%>
<script language="c#" Runat="server">
  string MailHost,Email,em_pass,em_from,em_sign,fajian_name,SendWay;
  protected void Page_Load(Object src,EventArgs e)
     {
        Check_Post();
        string rv="0";
        MailHost=Request.Form["emailserver"];
        Email=Request.Form["fajianemail"];
        em_pass=Request.Form["emailpassword"];
        em_from=Email;
        fajian_name=Request.Form["fajianname"];
        em_sign=Request.Form["em_sign"];
        SendWay=Request.Form["sendway"];

        string em_to=Request.Form["em_to"];
        string em_subject=Request.Form["em_subject"];
        string em_body=Request.Form["em_body"];

        DateTime Dt=DateTime.Now;
        String YYYY=Dt.ToString("yyyy");
        String MM=Dt.ToString("MM");
        String DD=Dt.ToString("dd");
        String HH=Dt.ToString("HH");
        String mm=Dt.ToString("mm");
        String ss=Dt.ToString("ss");
        em_subject=em_subject.Replace("{email}",em_to).Replace("{yyyy}",YYYY).Replace("{MM}",MM).Replace("{dd}",DD).Replace("{hh}",HH).Replace("{mm}",mm).Replace("{ss}",ss);
        em_body=em_body.Replace("{email}",em_to).Replace("{yyyy}",YYYY).Replace("{MM}",MM).Replace("{dd}",DD).Replace("{hh}",HH).Replace("{mm}",mm).Replace("{ss}",ss);

        if(Send(em_to,em_from,"",em_subject,em_body))
         {
           rv="1";
         }
        else
         {
           rv="0";
         }
       Response.Write(rv);
       Response.End();
     }

private bool Send(string em_to,string em_reply,string em_cc,string em_subject,string em_body)
           { 
             em_body=em_body+em_sign;
             if(MailHost!="" && Email!="" && em_subject!="")
               {
                 switch(SendWay)
                   {
                     case "0":
                      return SendByJmail(em_to,em_reply,em_cc,em_subject,em_body);
                     break;

                     case "1":
                      return SendByNetMail(em_to,em_reply,em_cc,em_subject,em_body);
                     break;
                     
                     default:
                      return false;
                     break;       
                   }
               }
             else
               {
                 return false;
               }
           }

 private bool SendByJmail(string em_to,string em_reply,string em_cc,string em_subject,string em_body)
		{
                 if(!IsEmail(Email) || !IsEmail(em_to))
                  {
                    return false;
                  }
		 try
	          {
                  jmail.Message Jmail=new jmail.MessageClass();
                  Jmail.MailServerUserName=Email;
		  Jmail.MailServerPassWord=em_pass;
		  Jmail.From=em_from;
		  Jmail.FromName=fajian_name;//发件人名字
                  Jmail.ReplyTo=em_reply;
		  Jmail.AddRecipient(em_to,"","");
		  if(em_cc!="")
		  {
		    Jmail.AddRecipientCC(em_cc,"","");
		  }
                  Jmail.Subject=em_subject;
		  Jmail.Body=em_body;
		  Jmail.ContentType="text/html";
		  Jmail.Charset="gb2312";
		  Jmail.Send(MailHost,false);
	          return true;
                  }
		catch(Exception e)
		 {
		   return false;
		 }

		}


   private bool SendByNetMail(string em_to,string em_reply,string em_cc,string em_subject,string em_body)
		{
                 if(!IsEmail(Email) || !IsEmail(em_to))
                  {
                    return false;
                  }
		 try
		    {
			Encoding encoding=Encoding.GetEncoding("gb2312"); 
			MailMessage Msg=new  MailMessage();
			Msg.From=new MailAddress(Email,fajian_name);
			Msg.To.Add(em_to);
                        if(em_reply!="")
                         {
                          Msg.ReplyTo =new MailAddress(em_reply,"");  //邮件回复地址    
                         }

			if(em_cc!="")
			{
			   Msg.CC.Add(em_cc);
			}
			Msg.Subject=em_subject;
			Msg.Body=em_body;
			Msg.IsBodyHtml=true;
			Msg.SubjectEncoding=encoding;
			Msg.BodyEncoding=encoding;
			Msg.Priority=MailPriority.High;

			SmtpClient smtp=new SmtpClient();
			smtp.Host=MailHost;
			smtp.DeliveryMethod = SmtpDeliveryMethod.Network;//指定电子邮件发送方式
			smtp.Credentials=new NetworkCredential(Email,em_pass);
			//smtp.EnableSsl=true;GMAIL时启用
			   smtp.Send(Msg);
			   return true;
		     }
		 catch(Exception e)
		    {
		      return false;
		    }

		}

  private bool IsEmail(string Email)
   {
      string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
      System.Text.RegularExpressions.Regex reg = new System.Text.RegularExpressions.Regex(strRegex);
       if (reg.IsMatch(Email))
        {
          return true;
        }
        else
        {
          return false;
        }
   }

private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl==null)
      {
        Response.Write("0");
        Response.End();
      }
    else
      {
       if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
         {
           Response.Write("0");
           Response.End();
         }
      }
 }

</script>
</body>
</html>
