<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string SiteId,DataSiteId,Table,SortId,SortIds,SublanmuId,Rv,sql;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    Rv="";
    SiteId=Request.QueryString["siteid"];
    Table=Request.QueryString["table"];
    SortId=Request.QueryString["sortid"];
    SublanmuId=Request.QueryString["sublanmuid"];
    DataSiteId=Request.QueryString["datasiteid"];
    if(IsNum(SiteId) && IsNum(DataSiteId) && IsNum(SortId) && IsNum(SublanmuId) && IsStr(Table))
    {

       Conn Myconn=new Conn();
       conn=Myconn.OleDbConn();//获取OleDbConnection
       conn.Open();
       if(SortId=="0")
       {
        find_allsublanmu();
       }
      else
       {
         SortIds=GetSortIds(int.Parse(SortId));
         if(SortIds!="0")
          {
           find_sublanmu(SortIds);
          }
       }
      conn.Close();
    }
   Response.Write(Rv);
   Response.End();
 }
 
private void find_allsublanmu() 
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    sql="select id from pa_sublanmu where site_id="+SiteId+" and data_siteid="+DataSiteId+" and thetable='"+Table+"' and sort_id>=1 and is_sortsublanmu=1 and model_id>=1 and id<>"+SublanmuId; 
    comm=new OleDbCommand(sql,conn);
    dr=comm.ExecuteReader();
    if(dr.Read())
     {
      Rv=dr["id"].ToString();
     }
    dr.Close();
 }

private void find_sublanmu(string SortIds) 
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    if(IsNum(SortIds))
     {
      sql="select id from pa_sublanmu where site_id="+SiteId+" and data_siteid="+DataSiteId+" and thetable='"+Table+"' and sort_id="+SortIds+" and is_sortsublanmu=1 and model_id>=1 and id<>"+SublanmuId; 
      comm=new OleDbCommand(sql,conn);
      dr=comm.ExecuteReader();
      if(dr.Read())
      {
       Rv=dr["id"].ToString();
      }
     dr.Close();
     }
   else
     {
       string[] ASortIds=SortIds.Split(',');
       for(int i=0;i<ASortIds.Length;i++)
        {
         if(IsNum(ASortIds[i]))
          {
           sql="select id from pa_sublanmu where site_id="+SiteId+" and thetable='"+Table+"' and sort_id="+ASortIds[i]+" and is_sortsublanmu=1 and model_id>=1 and id<>"+SublanmuId; 
           comm=new OleDbCommand(sql,conn);
           dr=comm.ExecuteReader();
           if(dr.Read())
            {
             Rv=dr["id"].ToString();
             dr.Close();
             break;
            }
           dr.Close();
         }
        }

     }
 }


private string GetSortIds(int SortId)
 {
     string Ids=""; 
     string sql="select id from pa_sort where site_id="+SiteId+" and thetable='"+Table+"' and parent_ids like '%,"+SortId+",%'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     while(dr.Read())
      {
        Ids+=","+dr["id"].ToString();
      }
    dr.Close();
    return Ids;
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