<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string Sid,Table,DetailId,Action,Mood,sql;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    Sid=Request.QueryString["siteid"];
    Table=Request.QueryString["thetable"];
    DetailId=Request.QueryString["detailid"];
    Action=Request.QueryString["action"];
    Mood=Request.QueryString["type"];
    if(IsNum(Sid) && IsStr(Table) && IsNum(DetailId))
     {
      Conn Myconn=new Conn();
      conn=Myconn.OleDbConn();//获取OleDbConnection
       if(Action=="show")
       {
         GetData();
       }
      else if(Action=="add" && IsNum(Mood))
       {
         AddData();
         GetData();
       }
     }
   else
    {
      Response.Write("error");
      Response.End();
    }
  }

private void GetData()
 {
       string rv="";
       conn.Open();
       sql="select mood1,mood2,mood3,mood4,mood5,mood6,mood7,mood8 from pa_mood where site_id="+int.Parse(Sid)+" and thetable='"+Table+"' and detail_id="+int.Parse(DetailId);
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       if(dr.Read()) 
       {
         rv=dr["mood1"].ToString()+","+dr["mood2"].ToString()+","+dr["mood3"].ToString()+","+dr["mood4"].ToString()+","+dr["mood5"].ToString();
         rv+=","+dr["mood6"].ToString()+","+dr["mood7"].ToString()+","+dr["mood8"].ToString();
       }
      else
       {
        sql="insert into pa_mood(site_id,thetable,detail_id) values("+int.Parse(Sid)+",'"+Table+"',"+int.Parse(DetailId)+")";
        comm=new OleDbCommand(sql,conn);
        comm.ExecuteNonQuery();
        rv="0,0,0,0,0,0,0,0";
       }
      dr.Close();
      conn.Close();
      Response.Write(rv);
      Response.End();
 }


private void AddData()
 {
   int MoodNum=int.Parse(Mood);
   string Field="mood"+Mood;
   sql="update pa_mood set "+Field+"="+Field+"+1 where site_id="+int.Parse(Sid)+" and thetable='"+Table+"' and detail_id="+int.Parse(DetailId);
   conn.Open();
   OleDbCommand comm=new OleDbCommand(sql,conn);
   comm.ExecuteNonQuery();
   conn.Close();
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