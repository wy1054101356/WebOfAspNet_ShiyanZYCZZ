<% @ Page language="c#" %><!DOCTYPE html>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string ObjId,IsMultiple,MemberTypeList,sql;
 OleDbConnection conn;
 public void Page_Load(Object src,EventArgs e)
  {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    ObjId=Request.QueryString["objid"];
    IsMultiple=Request.QueryString["ismultiple"];
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    ListMemberType();
  }

 private void ListMemberType() //根据部门分类列出
   {
    conn.Open();
     sql="select id,name from pa_member_type order by xuhao";
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr= comm.ExecuteReader();
      while(dr.Read())
       {
         MemberTypeList+="<option value='"+dr["id"].ToString()+"'>"+dr["name"].ToString()+"</option>";
       }
     dr.Close();
     conn.Close();
   }

private bool IsNum(string str)
 {
  string str1="1234567890";
  if(str=="" ||   str==null)
   {
    return false;
   }

  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

private string Sql_Format(string str)
 {
  if(str=="" || str==null)
   {
    return "";
   }
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
 }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>用户组选择面板</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/ >
<style type="text/css">
body{word-wrap:break-word;margin:0px;padding:0px;font:12px/18px Tahoma,Verdana,Arial,\5b8b\4f53;}
button,input,select,textarea{font-size:13px}
table{word-wrap:break-word;word-break:break-all}
p{padding:0 0 0 0;margin:0 0 0 0;}
td,div{font-size:9pt;color:#000000;font-family:宋体,Arial;}
a{color:#000000;text-decoration:none;}
a:hover{color:#000000;text-decoration: none;}
.table_style{
	border-width: 1px;
	border-left-style: solid;
	border-right-style: solid;
	border-bottom-style: solid;
	border-top-style: solid;
	border-color:#808080;
        background-color:#D1EAFE;
}
.bt{border:1px solid #999;padding:0px 10px;height:20px;line-height:18px;cursor:pointer;font-size:12px;background-color:#ccc;color:#333}
.bt:hover{color:#666}
</style>
</head>
<body>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=99%>
 <tr>
<td valign=top align="left" style="padding:5px">
<table border=0 cellpadding=5 cellspacing=0 width=100%  align="center" id="Ftable"  title="鼠标双击选择" class="table_style">
 <tr>
   <td align=left>
   <select name="MemberType" id="MemberType" style="width:98%;height:300px" multiple>
<%=MemberTypeList%>
  </select>
<%if(IsMultiple=="1"){%><br>按住Ctrl键可实现多选或取消选择。<%}%>
  </td>
 </tr>
</table>
</td>
</tr>
</table>
<div align="center">
   <input type="button" name="Submit" value="确定" onclick="Get_Select()"  class="bt">&nbsp;&nbsp;&nbsp;
   <input type="button" name="Close"  value="关闭" onclick="parent.CloseDialog();" class="bt">
</div>
<script type="text/javascript">
var op_obj=parent.document.getElementById("<%=ObjId%>");
var obj=document.getElementById("MemberType");
var HasSelect="";
if(op_obj!=null)
 {
   for(var i=0;i<op_obj.options.length;i++)
     {
       HasSelect+=op_obj.options[i].value+",";
     }
   var AHasSelect=HasSelect.split(",");
   for(var k=0;k<AHasSelect.length;k++)
   {
    for(var i=0;i<obj.options.length;i++)
     {
         if(obj.options[i].value==AHasSelect[k])
          {
            obj.options[i].text=obj.options[i].text+"√";
          }
     }
   }

 }
function Get_Select()
 {
  if(op_obj==null){alert("id不存在");return;}
  var Ids=Get_SelectValue();
  var txt;
  if(Ids=="0")
   {
     //alert("请选择分类!");
     return;
   }
 var AIds=Ids.split(',');
 <%if(IsMultiple=="0"){%>
   clear_select(op_obj);
 <%}%>
  parent.load_ajaxdata("pa_member",Ids,"<%=ObjId%>","");
 <%if(Request.QueryString["autoclose"]=="true"){%>
    parent.CloseDialog();
 <%}%>
 }

function CheckRepeat(id)
 {
   for(var i=0;i<op_obj.options.length;i++)
     {
       if(op_obj.options[i].value==id)
        {
          return true;
        }
     }
  return false;
 }

function Get_SelectValue(id)
 {

   var ID="0";
   for(var i=0;i<obj.options.length;i++)
     {
       if(obj.options[i].selected)
       {
         if(!CheckRepeat(obj.options[i].value))
          {
           ID+=","+obj.options[i].value;
          }
       }
     }
   return ID.replace("0,","");
 }

function clear_select(obj)
 {
  if(obj.options.length==0){return;}
  for(i=0;i<obj.options.length;i++)
   {
    if(obj.options[i].value!="0" && obj.options[i].value!="")
     {
       obj.remove(i);
       clear_select(obj);
     }
   }
 }
</script>
</center>
</body>
</HTML>
