<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.Text"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string users,mtypeids,departmentids,Thetype,sql;
 protected void Page_Load(Object src,EventArgs e)
  {
    mtypeids=Request.Form["mtypeids"];
    departmentids=Request.Form["departmentids"];
    users=Request.Form["users"];
    Thetype=Request.Form["type"];
    if(IsStr(Thetype))
    {
    if(!string.IsNullOrEmpty(mtypeids) || !string.IsNullOrEmpty(departmentids) || !string.IsNullOrEmpty(users))
     {
      Master_Valicate YZ=new Master_Valicate();
      YZ.Master_Check();
      find_users();
     }
    }
 }
 
private void find_users() 
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    StringBuilder sb=new StringBuilder();

    OleDbConnection conn;
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection

    conn.Open();
    if(!string.IsNullOrEmpty(mtypeids))
     {
      if(IsNum(mtypeids.Replace(",","")))
      {
       sql="select "+Thetype+" from pa_member where mtype_id in("+mtypeids+")";
       comm=new OleDbCommand(sql,conn);
       dr=comm.ExecuteReader();
        while(dr.Read()) 
         {
           if(Thetype=="email" && IsEmail(dr[Thetype].ToString()))
            {
             sb.Append(","+dr[Thetype].ToString());
            }
           else if(Thetype=="mobile" && IsMobile(dr[Thetype].ToString()))
            {
             sb.Append(","+dr[Thetype].ToString());
            }
           else if(Thetype=="username")
            {
             sb.Append(","+dr[Thetype].ToString());
            }
         }
        dr.Close();
      }
     }

    if(!string.IsNullOrEmpty(departmentids))
     {
      if(IsNum(departmentids.Replace(",","")))
      {
       sql="select "+Thetype+" from pa_member where department_id in("+departmentids+")";
       comm=new OleDbCommand(sql,conn);
       dr=comm.ExecuteReader();
        while(dr.Read()) 
         {
           if(Thetype=="email" && IsEmail(dr[Thetype].ToString()))
            {
             sb.Append(","+dr[Thetype].ToString());
            }
           else if(Thetype=="mobile" && IsMobile(dr[Thetype].ToString()))
            {
             sb.Append(","+dr[Thetype].ToString());
            }
           else if(Thetype=="username")
            {
             sb.Append(","+dr[Thetype].ToString());
            }
         }
        dr.Close();
      }
     }

    if(!string.IsNullOrEmpty(users) && Thetype!="username")
     {
       string[] Ausers=users.Split(',');
       for(int i=0;i<Ausers.Length;i++)
        {
         if(string.IsNullOrEmpty(Ausers[i])){continue;}
        sql="select "+Thetype+" from pa_member where username='"+Ausers[i]+"'";
        comm=new OleDbCommand(sql,conn);
        dr=comm.ExecuteReader();
        if(dr.Read()) 
         {
           if(Thetype=="email" && IsEmail(dr[Thetype].ToString()))
            {
             sb.Append(","+dr[Thetype].ToString());
            }
           else if(Thetype=="mobile" && IsMobile(dr[Thetype].ToString()))
            {
             sb.Append(","+dr[Thetype].ToString());
            }
         }
        dr.Close();
       }
     }
   conn.Close();
   Response.Write(sb.ToString());
   Response.End();
 }

private bool IsMobile(string val)
  {
    return System.Text.RegularExpressions.Regex.IsMatch(val, @"^1[358]\d{9}$",System.Text.RegularExpressions.RegexOptions.IgnoreCase);
  }

private bool IsUserName(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  Regex re = new Regex(@"[\u4e00-\u9fa5]+");
  str=re.Replace(str,"");
  if(str.Length==0){return true;}
  else{return IsStr(str);}
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
  string str1="0123456789";
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
</script>