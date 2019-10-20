<% @ Page language="c#" %><!DOCTYPE html>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string ObjId,ValueType,SelectType,IsMultiple,DepartMentList,MemberTypeList,Department,UserList,Sql_Condition,sql,CurrentId;
 OleDbConnection conn;
 public void Page_Load(Object src,EventArgs e)
  {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    ValueType=Request.QueryString["valuetype"]; //0表示返回id，1表示返回username
    SelectType=Request.QueryString["selecttype"]; //0表示按部门列出数据，1表示按会员类别列出数据
    Sql_Condition=Request.QueryString["condition"];
    ObjId=Request.QueryString["objid"];
    IsMultiple=Request.QueryString["ismultiple"];
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    if(SelectType=="0")
     {
       ListFormDepartment();
     }
    else
     {
       ListFormMemberType();
     }
  }

 private void ListFormDepartment() //根据部门分类列出
   {
    conn.Open();
    if(IsNum(Request.QueryString["currentid"]) )
        {
          CurrentId=Get_SubDepartment(Request.QueryString["currentid"]);
          if(IsNum(CurrentId))
           {
            sql="select id,department_id,username,truename from pa_member where checked=1 and department_id="+CurrentId+" "+Sql_Condition;
           }
          else  
           {
            sql="select id,department_id,username,truename from pa_member where checked=1 and  department_id>0 and department_id in("+CurrentId+") "+Sql_Condition;
           }
        }
       else
        {
          sql="select id,department_id,username,truename from pa_member where checked=1 and  department_id>0 "+Sql_Condition;
        }
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr= comm.ExecuteReader();
      while(dr.Read())
       {
        if(ValueType=="0")
         {
          UserList+="<option value='"+dr["id"].ToString()+"'>"+Get_Department(dr["department_id"].ToString())+dr["username"].ToString()+"</option>";
         }
        else
         {
          UserList+="<option value='"+dr["username"].ToString()+"'>"+Get_Department(dr["department_id"].ToString())+dr["username"].ToString()+"</option>";
         }
       }
     dr.Close();
     Department_list(0);
     conn.Close();
   }

 private void ListFormMemberType() //根据会员分类列出
   {
    conn.Open();
    if(IsNum(Request.QueryString["currentid"]) )
      {
        CurrentId=Request.QueryString["currentid"];
        sql="select id,department_id,username,truename from pa_member where checked=1 and mtype_id="+int.Parse(CurrentId)+" "+Sql_Condition;
      }
    else
      {
        sql="select id,mtype_id,username,truename from pa_member where checked=1 "+Sql_Condition;
      }
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr= comm.ExecuteReader();
      while(dr.Read())
       {
        if(ValueType=="0")
         {
          UserList+="<option value='"+dr["id"].ToString()+"'>"+Get_MemberType(dr["mtype_id"].ToString())+dr["username"].ToString()+"</option>";
         }
        else
         {
          UserList+="<option value='"+dr["username"].ToString()+"'>"+Get_MemberType(dr["mtype_id"].ToString())+dr["username"].ToString()+"</option>";
         }
       }
     dr.Close();
     MemberType_list();
     conn.Close();
   }

private string Get_SubDepartment(string DepartmentId)
 {
     string Ids=DepartmentId.ToString(); 
     string sql="select id from pa_department where parent_ids like '%,"+DepartmentId+",%'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     while(dr.Read())
      {
        Ids+=","+dr["id"].ToString();
      }
    dr.Close();
    return Ids;
 }

private void Department_list(int Parentid)
 {
   string List_Space="";
   int List_Level=1;
   string sql="select id,parent_id,name,xuhao,list_level from pa_department where parent_id="+Parentid+" order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      List_Space="";
      List_Level=int.Parse(dr["list_level"].ToString());
      for(int i=0;i<List_Level-1;i++)
      {
       List_Space+="&nbsp;&nbsp;";
      }
     if(List_Level>1)
     {
       List_Space+="|-";
     }
     DepartMentList+="<option value='"+dr["id"].ToString()+"'>"+List_Space+dr["name"].ToString()+"</option>\r\n";
     Department_list(int.Parse(dr["id"].ToString()));
    }
   dr.Close();
 }  

private void MemberType_list()
 {
   string sql="select id,name from pa_member_type  order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
     MemberTypeList+="<option value='"+dr["id"].ToString()+"'>"+dr["name"].ToString()+"</option>\r\n";
    }
   dr.Close();
 }  

private string  Get_Department(string departmentid)
 {
   string rv="";
   string sql="select name from pa_department where id="+int.Parse(departmentid);
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
     {
       rv="【"+dr["name"].ToString()+"】";
     }
   dr.Close();
   return rv;
 }  


private string  Get_MemberType(string membertypeid)
 {
   string rv="";
   string sql="select name from pa_member_type where id="+int.Parse(membertypeid);
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
     {
       rv="【"+dr["name"].ToString()+"】";
     }
   dr.Close();
   return rv;
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
<title>用户选择面板</title>
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
.bt{border:1px solid #ccc;padding:0px 10px;height:20px;line-height:18px;cursor:pointer;margin:1px 0px;font-size:12px;background-color:#fff;color:#333}
.bt:hover{border-color:#FF9900;background-color:#FF9900;color:#fff}
</style>
</head>
<body>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=99%>
 <tr>
<td valign=top align="left" style="padding:5px">
<table border=0 cellpadding=5 cellspacing=0 width=100%  align="center" id="Ftable"  title="鼠标双击选择" class="table_style">
 <tr style="display:<%=SelectType=="0"?"":"none"%>">
   <td align=left>选择部门：
<select name="DepartMent" id="DepartMent" onchange="Go(this.options[this.selectedIndex].value)">
<option value="">所有部门</option>
<%=DepartMentList%>
</select>
</td>
 </tr>
 <tr style="display:<%=SelectType=="0"?"none":""%>">
   <td align=left>选择用户组：
<select name="MemberType" id="MemberType" onchange="Go(this.options[this.selectedIndex].value)">
<option value="">所有用户组</option>
<%=MemberTypeList%>
</select>
</td>
 </tr>
 <tr>
   <td align=left>
   <select name="F_UserName" id="F_UserName" style="width:98%;height:300px" multiple>
<%=UserList%>
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
var op_obj_nodetype=op_obj.nodeName.toLowerCase();
var SelectType="<%=SelectType%>";
var CurrentId="<%=CurrentId%>";
if(SelectType=="0")
 {
   document.getElementById("DepartMent").value=CurrentId;
 }
else
 {
   document.getElementById("MemberType").value=CurrentId;
 }

var obj=document.getElementById("F_UserName");
var HasSelect="";
if(op_obj!=null && op_obj_nodetype=="select")
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
    <%if(Request.QueryString["autoclose"]=="true"){%>
    parent.CloseDialog();
    <%}%>
     return;
   }
 var AIds=Ids.split(',');
 if(op_obj_nodetype=="input")
  {
     op_obj.value=Ids;
  }
 else
  {
   <%if(IsMultiple=="0"){%>clear_select(op_obj);<%}%>
  if(SelectType=="0")
   {
    parent.load_ajaxdata("pa_member",Ids,"<%=ObjId%>","department");
   }
  else if(SelectType=="1")
   {
    parent.load_ajaxdata("pa_member",Ids,"<%=ObjId%>","membertype");
   }
  else
  {
    parent.load_ajaxdata("pa_member",Ids,"<%=ObjId%>","");
   }
 }
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

function Get_SelectValue()
 {

   var ID="0";
   for(var i=0;i<obj.options.length;i++)
     {
       if(obj.options[i].selected)
       {
         if(op_obj_nodetype=="input")
          {
            return  obj.options[i].value;
          }
         else if(!CheckRepeat(obj.options[i].value))
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

function Go(currentid)
 {
  var u="?objid="+encodeURI("<%=ObjId%>")+"&valuetype="+encodeURI("<%=ValueType%>")+"&selecttype="+encodeURI("<%=SelectType%>")+"&condition="+encodeURI("<%=Sql_Condition%>")+"&ismultiple=<%=IsMultiple%>&autoclose=<%=Request.QueryString["autoclose"]%>&currentid="+encodeURI(currentid);
  location.href=u;
 }
</script>
</center>
</body>
</HTML>
