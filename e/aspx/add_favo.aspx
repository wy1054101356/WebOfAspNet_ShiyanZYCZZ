<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Import NameSpace="System.Text.RegularExpressions"%>
<script language="c#" runat="server">
 string TheTitle,Url,Table,DetailId,UserName;
 int Site_Id;
 OleDbConnection conn;
 OleDbCommand comm;
 OleDbDataReader dr;
 protected void Page_Load(Object src,EventArgs e)
  {
    string sql;
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    if(Request.Form["post"]=="add")
     {
       Table=Request.Form["table"];
       DetailId=Request.Form["id"];
       Url=Request.Form["url"];
       TheTitle="";
       if(!IsStr(Table) || !IsNum(DetailId))
        {
          Response.Write("cs error");
          Response.End();
        }
       else
        {
         Check_Post();
         Check_Member();
         conn.Open();
         bool IsExists=false;
         sql="select id from pa_favourites where thetable='"+Table+"' and detail_id="+DetailId;
   	 comm=new OleDbCommand(sql,conn);
   	 dr=comm.ExecuteReader();
   	 if(dr.Read()) 
   	  {
            IsExists=true;
          }
         dr.Close();
         if(!IsExists)
          {
           sql="select [site_id],[title] from "+Table+" where id="+DetailId;
   	   comm=new OleDbCommand(sql,conn);
   	   dr=comm.ExecuteReader();
   	   if(dr.Read()) 
   	    {
             TheTitle=dr["title"].ToString();
             Site_Id=int.Parse(dr["site_id"].ToString());
            }
           else
            {
             dr.Close();
             conn.Close();
             Response.Write("not_exists");
             Response.End();
            }
           dr.Close();
           sql="insert into pa_favourites([site_id],[title],[url],[thetable],[detail_id],[username],thedate) values("+Site_Id+",'"+Sql_Format(TheTitle)+"','"+Sql_Format(Url)+"','"+Table+"',"+int.Parse(DetailId)+",'"+UserName+"','"+DateTime.Now+"')";
           comm=new OleDbCommand(sql,conn);
           comm.ExecuteNonQuery();
           conn.Close();
           Response.Write("ok");
           Response.End();
          }
        else
         {
           conn.Close();
           Response.Write("has_exists");
           Response.End();
         }

       }

   }
 }

private void Check_Member()
 {
   UserName="";
   if(Request.Cookies["Member"]!=null)
     {
       Member_Valicate Member=new Member_Valicate();
       Member.Member_Check();
       UserName=Member._UserName;
     }
   else
    {
      Response.Write("notlogin");
      Response.End();
    }
 }

private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
            Response.Write("invalid_submit");
            Response.End();
          }
      }
 }

private string Sql_Format(string str)
 {
  if(str=="" || str==null)
   {
    return "";
   }
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
 }

private bool IsStr(string str)
 {
  if(str=="" || str==null)
   {
    return false;
   }
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
