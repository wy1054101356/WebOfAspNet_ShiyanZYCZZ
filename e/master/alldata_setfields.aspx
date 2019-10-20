<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
  OleDbConnection conn;
  string TheTable,TheMaster,Table_List,Fields,Fields_Name,sql;

  protected void Page_Load(Object src,EventArgs e)
   {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    TheMaster=YZ._UserName;
    TheTable=Request.QueryString["table"];
    if(!IsStr(TheTable))
     {
      TheTable="article";
     }
   Conn Myconn=new Conn();
   conn=Myconn.OleDbConn();//获取OleDbConnection
   if(!Page.IsPostBack)
    {
      conn.Open();
        Get_Fields();
     conn.Close();
    }
  }

private void Get_Fields()
  {
    string sql="select field,field_name,field_type,value_type from pa_field where thetable='"+TheTable+"' order by xuhao";
    OleDbCommand Comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=Comm.ExecuteReader();
    while(dr.Read())
     {
      Fields+=dr["field"].ToString()+"|"+dr["field_type"].ToString()+"|"+dr["value_type"].ToString()+",";
      Fields_Name+=dr["field_name"].ToString()+",";
     }
    dr.Close();
  }


private bool IsStr(string str)
 { 
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789abcdefghijklmnopqrstuvwxyz_";
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
</script>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="data_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=5 cellspacing=0 width=98% align=center>
  <tr>
  <td height=22 width=100px>标题字段</td>
  <td><select name="title" id="title"></select></td>
 </tr>

 <tr>
  <td height=22>简介字段</td>
  <td><select name="introduction" id="introduction"></select></td>
 </tr>

 <tr>
  <td height=22>内容字段</td>
  <td><select name="content" id="content"></select></td>
 </tr>

</table>
</td>
</tr>
</table>

<br>
<div align=center>
<input type="button" class=button value="保存设置" onclick="Get_Fields()">
<input type="button" class=button value="关闭"  onclick="parent.CloseDialog()">
</div>
<br>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
var Fields="<%=Fields%>"
var Fields_Name="<%=Fields_Name%>"
var AFields=Fields.split(',');
var AFields_Name=Fields_Name.split(',');
var title=document.getElementById("title");
var titlepic=document.getElementById("titlepic");
var introduction=document.getElementById("introduction");
var content=document.getElementById("content");
var thedate=document.getElementById("thedate");
var field="",fieldtype="",valuetype="";
for(var i=0;i<AFields.length-1;i++)
 {
   if(AFields[i]!="")
    {
      field=AFields[i].split('|')[0];
      fieldtype=AFields[i].split('|')[1];
      valuetype=AFields[i].split('|')[2];
      if(fieldtype=="text" && valuetype=="nvarchar")
       {
        title.options.add(new Option(AFields_Name[i]+"("+field+")",field));
       }
      if(fieldtype=="text" || fieldtype=="textarea" || fieldtype=="editor")
       {
         if(valuetype=="nvarchar" || valuetype=="ntext")
          {
            introduction.options.add(new Option(AFields_Name[i]+"("+field+")",field));
          }
       }
      if(fieldtype=="textarea" || fieldtype=="editor")
       {
        content.options.add(new Option(AFields_Name[i]+"("+field+")",field));
       }

    }
 }

title.value="title";
content.value="content";
function Get_Fields()
 {
   var fields=title.value+","+introduction.value+","+content.value;
   parent.document.getElementById("Add_AllData_Fields").value=fields;
   parent.CloseDialog();
 }
</script>
</body>
</html> 
