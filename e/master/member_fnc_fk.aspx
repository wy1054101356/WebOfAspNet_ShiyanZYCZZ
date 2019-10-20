<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
  OleDbConnection conn;
  int SiteId;
  string Operator;
  float fnc_ky,point_ky;
protected void Page_Load(Object src,EventArgs e)
   {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    Operator=YZ._UserName;
    SiteId=int.Parse(Request.Cookies["SiteId"].Value);
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    if(!Page.IsPostBack)
     {
      TheDate.Text=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
       conn.Open();
        Get_kyAmount();
       conn.Close();
     }
    Username.Text=Request.QueryString["username"];
  }

private void Get_kyAmount()
 {
   string User_Name=Request.QueryString["username"];
   string sql="select fnc_ky, point_ky from pa_member where username='"+Sql_Format(User_Name)+"'";
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=Comm.ExecuteReader();
   if(dr.Read())
    {
      fnc_ky=float.Parse(dr["fnc_ky"].ToString());
      point_ky=float.Parse(dr["point_ky"].ToString());
    } 
   dr.Close();
 }


protected void Data_Add(Object src,EventArgs e)
 {
   conn.Open();
   Get_kyAmount();

   string Fnc_type,Fnc_fk_amount,Fnc_fk_reason,Beizhu;
   Fnc_type=Request.Form["fnc_type"];
   Fnc_fk_amount=fnc_fk_amount.Text.Trim();
   Fnc_fk_reason=fnc_fk_reason.SelectedItem.Text;
   Beizhu=beizhu.Text;

   if(Fnc_type=="1" && !IsFloat(Fnc_fk_amount))
    {
      Lbl_Info.Text="出错，请输入有效的返款金额数值!";
      return;
    }
   if(Fnc_type=="2" && !IsNum(Fnc_fk_amount))
    {
      Lbl_Info.Text="出错，积分数值只能填写整数!";
      return;
    }

    Update_member_fnc(Fnc_type,Fnc_fk_amount);
    Update_fnc_list(Fnc_type,Fnc_fk_amount,Fnc_fk_reason,Beizhu);
   conn.Close();

   string Member=Username.Text;
   PageAdmin.Log log=new PageAdmin.Log();
   if(Fnc_type=="1")
    {
    log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"add",1,Operator,"返款(会员："+Member+"；金额："+Fnc_fk_amount.ToString()+")");
    Response.Write("<scri"+"pt type='text/javascript'>alert('返款成功!');location.href='finance_list.aspx?field=username&keyword="+Server.UrlEncode("="+Member)+"'</s"+"cript>");
    }
   else if(Fnc_type=="2")
    {
     log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"add",1,Operator,"返积分(会员："+Member+"；数量："+Fnc_fk_amount.ToString()+")");
     Response.Write("<scri"+"pt type='text/javascript'>alert('返积分成功!');location.href='point_list.aspx?field=username&keyword="+Server.UrlEncode("="+Member)+"'</s"+"cript>");
    }
   Response.End();
 }


private void Update_member_fnc(string Fnc_type,string Fnc_Amount)
 {
   string sql;
   if(Fnc_type=="1")
    {
      sql="update pa_member set fnc_fk=fnc_fk+"+float.Parse(Fnc_Amount)+",fnc_ky=fnc_ky+"+float.Parse(Fnc_Amount)+" where username='"+Sql_Format(Username.Text)+"'";
    }  
   else
    {
      sql="update pa_member set point_fk=point_fk+"+int.Parse(Fnc_Amount)+",point_ky=point_ky+"+int.Parse(Fnc_Amount)+" where username='"+Sql_Format(Username.Text)+"'";
    }
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   Comm.ExecuteNonQuery();

 }

private void Update_fnc_list(string Fnc_type,string Fnc_Amount,string fk_reason,string Beizhu)
 {
   string Dt=DateTime.Now.ToString();
   if(IsDate(TheDate.Text.Trim()))
     {
       Dt=TheDate.Text.Trim();
     }
   string sql="insert into pa_fnc_list(site_id,thetype,username,act,amount,detail,beizhu,operator,thedate,[state],detail_id) values("+SiteId+","+int.Parse(Fnc_type)+",'"+Username.Text+"','f',"+float.Parse(Fnc_Amount)+",'"+Sql_Format(fk_reason)+"','"+Sql_Format(Beizhu)+"','"+Operator+"','"+Dt+"',1,0)";
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   Comm.ExecuteNonQuery();
 }

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
 }

private bool IsDate(string str)
 {
  //日期
  if(System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str), @"^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-9]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$"))
   {
     return true;
   }
  else
   {
    //日期+时间
    return System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str), @"^(((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d)$");
   }
 }


private bool IsFloat(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789.";
  if((str.Length-str.Replace(".",String.Empty).Length)>1)
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

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789";
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
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>会员返款</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" onsubmit="return ck()">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="location.href='member_info.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">会员信息</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_rk.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">入款/充积分</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_xf.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">扣款/扣积分</li>
<li id="tab" name="tab" style="font-weight:bold">返款/返积分</li>
</ul>
</div>
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
 <table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
      <tr>
        <td align="left" width="10%">操作类型</td><td lign="left"><input type="radio" name="fnc_type" id="fnc_type" value=1 checked onclick="c_type()">财务操作 <input type="radio" name="fnc_type" id="fnc_type" value=2 onclick="c_type()">积分操作</td>
     </tr>
      <tr>
        <td align="left" width="10%">用户名</td><td lign="left"><asp:TextBox Id="Username" runat="server" size="15" Maxlength="16" Enabled="false" /></td>
     </tr>
      <tr>
        <td align="left" width="10%"><span id="fk_title">返款金额</span></td><td lign="left"><asp:TextBox Id="fnc_fk_amount" runat="server" size="15" Maxlength="10" /> <span id="kytip"></span></td>
     </tr>
      <tr>
        <td align="left" width="10%"><span id="fk_reason">返款事由</span></td>
        <td lign="left"><asp:DropDownList id="fnc_fk_reason" runat="server">
            <asp:ListItem>返点</asp:ListItem>
            <asp:ListItem>奖励</asp:ListItem>
            <asp:ListItem>优惠</asp:ListItem> 
            <asp:ListItem>其他</asp:ListItem>
          </asp:DropDownList></td>
     </tr>

     <tr>
        <td align="left" width="10%">发生日期</td>
        <td lign="left"><asp:TextBox id="TheDate" runat="server" Maxlength="50" style="width:150px" /><a href="javascript:open_calendar('TheDate',1)"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> </td>
     </tr>

      <tr>
        <td align="left" width="10%">备注</td><td lign="left"><asp:TextBox Id="beizhu" runat="server" TextMode="multiline" Columns="50" rows="5" /></td>
     </tr>
   </table>

  </td>
  <tr>
 </table>
<br>
<asp:Label id="Lbl_Info" runat="server" Lbl_Error/><br>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
<td height=25 align=center >
<asp:Button  Cssclass=button   text="确定"   runat="server" onclick="Data_Add"/>
<input type="button" class=button  value="返回"  onclick="history.back()">
</td>
 </tr>
</table>
</form>
</td>
</tr>
</table>
</center>
<script type='text/javascript'>
var fnc_ky=<%=fnc_ky%>;
var point_ky=<%=point_ky%>;
var obj_kytip=document.getElementById("kytip");
obj_kytip.innerHTML="用户账户金额："+fnc_ky;

function c_type()
 {
   var type=document.getElementsByName("fnc_type");
   var fk_title=document.getElementById("fk_title");
   var fk_reason=document.getElementById("fk_reason");
   if(type[0].checked)
    {
      fk_title.innerHTML="返款金额";
      fk_reason.innerHTML="返款事由";
      obj_kytip.innerHTML="用户账户金额："+fnc_ky;
    }
   else
    {
      fk_title.innerHTML="返积分数";
      fk_reason.innerHTML="返积分事由";
      obj_kytip.innerHTML="用户账户积分："+point_ky;
    }
 }
function ck()
 {
   var type=document.getElementsByName("fnc_type");
   var amount=document.getElementById("fnc_fk_amount").value;
   if(amount=="" || amount=="0" || isNaN(amount))
    {
      alert("请输入有效数值!");
      document.getElementById("fnc_fk_amount").focus();
      return false;
    }

   if(type[1].checked && amount.indexOf(".")>=0 )
    {
      alert("积分数值必须填写整数!");
      document.getElementById("fnc_fk_amount").focus();
      return false;
    }

   var fnc_xf_thedate=document.getElementById("TheDate");
   if(fnc_xf_thedate.value=="")
    {
      alert("请输入发生日期!");
      fnc_xf_thedate.focus();
      return false;
    }

   if(type[0].checked)
    {
      if(confirm("此操作将返款"+amount+"元，是否确定?"))
       {
          return true;
       }
    }
   else 
    {
      if(confirm("此操作将返"+amount+"积分，是否确定?"))
       {
          return true;
       }
    }
   return false;
 }
</script>
</body>
</html>
