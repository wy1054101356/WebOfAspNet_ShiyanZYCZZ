<% @ Page language="c#" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string UserName,Id,fbk_username,fbk_date,Reply,sql;
 OleDbConnection conn;
 public void Page_Load(Object src,EventArgs e)
  {
    Member_Valicate Member=new Member_Valicate();
    Member.Member_Check();
    UserName=Member._UserName;
    string sql;
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();
    conn.Open();
    Id=Request.QueryString["id"];
    if(IsNum(Id))
     {
      if(Request.Form["post"]=="reply")
       {
         Add_Reply(int.Parse(Id));
       }
      else
       {
        Get_Data(int.Parse(Id));
       }
     }
    else
     {
      Response.Write("<"+"script type='text/javascript'>alert('无效的id!');parent.ymPrompt.close()</"+"script>");
      Response.End();
     }
    conn.Close();
  }

private void Get_Data(int Id)
 {
   sql="select fbk_username,fbk_date,reply from pa_spcfbk where id="+Id;
   OleDbCommand Comm=new  OleDbCommand(sql,conn);
   OleDbDataReader dr=Comm.ExecuteReader();
   if(dr.Read())
     {
       fbk_username=dr["fbk_username"].ToString();
       fbk_date=((DateTime)dr["fbk_date"]).ToString("yyyy-MM-dd HH:mm:ss");
       Reply=dr["reply"].ToString();
     }
   dr.Close();
 }

private void Add_Reply(int Id)
 {
   Reply=Request.Form["fb_reply"];
   string RDate=DateTime.Now.ToString();
   sql="update pa_spcfbk set [reply]='"+Sql_Format(Reply)+"',[reply_date]='"+RDate+"' where id="+Id+" and space_owner='"+Sql_Format(UserName)+"'";
   OleDbCommand Comm=new  OleDbCommand(sql,conn);
   Comm.ExecuteNonQuery();
   conn.Close();
   Response.Write("<"+"script type='text/javascript'>alert('回复成功!');parent.location.href=parent.location.href</"+"script>");
   Response.End();
 }

private string Get_TrueName(string UserName)
 {
     string TrueName="";
     sql="select truename from pa_member where username='"+UserName+"'";
     OleDbCommand Comm=new  OleDbCommand(sql,conn);
     OleDbDataReader dr=Comm.ExecuteReader();
     if(dr.Read())
     {
      TrueName=dr["truename"].ToString();
     }
    dr.Close();
    if(TrueName=="")
     {
      TrueName=UserName;
     }
   return TrueName;
 }

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>留言回复</title>
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

#Ftable{border:1px solid #E1F7FD}
#Ftable td{border:1px solid #E1F7FD;padding:3px 0 3px 10px}

.bt{width:70px;font-size:9pt;height:22px;cursor:pointer;background-image:url(/e/images/public/bt.gif);border-width:0px}
</style>
</head>
<body>
<table border=0 cellpadding="5px" cellspacing=0  align=center width="99%">
  <form name="f" method="post">
   <tr>
      <td height=20 align="left">回复用户：<%=fbk_username%> &nbsp;&nbsp;留言时间：<%=fbk_date%></td>
   <tr>
      <td align="left"><textarea id="fb_reply" name="fb_reply" style="width:420px;height:100px"><%=Reply%></textarea> 
    </td>
    </tr>
     <tr>
      <td height=20 align="center" colspan=2>
      <input type="hidden" value="reply" name="post" id="post">&nbsp;
      <input type="submit" value="回复"  class="bt" onclick="return ck()">&nbsp;
      <input type="button" value="关闭"  onclick="parent.CloseDialog()" class="bt">&nbsp;
     </td>
    </tr>
   </form>
 </table>
<script type="text/javascript">
var fb_reply=document.getElementById("fb_reply");
function ck()
{
 if(fb_reply.value=="")
  {
    alert("请输入回复内容!");
    fb_reply.focus();
    return false;
  }
 return true;
}
</script>
</body>
</HTML>
