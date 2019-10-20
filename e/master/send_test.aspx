<% @ Page Language="C#"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" Runat="server">
 int SiteId;
protected void Page_Load(Object src,EventArgs e)
   {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
     SiteId=int.Parse(Request.Cookies["SiteId"].Value);
     lb_info.Text="";
     if(Request.QueryString["type"]=="smsinfo")
      {
        SmsInfo();
      }
   }


private void Send_Email(Object src,EventArgs e)
  {
    if(!IsEmail(email.Text))
     {
       lb_info.Text="<span style='color:#ff0000'>邮箱未填写或格式错误</span>";
       return;
     }
    SendMessage em=new SendMessage(SiteId);
    string Result=em.SendEmail(email.Text,"","",e_title.Text,e_content.Text);
    if(Result=="success")
     {
        Result="发送成功(^_^)!";
     }
    lb_info.Text="<span style='color:#ff0000'>"+Result+"!</span>";
  }

private void SmsInfo()
  {
    SendMessage sms=new SendMessage(SiteId);
    string Result=sms.SmsInfo();
    smsinfo.Text=Result;
  }

private void Send_Sms(Object src,EventArgs e)
  {
    if(!IsMobile(mobile.Text))
     {
       lb_info.Text="<span style='color:#ff0000'>手机号码未填写或格式错误</span>";
       return;
     }
    SendMessage sms=new SendMessage(SiteId);
    string Result=sms.SendSms(mobile.Text,sms_content.Text);
    if(Result=="success")
     {
        Result="发送成功(^_^)";
     }
    lb_info.Text="<span style='color:#ff0000'>"+Result+"!</span>";
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

private bool IsMobile(string val)
  {
    return System.Text.RegularExpressions.Regex.IsMatch(val, @"^1[3458]\d{9}$",System.Text.RegularExpressions.RegexOptions.IgnoreCase);
  }
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>发送测试</title>
<link rel="stylesheet" href="master.css" type="text/css">
<script src="master.js" type="text/javascript"></script>
</head>  
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0 style="padding:10px">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
<form runat="server">
<%if(Request.QueryString["type"]=="email"){%>
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
  <td width=100px>接受邮箱</td>
  <td><asp:TextBox id="email" runat="server" text="ceshi@pageadmin.net" style="width:200px"/> 请修改为您的接受邮箱地址</td>
</tr>
<tr>
  <td width=100px>邮件标题</td>
  <td><asp:TextBox id="e_title" runat="server" text="pageadmin邮件测试主题" style="width:200px"/></td>
</tr>
<tr>
  <td width=100px>邮件内容</td>
  <td><asp:TextBox id="e_content" runat="server" text="您好，欢迎你使用pageadmin网站管理系统。" style="width:400px"/></td>
</tr>
<tr>
  <td width=100px colspan="2"><asp:Button text="发送" runat="server" onclick="Send_Email"/></td>
</tr>
</table>
<%}else if(Request.QueryString["type"]=="sms"){%>
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
  <td width=100px>接受手机</td>
  <td><asp:TextBox id="mobile" runat="server" text="" style="width:200px"/> 请填写您的手机号码</td>
</tr>

<tr>
  <td width=100px>短信内容</td>
  <td><asp:TextBox id="sms_content" runat="server" text="您好，欢迎你使用pageadmin网站管理系统。" style="width:400px"/></td>
</tr>
<tr>
  <td width=100px colspan="2"><asp:Button text="发送" runat="server" onclick="Send_Sms"/></td>
</tr>
</table>
<%}else if(Request.QueryString["type"]=="smsinfo"){%>
<div style="padding:10px"><asp:Label id="smsinfo" runat="server" /></div>
<%}%>
</form>
</td>
</tr>
</table>
<asp:Label  runat="server" Id="lb_info" style="font-size:12px"/>
</body>
</html>