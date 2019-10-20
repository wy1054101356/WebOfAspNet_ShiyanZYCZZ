<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.Text.RegularExpressions"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
  OleDbConnection conn;
  string Show_Style,LoginName,ToUrl,ShowReg,UserName,UserType,Id,SiteId,Show_Code,msg_icon_show,order_cart_show,HasLogin;
  string sql;
 protected void Page_Load(Object sender,EventArgs e)
   {
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     Id=Request.QueryString["id"];
     if(IsNum(Id))
      {
      conn.Open();
        Get_Data();
        Get_NewMsg();
        Get_Order();
      conn.Close();
      }
     else
      {
       Id="0";
       Response.End();
      }
   }

private void Get_Data()
 {
   HasLogin="0";
   if(Request.Cookies["Member"]!=null)
     {
      if(Request.Cookies["Member"].Values["UID"]==null || Request.Cookies["Member"].Values["Valicate"]==null)
       {
         return;
       }
      else
       {
         if(!IsNum(Request.Cookies["Member"].Values["UID"].ToString()))
          {
            return;
          }
       }
       Member_Valicate Member=new Member_Valicate();
       Member.Member_Check(false,0);
       UserName=Member._UserName;
       UserType=Get_TypeName(Member._MemberTypeId);
       HasLogin="1";
     }
  int TheId=int.Parse(Id);
  sql="select site_id,login_text,code,tourl,showreg,style from pa_loginbox where id="+TheId;
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read())
   {
     SiteId=dr["site_id"].ToString();
     LoginName=dr["login_text"].ToString();
     Show_Code=dr["code"].ToString();
     ToUrl=dr["tourl"].ToString();
     ShowReg=dr["showreg"].ToString();
     Show_Style=dr["style"].ToString();
   }
  dr.Close();
 }

private string Get_TypeName(int Id)
 {
     sql="select name from pa_member_type where id="+Id;
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr= comm.ExecuteReader();
     if(dr.Read())
      {
        return dr["name"].ToString();
      }  
     else
      {
       return "";
      }
  dr.Close();
 }

private void Get_NewMsg()
 {
     sql="select id from pa_msg_inbox where receiver='"+UserName+"' and readed=0";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr= comm.ExecuteReader();
     if(dr.Read())
      {
        msg_icon_show="1";
      }  
     else
      {
        msg_icon_show="0";
      }
     dr.Close();
 }

private void Get_Order()
 {
     sql="select id from pa_orderlist where username='"+UserName+"' and state=0";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr= comm.ExecuteReader();
     if(dr.Read())
      {
        order_cart_show="1";
      }  
     else
      {
        order_cart_show="0";
      }
   dr.Close();
 }

protected string Get_Url(string Type)
  {
     return "/e/member/index.aspx?type="+Type+"&s="+SiteId;
  }

private bool IsUserName(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  Regex re = new Regex(@"[\u4e00-\u9fa5]+");
  str=re.Replace(str,"");
  if(str.Length==0){return true;}
  else{return IsStr(str);}
 }

private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  string str2=str.ToLower();;
  for(int i=0;i<str2.Length;i++)
   {
    if(str1.IndexOf(str2[i])==-1)
     {
       return false;
     }
   }
  return true;
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
function LoadLoginBox_<%=Id%>()
{
var LoginBoxHtml="<form name='loginbox_<%=Id%>' method='post'>";
LoginBoxHtml+="<input type='hidden' name='login' value='yes'>";
LoginBoxHtml+="<input type='hidden' name='To_Url' value='<%=ToUrl%>'>";
LoginBoxHtml+="<input type='hidden' name='LoginBox_Id' value='<%=Id%>'>";
<%if (Show_Style=="0"){
if(HasLogin=="0"){
%>
LoginBoxHtml+="<ul>";
LoginBoxHtml+="<li class='loginbox_item'>用户名：<input type='textbox' name='username' class='loginbox_textbox' maxlength='16'></li>";
LoginBoxHtml+="<li class='loginbox_item'>密&nbsp;&nbsp;&nbsp;码：<input type='password' name='password' class='loginbox_textbox' maxlength='16'></li>";
<%if(Show_Code=="1"){%>LoginBoxHtml+="<li class='loginbox_item'>验证码：<input type='textbox' name='vcode' class='loginbox_textbox_yzm' maxlength='4'>&nbsp;<img src='/e/aspx/yzm.aspx' onclick=\"Code_Change('yzcode_<%=Id%>')\"  align=absmiddle border=0 id='yzcode_<%=Id%>'  alt='点击更换' style='cursor:pointer;height:20px' ></li>";<%}%>
LoginBoxHtml+="<li class='loginbox_item'>&nbsp;&nbsp;<%if(ShowReg=="1"){%><a href='<%=Get_Url("reg")%>'>注册会员</a><%}%>&nbsp;&nbsp;<input type='submit' value='<%=LoginName%>' class='loginbox_submit' onclick='return LoginBox(<%=Id%>,<%=SiteId%>)'></li>";
LoginBoxHtml+="</ul>";
<%
 }
else
{
%>
LoginBoxHtml+="会员名：<%=UserName%><%if(msg_icon_show=="1"){%><a href='<%=Get_Url("mem_msg")%>'><img src='/e/images/public/message.gif' border=0 width=20px height=17px></a><%}%><br>";
LoginBoxHtml+="类&nbsp;&nbsp;&nbsp;别：<%=UserType%><br>";
LoginBoxHtml+="<a href='<%=Get_Url("mem_idx")%>' class='logined_href'>会员中心</a>&nbsp;&nbsp; <%if(order_cart_show=="1"){%><a href=# onclick=\"ordercart('<%=SiteId%>','')\" class='logined_href'>购物车</a>&nbsp;&nbsp; <%}%><a href='<%=Get_Url("exit")%>' class='logined_href'>注销退出</a>";
<%
 }
}
else
 {
 if(HasLogin=="0")
  {
%>
LoginBoxHtml+="用户名：<input type='textbox' name='username' class='loginbox_textbox' maxlength='16'>";
LoginBoxHtml+="&nbsp;&nbsp;密码：<input type='password' name='password' class='loginbox_textbox' maxlength='16'>";
<%if(Show_Code=="1"){%>LoginBoxHtml+="&nbsp;&nbsp;验证码：<input type='textbox' name='vcode' class='loginbox_textbox_yzm' maxlength='4'>&nbsp;<img src='/e/aspx/yzm.aspx' onclick=\"Code_Change('yzcode_<%=Id%>')\" align=absmiddle border=0 id='yzcode_<%=Id%>' style='cursor:pointer;height:20px' >";<%}%>
LoginBoxHtml+="&nbsp;&nbsp;<input type='submit' value='<%=LoginName%>' class='loginbox_submit' onclick='return LoginBox(<%=Id%>,<%=SiteId%>)'><%if(ShowReg=="1"){%>&nbsp;&nbsp;<a href='<%=Get_Url("reg")%>'>注册会员</a><%}%>";
<%
 }
else
{
%>
LoginBoxHtml+="会员名：<%=UserName%><%if(msg_icon_show=="1"){%><a href='<%=Get_Url("mem_msg")%>'><img src='/e/images/public/message.gif' border=0 width=20px height=17px></a><%}%>&nbsp;&nbsp;";
LoginBoxHtml+="类别：<%=UserType%>&nbsp;&nbsp;";
LoginBoxHtml+="<a href='<%=Get_Url("mem_idx")%>' class='logined_href'>会员中心</a>&nbsp;&nbsp;<%if(order_cart_show=="1"){%><a href=# onclick=\"ordercart('<%=SiteId%>','')\" class='logined_href'>购物车</a>&nbsp;&nbsp;<%}%><a href='<%=Get_Url("exit")%>' class='logined_href'>注销退出</a>";
<%
 }
}
%>
LoginBoxHtml+="</form>";
document.write("<div class='loginbox'>"+LoginBoxHtml+"</div>");
}
LoadLoginBox_<%=Id%>();