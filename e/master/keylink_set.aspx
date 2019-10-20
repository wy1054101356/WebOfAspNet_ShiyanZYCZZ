<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();       //PageAdmin网站管理系统管理权限验证
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     if(!Page.IsPostBack)
     {
      Get_Date();
     }
  }


private void Get_Date()
 {
  string Id=Request.QueryString["id"];
  if(IsNum(Id))
   {
    string sql="select * from pa_keylink where id="+Id;
    conn.Open();
    OleDbCommand Comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=Comm.ExecuteReader();
    if(dr.Read())
     {
       key.Text=dr["key"].ToString();
       link.Text=dr["link"].ToString();
     }
    else
     {
       Response.End();
     }
    dr.Close();
    conn.Close();
   }
  else
   {
     Response.End();
   }
 }

void Data_Update(Object src,EventArgs e)
 {
  string IsUnicode="";
  if(ConfigurationManager.AppSettings["DbType"].ToString()=="1")
    {
      IsUnicode="N"; //unicode格式保存
    }
  string Id=Request.QueryString["id"];
  if(IsNum(Id))
   {
    string sql="update pa_keylink set [key]="+IsUnicode+"'"+Sql_Format(key.Text.Trim())+"',[link]="+IsUnicode+"'"+Sql_Format(link.Text.Trim())+"' where id="+Id;
    conn.Open();
    OleDbCommand Comm=new OleDbCommand(sql,conn);
    Comm.ExecuteNonQuery();
    conn.Close();
    Response.Write("<"+"script>alert('提交成功!');location.href=location.href</s"+"cript>");
    Response.End();
   }
  else
   {
     Response.End();
   }
 }


private bool IsNum(string str)
 {
  if(str=="" || str==null)
   {
    return false;
   }
  string str1="0123456789";
  string str2=str.ToLower();
  for(int i=0;i<str2.Length;i++)
   {
    if(str1.IndexOf(str2[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

private string Sql_Format(string str)
 {
    if(string.IsNullOrEmpty(str)){return string.Empty;}
    str=str.Replace("'","''");
    str=str.Replace("\"","\"");
    return str;
 }
</script>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_keylinklist"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">

<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
 <tr>
  <td height=25px  align="left" width="100px">关键词</td>
  <td height=25px  align="left"><asp:TextBox id="key" maxlength="50" size="30" runat="server" /></td>
 </tr>

 <tr>
  <td height=25px  align="left" width="100px">关键词链接</td>
  <td height=25px  align="left"><asp:TextBox id="link" maxlength="50" size="50" runat="server" /></td>
 </tr>

</table>
</td>
</tr>
</table>
<br>
<div align=center>
<span id="post_area">
<asp:Button Text=" 提交 " Cssclass="button" runat="server" onclick="Data_Update" onclientclick="return ck()"/>
<input type="button" class="button" onclick="parent.CloseDialog()" value="关闭">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span> 
</div>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
function ck()
 {
   var Add_Key=document.getElementById("key");
   var Add_Link=document.getElementById("link");
   if(Trim(Add_Key.value)=="")
    {
      alert("请填写关键词!");
      Add_Key.focus();
      return false;
    }
   if(Trim(Add_Link.value)=="")
    {
      alert("请填写关键词链接地址!");
      Add_Link.focus();
      return false;
    }
   return true;
 }
</script>

</body>
</html>  



