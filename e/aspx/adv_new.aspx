<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string Adv_title,Adv_content;
 int Id;
 protected void Page_Load(Object src,EventArgs e)
  {
    if(IsNum(Request.QueryString["id"]))
     {
     Id=int.Parse(Request.QueryString["id"]);
     Conn Myconn=new Conn();
     OleDbConnection conn=Myconn.OleDbConn();//获取OleDbConnection
     conn.Open();
     string sql="select window_title,content from pa_adv where id="+Id;
     OleDbCommand Comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=Comm.ExecuteReader();
     if(dr.Read())
     {
      Adv_title=dr["window_title"].ToString();
      Adv_content=dr["content"].ToString();
     }
     dr.Close();
     conn.Close();
    }
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Adv_title%></title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/ >
<STYLE type=text/css>
body {
        word-break:break-all;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-size: 12px;
}
form,ul,li{list-style-type:none;margin:0 0 0 0;padding:0 0 0 0;}
p{padding:0 0 0 0;margin:0 0 0 0;}
td,div{FONT-SIZE:12px;LINE-HEIGHT:20px;}
#Adv_Content{padding:0 0 0 0;}
</STYLE>
</HEAD>
<BODY>
<div id="adv_<%=Id%>"><%=Adv_content%></div>
</BODY></HTML>