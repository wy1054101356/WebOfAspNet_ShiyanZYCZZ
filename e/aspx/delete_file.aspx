<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
protected void Page_Load(Object sender,EventArgs e)
{
  Check_Post();
  string Table=Request.Form["table"];
  string Field=Request.Form["field"];
  string Id=Request.Form["id"];
  string D_File=Request.Form["path"];
  string UserName="";
  int IsMaster=0;
  int CanDel=1;
  if(IsStr(Table) && IsStr(Field) && IsNum(Id))
    {
     Conn Myconn=new Conn();
     OleDbConnection conn=Myconn.OleDbConn();//获取OleDbConnection
     conn.Open();
     if(Request.Cookies["Master"]!=null)
      {
        Master_Valicate Master=new Master_Valicate();
        Master.Master_Check();
        IsMaster=1;
      }
     else
      {
        Member_Valicate Member=new Member_Valicate();
        Member.Member_Check();
        UserName=Member._UserName;
      }
     string sql;
     OleDbCommand comm;
     OleDbDataReader dr;
     sql="select id from pa_field where thetable='"+Table+"' and [field]='"+Field+"'";
     comm=new OleDbCommand(sql,conn);
     dr=comm.ExecuteReader();
     if(!dr.Read())
       {
        CanDel=0;
       }
      dr.Close();

     if(CanDel==1)
      {
        if(IsMaster==1)
        {
         Del_File(D_File);
        }
       if(Id!="0")
       {
        if(IsMaster==0)
        {
         sql="update "+Table+" set "+Field+"='' where username='"+UserName+"'' and id="+Id;
        }
       else
        {
         sql="update "+Table+" set "+Field+"='' where id="+Id;
        }
        comm=new OleDbCommand(sql,conn);
        comm.ExecuteNonQuery();

        if(IsMaster==0)
        {
         sql="update pa_file set detail_id=0 where username='"+UserName+"'' and thetable='"+Table+"' and [field]='"+Field+"' and detail_id="+Id;
        }
       else
        {
         sql="update pa_file set detail_id=0 where thetable='"+Table+"' and [field]='"+Field+"' and detail_id="+Id;
        }
        comm=new OleDbCommand(sql,conn);
        comm.ExecuteNonQuery();
       }
      }
     conn.Close();
    }
}

private void Del_File(string FilePath)
 {
   if(FilePath!="" && FilePath.IndexOf(":")<0 && FilePath.IndexOf("/e/upload/")==0 && FilePath.IndexOf("..")<0)
    {
     if(FilePath.IndexOf("/zdy/")<0)
       {
         FilePath=Server.MapPath(FilePath);
         if(File.Exists(FilePath))
          {
            File.Delete(FilePath);
          }
      }
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

private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
           Response.Write("invalid submit");
           Response.End();
          }
      }
 }
</script>