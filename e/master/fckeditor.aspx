<% @ Page Language="C#" %>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string TheTable,TheField,TheId,objid,constr;
 protected void Page_Load(Object src,EventArgs e)
  {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();       //PageAdmin网站管理系统管理权限验证

    TheTable=Request.QueryString["table"];
    TheField=Request.QueryString["field"];
    TheId=Request.QueryString["id"];
    objid=Request.QueryString["objid"];

  }

protected void Content_Update(Object src,EventArgs e)
 {
   int Id;
   if(IsNum(TheId))
    {
     Id=int.Parse(TheId);
    }
   else
    {
      Id=0;
      Response.Write("<script type='text/javascript'>alert('提交成功!');parent.CloseDialog();</"+"script>");
      Response.End();
    }
   string TheContent=Content.Text;
   string sql="select * from  "+TheTable+" where id="+Id;

   OleDbConnection conn;
   Conn Myconn=new Conn();
   conn=Myconn.OleDbConn();//获取OleDbConnection

   conn.Open();
   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   OleDbCommandBuilder mycb=new  OleDbCommandBuilder(myAdapter);
   myAdapter.Fill(ds,"table1");
   DataRow dr;
     dr=ds.Tables["table1"].Rows[0];
     dr[TheField]=TheContent;
   myAdapter.Update(ds,"table1");
   conn.Close();
   Response.Write("<script type='text/javascript'>alert('提交成功!');parent.CloseDialog();</"+"script>");
   Response.End();
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

</script>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>在线编辑器-PageAdmin网站管理系统</title>
<link rel="stylesheet" href="master.css" type="text/css">
<script src="master.js" type="text/javascript"></script>
<script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js"></script>
</head>  
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98%>
 <tr>
<td valign=top>
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
  <td><asp:TextBox  id="Content"  TextMode="MultiLine"  runat="server" style="width:100%;height:350px;" />
<script>
        KindEditor.ready(function(K) {
                window.editor = K.create('#Content',
                    {
                      uploadJson :kindeditor_uploadJson,
                      fileManagerJson :kindeditor_fileManagerJson,
                      allowFileManager :true,
                      items :kindeditor_DefaultItems,
                      newlineTag:"br",
                      filterMode :false,
                      extraFileUploadParams:{siteid:'<%=Request.Cookies["SiteId"].Value%>'}
                    }
                );
            var p_obj=parent.document.getElementById("<%=objid%>");
            editor.html(p_obj.value); 
        });
</script>
  </td>
 </tr>
</table>
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
<td height=20 align=center>
<asp:Button Cssclass=button text="提交" runat="server" onclick="Content_Update" Id="Bt_Submit"/>
<input type="button" class=button  value="关闭"  onclick="cwin()">
</td>
 </tr>
</table>
<asp:Label id="Lb_Id" runat="server" visible="false"/>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
function cwin()
 { 
  parent.CloseDialog();
 }

function Write_Pcontent()
 {
  var p_obj=parent.document.getElementById("<%=objid%>");
  p_obj.value=editor.html(); 
 }
document.getElementById("Bt_Submit").onclick=Write_Pcontent;
</script>
</body>
</html>