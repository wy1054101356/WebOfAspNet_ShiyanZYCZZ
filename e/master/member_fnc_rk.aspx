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
    else
     {

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

   string Fnc_type,Fnc_rk_amount,Fnc_rk_way,Fnc_rk_beizhu;
   Fnc_type=Request.Form["fnc_type"];
   Fnc_rk_amount=fnc_rk_amount.Text.Trim();
   Fnc_rk_way=fnc_rk_way.SelectedItem.Value;
   Fnc_rk_beizhu=beizhu.Text;
   if(Fnc_type=="1" && !IsFloat(Fnc_rk_amount))
    {
      Lbl_Info.Text="出错，请输入有效的金额数值!";
      return;
    }
   if(Fnc_type=="2" && !IsNum(Fnc_rk_amount))
    {
      Lbl_Info.Text="出错，请输入有效的积分数字，只能输入整数!";
      return;
    }
   Update_member_fnc(Fnc_type,Fnc_rk_amount);
   Update_fnc_list(Fnc_type,Fnc_rk_amount,Fnc_rk_way,Fnc_rk_beizhu);
   conn.Close();
   string Member=Username.Text;
   PageAdmin.Log log=new PageAdmin.Log();
   if(Fnc_type=="1")
    {
     log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"add",1,Operator,"入款(会员："+Member+"；金额："+Fnc_rk_amount.ToString()+")");
     Response.Write("<scri"+"pt type='text/javascript'>alert('入款成功!');location.href='finance_list.aspx?field=username&keyword="+Server.UrlEncode("="+Member)+"'</s"+"cript>");
    }
   else if(Fnc_type=="2")
    {
    log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"add",1,Operator,"充积分(会员："+Member+"；数量："+Fnc_rk_amount.ToString()+")");
    Response.Write("<scri"+"pt type='text/javascript'>alert('积分充值成功!');location.href='point_list.aspx?field=username&keyword="+Server.UrlEncode("="+Member)+"'</s"+"cript>");
    }
   Response.End();
 }


private void Update_member_fnc(string Fnc_type,string Fnc_Amount)
 {
   string sql;
   if(Fnc_type=="1")
    {
      sql="update pa_member set fnc_rk=fnc_rk+"+float.Parse(Fnc_Amount)+",fnc_ky=fnc_ky+"+float.Parse(Fnc_Amount)+"  where username='"+Sql_Format(Username.Text)+"'";
    }
   else
    {
      sql="update pa_member set point_rk=point_rk+"+int.Parse(Fnc_Amount)+",point_ky=point_ky+"+int.Parse(Fnc_Amount)+"  where username='"+Sql_Format(Username.Text)+"'";
    }
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   Comm.ExecuteNonQuery();
 }

private void Update_fnc_list(string Fnc_type,string Fnc_Amount,string Rk_way,string Beizhu)
 {
   if(Fnc_type=="2")
    {
      Rk_way="系统充值";
    }
   string Dt=DateTime.Now.ToString();
   if(IsDate(TheDate.Text.Trim()))
     {
       Dt=TheDate.Text.Trim();
     }
   string sql="insert into pa_fnc_list(site_id,thetype,username,act,amount,detail,beizhu,operator,thedate,[state],detail_id) values("+SiteId+","+int.Parse(Fnc_type)+",'"+Sql_Format(Username.Text)+"','c',"+float.Parse(Fnc_Amount)+",'"+Sql_Format(Rk_way)+"','"+Sql_Format(Beizhu)+"','"+Operator+"','"+Dt+"',1,0)";
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
<aspcn:uc_head runat="server" Type="member_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>汇款入帐</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" onsubmit="return ck()">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="location.href='member_info.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">会员信息</li>
<li id="tab" name="tab"  style="font-weight:bold">入款/充积分</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_xf.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">扣款/扣积分</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_fk.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">返款/返积分</li>
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
        <td align="left" width="10%"><span id="rk_title">入账金额</span></td><td lign="left"><asp:TextBox Id="fnc_rk_amount" runat="server" size="15" Maxlength="15" /> <span id="kytip"></span></td>
     </tr>
      <tr id="rk_way">
        <td align="left" width="10%">汇款方式</td>
        <td lign="left">
         <asp:DropDownList id="fnc_rk_way" runat="server">
               <asp:ListItem>建设银行</asp:ListItem> 
                <asp:ListItem>邮政汇款</asp:ListItem>
                <asp:ListItem>工商银行</asp:ListItem>
                <asp:ListItem>中国银行</asp:ListItem>
                <asp:ListItem>农业银行</asp:ListItem>
                <asp:ListItem>招商银行</asp:ListItem>  
                <asp:ListItem>交通银行</asp:ListItem>  
                <asp:ListItem>在线支付</asp:ListItem> 
                <asp:ListItem>公司帐号</asp:ListItem>
                <asp:ListItem>现金支付</asp:ListItem>
                <asp:ListItem>其它方式</asp:ListItem>
          </asp:DropDownList>
        </td>
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
<td height=25 align=center>
<asp:Button Cssclass=button  text="确定"  runat="server" onclick="Data_Add"/>
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
   var rk_title=document.getElementById("rk_title");
   var rk_way=document.getElementById("rk_way");
   if(type[0].checked)
    {
      rk_title.innerHTML="入账金额";
      rk_way.style.display="";
      obj_kytip.innerHTML="用户账户金额："+fnc_ky;
    }
   else
    {
      rk_title.innerHTML="入账积分数";
      rk_way.style.display="none";
      obj_kytip.innerHTML="用户账户积分："+point_ky;
    }
 }

function ck()
 {
   var type=document.getElementsByName("fnc_type");
   var amount=document.getElementById("fnc_rk_amount").value;
   if(amount=="" || amount=="0" || isNaN(amount))
    {
      alert("请输有效的数值!");
      document.getElementById("fnc_rk_amount").focus();
      return false;
    }

  if(type[1].checked && amount.indexOf(".")>=0 )
    {
      alert("积分数值必须填写整数!");
      document.getElementById("fnc_rk_amount").focus();
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
      if(confirm("入款金额数为："+amount+"，是否确定?"))
       {
          return true;
       }
    }
   else 
    {
      if(confirm("充值积分数为："+amount+"，是否确定?"))
       {
          return true;
       }
    }
   return false;
 }
</script>
</body>
</html>  



