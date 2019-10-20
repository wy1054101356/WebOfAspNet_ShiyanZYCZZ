<% @ Page language="c#" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">

 string Sorts,Friends,UserName;
 int sid;
 OleDbConnection conn;
 public void Page_Load(Object src,EventArgs e)
  {
     Member_Valicate MCheck=new Member_Valicate();
     MCheck.Member_Check();
     UserName=MCheck._UserName;
     string sql;
     Conn Myconn=new Conn();
     string constr=Myconn.Constr();
     conn=new OleDbConnection(constr);
     conn.Open();
      if(IsNum(Request.QueryString["sid"]))
        {
          sid=int.Parse(Request.QueryString["sid"]);
          sql="select friend_username,friend_beizhu from pa_friends where owner='"+UserName+"' and friend_sort="+sid;
        }
       else
        {
         sql="select friend_username,friend_beizhu from pa_friends where owner='"+UserName+"'";
        }
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr= comm.ExecuteReader();
      while(dr.Read())
       {
         Friends+="<option value='"+dr["friend_username"].ToString()+"'>"+dr["friend_username"].ToString()+"&lt;"+dr["friend_beizhu"].ToString()+"&gt;</option>\r\n";
       }
     sql="select id,sort_name from pa_friends_sort where owner='"+UserName+"'order by xuhao";
     comm=new OleDbCommand(sql,conn);
     dr= comm.ExecuteReader();
     while(dr.Read())
       {
         Sorts+="<option value='"+dr["id"].ToString()+"'>"+dr["sort_name"].ToString()+"</option>\r\n";
       }

     conn.Close();
  }

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="1234567890";
  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>选择收件人</title>
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

#Ftable{border:1px solid #eeeeee}
#Ftable td{border:1px solid #eeeeee;padding:3px 0 3px 10px}

.bt{width:55px;font-size:9pt;height:19px;cursor:pointer;background-image:url(/e/images/public/button.gif);background-position: center center;border-top: 0px outset #eeeeee;border-right: 0px outset #888888;border-bottom: 0px outset #888888;border-left: 0px outset #eeeeee;padding-top: 2px;background-repeat: repeat-x;}
</style>
</head>
<body>
<center>
<table border=1 cellpadding=5 cellspacing=0 width=98%  align="center" id="Ftable">
 <tr>
   <td align=left><select name="F_Sort" id="F_Sort" onchange="location.href='?sid='+this.options[this.selectedIndex].value">
<option value="0">===好友分类显示===</option>
<%=Sorts%>
</select>
</td>
 </tr>

 <tr>
   <td align=left>
   <select name="F_Name" size="16" id="F_Name" style="width:220px" multiple>
<%=Friends%>
  </select>
  </td>
 </tr>

 <tr>
   <td height="25px" align=center>
   <input type="button" name="Submit" value="确定" onclick="Get_Friends();"  class="bt">&nbsp;&nbsp;&nbsp;
   <input type="button" name="Close"  value="取消" onclick="wclose()" class="bt">
  </td>
 </tr>
</table>

<script type="text/javascript">
document.getElementById("F_Sort").value="<%=sid%>";
function Get_Friends()
 {
   var Receivers="";
   var Obj=document.getElementById("F_Name");
   for(i=0;i<Obj.length;i++)
     {   
      if(Obj.options[i].selected)
      {
         Receivers+=Obj.options[i].value+",";
      }
     }
   if(Receivers!="")
    {
      parent.document.getElementById("fb_receiver").value=Receivers.substring(0,Receivers.length-1);
    }
   wclose();
 }
function wclose()
 {
  parent.CloseDialog();
 }
</script>
</center>
</body>
</HTML>
