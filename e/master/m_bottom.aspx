<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Text"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="System.Net"%>
<% @ Import NameSpace="System.Configuration"%>
<% @ Import NameSpace="PageAdmin"%><script language="c#" runat="server">protected void Page_Load(Object src,EventArgs e){GetInfo();}
private void GetInfo(){string LC=ConfigurationManager.AppSettings["License"].ToString().Trim();if(LC!=""){return;} bool CL=false;string Str="";try{string TheUlr=Request.ServerVariables["SERVER_NAME"]; Encoding encoding=Encoding.GetEncoding("UTF-8"); string Web_Port=Web_Port=":"+Request.ServerVariables["SERVER_PORT"];if(Web_Port==":80"){Web_Port="";}string Url="http://"+TheUlr+Web_Port;WebRequest  MyReq=WebRequest.Create(Url);WebResponse MyRes=MyReq.GetResponse();Stream ReStream=MyRes.GetResponseStream();ReStream.ReadTimeout=5000;StreamReader Reader=new StreamReader(ReStream,encoding);int i=0;while(!Reader.EndOfStream){Str=Reader.ReadLine(); i++;if(i<4){ if(Str.IndexOf("<title>")>=0 && Str.IndexOf("</title>")>=0){ CL=false;break; }if(Str.IndexOf("<!--")>=0){ CL=false;break; } }if(i==4){ break; }}Reader.Close(); ReStream.Close();MyRes.Close();}catch(Exception e){}string T_CR="-Powered by PageAdmin CMS";if(Str.IndexOf("<title>")>=0 && Str.IndexOf("</title>")>=0){if(Str.IndexOf("<title>")>Str.IndexOf(T_CR)){CL=false;} else if(Str.IndexOf("</title>")<Str.IndexOf(T_CR)){CL=false;}else if(Str.IndexOf("<!--")>=0){CL=false;} else if(Str.IndexOf(T_CR)>=0){CL=true;}else{CL=false;}}else{CL=false;}if(!CL){Clear_Cookie();}}
private void Clear_Cookie(){HttpCookie Cookie1=new HttpCookie("Master");HttpCookie Cookie2=new HttpCookie("SiteId");string Login_Url=GetUrl(ConfigurationManager.AppSettings["Url"].ToString().ToLower());string Local_Url=GetUrl(Request.ServerVariables["SERVER_NAME"].ToLower());if(Local_Url!="localhost"){Cookie1.Domain=Login_Url; Cookie2.Domain=Login_Url; }Cookie1.Expires=DateTime.Now.AddDays(-1);Cookie2.Expires=DateTime.Now.AddDays(-1);Response.AppendCookie(Cookie1);Response.AppendCookie(Cookie2);}
private string GetUrl(string Url){if(IsLocal(Url) || Url.IndexOf(".")<0){ return "localhost";}else{return Url.Replace("www.","");}}
private bool IsLocal(string str){string[] LocalIp=new string[]{@"^127[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}$",@"^localhost$",@"^10[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}$",@"^172[.]((1[6-9])|(2\d)|(3[01]))[.]\d{1,3}[.]\d{1,3}$",@"^192[.]168[.]\d{1,3}[.]\d{1,3}$"};for(int i=0;i<LocalIp.Length;i++){if(System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str),LocalIp[i])){ return true;}}return false;}</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Author"  content="PageAdmin CMS" />
<link rel="stylesheet" href="master.css" type="text/css">
<script language="javascript">
var hashide=false;
function showleftmenu()
{
var obj=window.parent.document.getElementById("leftmenu");
if(hashide)
{
 hashide=false;
 document.getElementById("signpic").src="images/arrow_left.gif";
 obj.cols="140,*"
 document.getElementById("sign_text").innerHTML="隐藏左菜单";
}
else
{
 hashide=true;
 document.getElementById("signpic").src="images/arrow_right.gif";
 obj.cols="1,*"
 document.getElementById("sign_text").innerHTML="显示左菜单";
}
}
</script>
</head>  
<body  topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0 class=bg2>
<table width=100% height=15px cellpadding=0 cellspacing=0 class=border1>
  <tbody>
  <tr>
  <td  valign=middle class=white ><a href="#" id="a_sign" onclick="showleftmenu()"><img id="signpic" src="images/arrow_left.gif" border=0 align="absmiddle" hspace=5 vspace=2><span id="sign_text">隐藏左菜单</span></a></td>
   </tr> 
   </tbody>
   </table>
</body>
</html>  