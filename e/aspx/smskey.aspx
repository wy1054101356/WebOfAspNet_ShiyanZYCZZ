<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
 OleDbConnection conn;
 string kw;
 protected void Page_Load(Object sender,EventArgs e)
   {
     kw="";
     string constr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="+System.Web.HttpContext.Current.Server.MapPath("/e/incs/sms/key.mdb");
     conn=new OleDbConnection(constr);
     conn.Open();
        Check_Post();
        Check_Txt();
      conn.Close();
      Response.Write(kw);
      Response.End();
   }

private void Check_Txt() //检查手机短信非法关键词，避免被接入商屏蔽。
 {
   string Txt=Request.Form["content"];
   if(string.IsNullOrEmpty(Txt)){return;}
   string sql="select keyname from keys";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
     {
       if(Txt.IndexOf(dr["keyname"].ToString())>=0)
        {
         kw=dr["keyname"].ToString();
         break;
        }
     }
    dr.Close();
 }

private void Check_Post()
 {
   string LocalUrl=Request.ServerVariables["SERVER_NAME"];
   string PostUrl=Request.ServerVariables["HTTP_REFERER"];
   if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
            Response.Write("Invalid Submit");
            Response.End();
          }
      }
    else
     {
       Response.End();
     }
 }

</script>
