<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
 int Lanmu_Id,Sublanmu_Id,Detail_Html;
 string Static_Dir;
 protected void Page_Load(Object src,EventArgs e)
   {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
     Lanmu_Id=0;
     Sublanmu_Id=0;
     Detail_Html=0;
     Get_Lanmu();
     Response.Write(Lanmu_Id+","+Sublanmu_Id+","+Detail_Html+","+Static_Dir);
     Response.End();
   }

private void Get_Lanmu()
 {
   if(!IsNum(Request.QueryString["sortid"]) || !IsNum(Request.Cookies["SiteId"].Value) || !IsStr(Request.QueryString["table"]))
    {
     return;
    }
   int SiteId=int.Parse(Request.Cookies["SiteId"].Value);
   string The_Table=Request.QueryString["table"];
   int Sort_Id=int.Parse(Request.QueryString["sortid"]);

   Conn Myconn=new Conn();
   OleDbConnection conn=Myconn.OleDbConn();//获取OleDbConnection
   conn.Open();
   OleDbCommand Comm;
   OleDbDataReader dr;
   string sql;
   sql="select static_dir from pa_table where thetable='"+The_Table+"'";
   Comm=new OleDbCommand(sql,conn);
   dr=Comm.ExecuteReader();
   if(dr.Read())
    {
     Static_Dir=dr["static_dir"].ToString();
    }
   dr.Close();

  sql="select id,lanmu_id,[detail_html] from pa_sublanmu where is_sortsublanmu=1 and site_id="+SiteId+" and sort_id=0 and model_id>0 and detail_model_id>0 and thetable='"+The_Table+"'";
  Comm=new OleDbCommand(sql,conn);
  dr=Comm.ExecuteReader();
  if(dr.Read())
     {
      Lanmu_Id=int.Parse(dr["lanmu_id"].ToString());
      Sublanmu_Id=int.Parse(dr["id"].ToString());
      Detail_Html=int.Parse(dr["detail_html"].ToString());
     }
   dr.Close();
   if(Sort_Id>0)
    {
     string Parent_Sorts="0";
     sql="select parent_ids,static_dir from pa_sort where id="+Sort_Id+" and thetable='"+The_Table+"'";
     Comm=new OleDbCommand(sql,conn);
     dr=Comm.ExecuteReader();
     if(dr.Read())
     {
       Parent_Sorts=dr["parent_ids"].ToString();
       if(dr["static_dir"].ToString()!="")
        {
         Static_Dir=dr["static_dir"].ToString();
        }
     }
     dr.Close();
     Parent_Sorts=Parent_Sorts+","+Sort_Id.ToString();
     string[] AParent_Sorts=Parent_Sorts.Split(',');
     int SLength=AParent_Sorts.Length;
     string C_Sort;
       for(int i=0;i<SLength;i++)
        {
           C_Sort=AParent_Sorts[SLength-i-1];
           if(C_Sort!="")
            {
              sql="select id,lanmu_id,[detail_html] from pa_sublanmu where is_sortsublanmu=1 and site_id="+SiteId+" and sort_id="+int.Parse(C_Sort)+" and thetable='"+The_Table+"'";
              Comm=new OleDbCommand(sql,conn);
              dr=Comm.ExecuteReader();
              if(dr.Read())
              {
                Lanmu_Id=int.Parse(dr["lanmu_id"].ToString());
                Sublanmu_Id=int.Parse(dr["id"].ToString());
                Detail_Html=int.Parse(dr["detail_html"].ToString());
                dr.Close();
                break;
              }
            dr.Close();
           }
        }
     }
    conn.Close();
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
  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
 }
</script>
