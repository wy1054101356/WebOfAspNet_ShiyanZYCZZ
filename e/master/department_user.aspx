<% @ Page language="c#" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string OpenerId,Type,DepartMentList,Department,UserList,Sql_Condition,TheTitle,sql,DepartmentIds;
 OleDbConnection conn;
 public void Page_Load(Object src,EventArgs e)
  {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    Type=Request.QueryString["type"];
    Sql_Condition=Request.QueryString["condition"];
    TheTitle=Request.QueryString["title"];
    OpenerId=Request.QueryString["id"];

    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    conn.Open();

     if(IsNum(Request.QueryString["did"]) )
        {
          DepartmentIds=Get_SubDepartment(int.Parse(Request.QueryString["did"]));
          if(IsNum(DepartmentIds))
           {
            sql="select id,department_id,username,truename from pa_member where department_id="+DepartmentIds+" "+Sql_Condition;
           }
          else  
           {
            sql="select id,department_id,username,truename from pa_member where department_id>0 and department_id in("+DepartmentIds+") "+Sql_Condition;
           }
        }
       else
        {
          sql="select id,department_id,username,truename from pa_member where department_id>0 "+Sql_Condition;
        }
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr= comm.ExecuteReader();
      while(dr.Read())
       {
        if(Type=="select")
         {
          UserList+="<option value='"+dr["id"].ToString()+"'>"+Get_Department(dr["department_id"].ToString())+dr["username"].ToString()+"&lt;"+dr["truename"].ToString()+"&gt;</option>\r\n";
         }
        else
         {
          UserList+="<option value='"+dr["username"].ToString()+"'>"+Get_Department(dr["department_id"].ToString())+dr["username"].ToString()+"&lt;"+dr["truename"].ToString()+"&gt;</option>\r\n";
         }
       }
     dr.Close();
     Department_list(0);
     conn.Close();
  }

private string Get_SubDepartment(int DepartmentId)
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
   string sql="select id,parent_id,name,xuhao,list_level from pa_department where parent_id="+Parentid+" order by xuhao,id";
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
     DepartMentList+="<option  value='"+dr["id"].ToString()+"'>"+List_Space+dr["name"].ToString()+"</option>\r\n";
     Department_list(int.Parse(dr["id"].ToString()));
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
       rv=dr["name"].ToString()+":";
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
<title><%=TheTitle%></title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/ >
<style type=text/css>
body,div,ul,li,table,p,form,legend,fieldset,input button,select,textarea,button{margin:0px;padding:0px;font-family:inherit;font-size:inherit;}
ul,li{list-style:none;}
table{border-collapse:collapse;border-spacing:0;}
a{color:#333333;text-decoration:none;}
a:hover{color:#CC0000;text-decoration:none;}
body{word-wrap:break-word;text-align:center;font:12px/20px Verdana,Helvetica,Arial,sans-serif;color:#333333;}

#Ftable{border:1px solid #D1EAFE;margin-top:10px}
#Ftable td{border:1px solid #D1EAFE;padding:3px 0 3px 10px}
.bt{width:55px;font-size:9pt;height:19px;cursor:pointer;background-image:url(/e/images/public/button.gif);background-position: center center;border-top: 0px outset #eeeeee;border-right: 0px outset #888888;border-bottom: 0px outset #888888;border-left: 0px outset #eeeeee;padding-top: 2px;background-repeat: repeat-x;}
</style>
</head>
<body>
<center>
<table border=1 cellpadding=0 cellspacing=0 width=95%  align="center" id="Ftable"  title="鼠标双击选择">
 <tr>
   <td align=left>选择部门：
<select name="DepartMent" id="DepartMent" onchange="Go(this.options[this.selectedIndex].value)">
<option value="">所有部门</option>
<%=DepartMentList%>
</select>
</td>
 </tr>

 <tr>
   <td align=left>
   <select name="F_Name" id="F_Name" style="width:98%;height:250px" multiple ondblclick="Get_User()">
<%=UserList%>
  </select>
  </td>
 </tr>

 <tr>
   <td height="25px" align=center>
   <input type="button" name="Submit" value="确定" onclick="Get_User()"  class="bt">&nbsp;&nbsp;&nbsp;
   <input type="button" name="Close"  value="关闭" onclick="parent.CloseDialog();" class="bt">
  </td>
 </tr>
</table>

<script type="text/javascript">
var OpenerType="<%=Request.QueryString["type"]%>";
var Did="<%=Request.QueryString["did"]%>";
if(Did!="0")
 {
  document.getElementById("DepartMent").value=Did;
 }
var P_obj=parent.document.getElementById("<%=OpenerId%>");
function Go(D)
 {
  var u="?id="+escape("<%=OpenerId%>")+"&type="+escape("<%=Type%>")+"&condition="+escape("<%=Sql_Condition%>")+"&title="+escape("<%=TheTitle%>")+"&did="+D;
  location.href=u;
 }

function Get_User()
 {
  switch(OpenerType)
   {
     case "select":
      Add_Select();
     break;

     case "text":
      Add_Text();
      parent.CloseDialog();
     break;

   }
 }

function Add_Text()
 {
   var Obj=document.getElementById("F_Name");
   for(k=0;k<Obj.length;k++)
     {   
      if(Obj.options[k].selected)
      {
       P_obj.value=Obj.options[k].value;
      }
     }

 }

function Add_Select()
 {
   var Obj=document.getElementById("F_Name");
   for(k=0;k<Obj.length;k++)
     {   
      if(Obj.options[k].selected)
      {
        if(!CheckRepeat(Obj.options[k].value))
         {
           parent.AddSelect(Obj.options[k].text,Obj.options[k].value,"<%=Request.QueryString["id"]%>");
         }
      }
     }
 }

function CheckRepeat(id)
 {
   for(i=0;i<P_obj.length;i++)
     {
       if(P_obj[i].value==id)
        {
          return true;
        }
     }
  return false;
 }
</script>
</center>
</body>
</HTML>
