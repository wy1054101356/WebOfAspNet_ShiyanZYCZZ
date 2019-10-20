<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string Tables,sql;
 int Site_Id,TheDay;
 OleDbConnection conn;
 OleDbCommand comm;
 OleDbDataReader dr;
 protected void Page_Load(Object src,EventArgs e)
  {
   Tables=Request.QueryString["tables"];

   if(Tables==null || Tables=="")
    {
      Response.Write("请设置好参数,参数类型：tables=表名");
    }
   else
    {
     canecl_top();
    }
  }

private void canecl_top()
 {
    string[] ATables=Tables.Split(',');
    string Dbtype=System.Configuration.ConfigurationManager.AppSettings["DbType"].ToString(); 
    Conn theconn=new Conn();
    conn=theconn.OleDbConn();//获取OleDbConnection
    conn.Open();
    for(int i=0;i<ATables.Length;i++)
     {
       if(!IsStr(ATables[i])){continue;}
       if(Dbtype=="0")
       {
        sql="update "+ATables[i]+" set istop=0,actdate=thedate where istop=1 and datediff('s',actdate,Now())>0";
       }
      else
       {
        sql="update "+ATables[i]+" set istop=0,actdate=thedate where istop=1 and datediff(second,actdate,getdate())>0";
       }
      comm=new OleDbCommand(sql,conn);
      comm.ExecuteNonQuery();
    }
    conn.Close();
   Response.Write("取消过期置顶完毕!");
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
  if(str=="" || str==null)
   {
    return false;
   }
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
