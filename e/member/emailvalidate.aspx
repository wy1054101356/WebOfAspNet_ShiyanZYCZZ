<% @ Page language="c#" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.Text.RegularExpressions"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
     string Sid=Request.QueryString["s"];
     string UserName=Request.QueryString["UserName"];
     string ValicateCode=Request.QueryString["code"];
     string Checked="0";
     if(IsNum(Sid) && IsUserName(UserName) && IsStr(ValicateCode))
      {
        Conn Myconn=new Conn();
        conn=Myconn.OleDbConn();//获取OleDbConnection
        conn.Open();
        string sql="select id,checked from pa_member where username='"+Sql_Format(UserName)+"' and valicatecode='"+ValicateCode+"'";
        OleDbCommand comm=new OleDbCommand(sql,conn);
        OleDbDataReader dr= comm.ExecuteReader();
        if(dr.Read())
        {
          Checked=dr["checked"].ToString();
          if(Checked=="0")
          {
            Update_Data(Sid,dr["id"].ToString());
            dr.Close();
            conn.Close();
            Response.Write("<"+"script type='text/javascript'>alert('验证成功!');location.href='"+Get_Url("mem_idx",Sid)+"'<"+"/script>");
            Response.End();
          }
         else
          {
            Response.Write("对不起，此用户已经通过邮件验证。");
          }
        }
       else
        {
         Response.Write("对不起，验证失败。");
        }
       dr.Close();
       conn.Close();
      }
    else
     {
       Response.Write("对不起，此url地址无效。");
       Response.End();
     }
  }

private void Update_Data(string Site_Id,string UID)
 {
   DateTime LoginDate=DateTime.Now;
   string LastDate=LoginDate.ToString("yyyy-MM-dd HH:mm:ss");
   string Lst_Ip=Request.ServerVariables["REMOTE_ADDR"];
   string sql="update pa_member set checked=1,lastdate='"+LastDate+"',lst_ip='"+Lst_Ip+"',logins=logins+1 where id="+UID;
   OleDbCommand Comm=new  OleDbCommand(sql,conn);
   Comm.ExecuteNonQuery();
   //生成cookie
   HttpCookie SCookie=new HttpCookie("site");
   SCookie.Value=Site_Id;
   Response.AppendCookie(SCookie); 
   Md5 Jm=new Md5();
   HttpCookie MCookie=new HttpCookie("Member");
   MCookie.Values.Add("UID",UID);
   MCookie.Values.Add("Valicate",Jm.Get_Md5(LoginDate.ToString("yyyyMMddHHmmss")));
   Response.AppendCookie(MCookie); 
 }

private string Get_Url(string Type,string Sid)
  {
    return "index.aspx?s="+Sid+"&type="+Type;
  }

private string Sql_Format(string str)
 {
    if(string.IsNullOrEmpty(str)){return "";}
    str=Server.UrlDecode(Server.UrlEncode(str).Replace("%00",""));
    str=str.Replace("'","''");
    str=str.Replace("\"","\"");
    return str;
 }

private bool IsUserName(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  Regex re = new Regex(@"[\u4e00-\u9fa5]+");
  str=re.Replace(str,"");
  if(str.Length==0){return true;}
  else{return IsStr(str);}
 }

private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  string str2=str.ToLower();;
  for(int i=0;i<str2.Length;i++)
   {
    if(str1.IndexOf(str2[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  int rv=0;
  if(Int32.TryParse(str,out rv))
   {
    return true;  
   }
  else
   {
    return false;
   }
 }
</script>

