<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="basic_tongji" />
<script language="c#" runat="server">
 string PYear,PMonth,UserName;
 int SiteId;
 OleDbConnection conn;
protected void Page_Load(Object src,EventArgs e)
 {
  Conn Myconn=new Conn();
  conn=Myconn.OleDbConn();//获取OleDbConnection
  if(!Page.IsPostBack) 
   {
      Master_Valicate YZ=new Master_Valicate();
      YZ.Master_Check();
      UserName=YZ._UserName;
      SiteId=int.Parse(Request.Cookies["SiteId"].Value);
      int NowYear=int.Parse(DateTime.Now.Year.ToString());
      for(int i=0;i<10;i++)
        {
          TheYear.Items.Add((NowYear-i).ToString());
        }
     if(Request.QueryString["year"]==null)
      {
       ViewState["CurrentYear"]=NowYear;
      }
     else
      {
       ViewState["CurrentYear"]=Request.QueryString["year"];
       TheYear.SelectedIndex=TheYear.Items.IndexOf(TheYear.Items.FindByText(Request.QueryString["year"]));
      }
      PYear=ViewState["CurrentYear"].ToString();

     if(Request.QueryString["month"]==null)
      {
       ViewState["CurrentMonth"]=DateTime.Now.Month;
      }
     else
      {
       ViewState["CurrentMonth"]=Request.QueryString["month"];
      }
      PMonth=ViewState["CurrentMonth"].ToString();

     PageAdmin.Log log=new PageAdmin.Log();
   //删除区域============================================================
     if(Request.QueryString["act"]=="delmonth")
      {
       int theyear=int.Parse(PYear);
       int themonth=int.Parse(PMonth);
       ViewState["del_sql"]="delete from pa_count where year([thedate])="+theyear+" and month([thedate])="+themonth+" and site_id="+SiteId;
       Data_Delete();
       log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"delete",1,UserName,"删除月流量记录("+theyear+"年"+themonth+"月)"); 
      }
     if(Request.QueryString["act"]=="delday")
      {
       int theyear=int.Parse(PYear);
       int themonth=int.Parse(PMonth);
       int theday=int.Parse(Request.QueryString["day"]);
       ViewState["del_sql"]="delete from pa_count where year([thedate])="+theyear+" and month([thedate])="+themonth+" and day([thedate])="+theday+" and site_id="+SiteId;
       Data_Delete();

       log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"delete",1,UserName,"删除日流量记录("+theyear+"年"+themonth+"月"+theday+")"); 
      }
    //删除区域============================================================
      Month_Bound();
      Day_Bound();
   }
  else 
   {
     SiteId=int.Parse(Request.Cookies["SiteId"].Value);
   }
 }

private void Month_Bound()
 {

  conn.Open();
  OleDbCommand Comm;
  OleDbDataReader Dr;
  string sql,Liuliang,ImageHeight;
  Label Lbl,Lbl1,Lbl2;
  int CurrentYear=int.Parse(ViewState["CurrentYear"].ToString());
  int CurrentMonth=int.Parse(ViewState["CurrentMonth"].ToString());
  int MC=int.Parse(M.Text);
  for(int i=1;i<=12;i++)
   {
    sql="select count(id) as co from pa_count where month([thedate])="+i+" and year([thedate])="+CurrentYear+" and isrobot=0 and site_id="+SiteId;
    Comm=new OleDbCommand(sql,conn);
    Dr=Comm.ExecuteReader(); 
    if(Dr.Read())
     {
      Liuliang=Dr["co"].ToString();
     }
   else
     {
      Liuliang="0";
     }
    ImageHeight=(int.Parse(Liuliang)/MC).ToString();
    Lbl=(Label)this.Page.FindControl("Month"+i.ToString());
    Lbl1=(Label)this.Page.FindControl("Month_tj_"+i.ToString());
    Lbl2=(Label)this.Page.FindControl("Image"+i.ToString());
    if(i==CurrentMonth)
     {
      Lbl.Text="<font color=#ff0000>"+i.ToString()+"月</font>";
      Lbl1.Text="<font color=#ff0000>"+Liuliang+"</font>";
      Lbl2.Text="<span style='display:block;width:18px;background-color:#ff0000;height:"+ImageHeight+"px'></span>";
     }
    else
     {
      Lbl.Text=i.ToString()+"月";
      Lbl1.Text=Liuliang;
      Lbl2.Text="<span style='display:block;width:18px;background-color:#00cc00;height:"+ImageHeight+"px'></span>";
     }
   }
  conn.Close();
 }

private void Day_Bound()
 {
  conn.Open();
  int CurrentYear=int.Parse(ViewState["CurrentYear"].ToString());
  int CurrentMonth=int.Parse(ViewState["CurrentMonth"].ToString());
  OleDbCommand Comm;
  OleDbDataReader Dr;
  string sql,Liuliang,ImageHeight;
  Label Lbl1,Lbl2,Lbl3;
  int CurrentDay=DateTime.Now.Day;
  int DC=int.Parse(D.Text);
  for(int i=1;i<=31;i++)
   {
    sql="select count(id) as co from pa_count where year([thedate])="+CurrentYear+" and month([thedate])="+CurrentMonth+" and day([thedate])="+i+" and isrobot=0 and site_id="+SiteId;
    Comm=new OleDbCommand(sql,conn);
    Dr=Comm.ExecuteReader(); 
    if(Dr.Read())
      {
      Liuliang=Dr["co"].ToString();
      }
    else
      {
       Liuliang="0";
      }
    ImageHeight=(int.Parse(Liuliang)/DC).ToString();
    Lbl1=(Label)this.Page.FindControl("Day_"+i.ToString());
    Lbl2=(Label)this.Page.FindControl("Day_Image"+i.ToString());
    Lbl3=(Label)this.Page.FindControl("Day_Count"+i.ToString());
    if(i==CurrentDay)
     {  Lbl1.Text="<font color=#ff0000>"+i.ToString()+"号</font>";
        Lbl2.Text="<span style='display:block;height:12px;background-color:#ff0000;width:"+ImageHeight+"px'></span>";
        Lbl3.Text="<font color=#ff0000>"+Liuliang+"</font>";
     }
   else
     {
        Lbl1.Text=i.ToString();
        Lbl2.Text="<span style='display:block;height:12px;background-color:#00cc00;width:"+ImageHeight+"px'></span>";
        Lbl3.Text=Liuliang;
     }

   }
  TheMonth.Text=CurrentYear.ToString()+"年"+CurrentMonth.ToString();
  conn.Close();
}

protected void Change_Year(Object src,EventArgs e)
 { 
   ViewState["CurrentYear"]=int.Parse(TheYear.SelectedItem.Text);
   ViewState["CurrentMonth"]=DateTime.Now.Month;
   PYear=ViewState["CurrentYear"].ToString();
   PMonth=ViewState["CurrentMonth"].ToString();
   Month_Bound();
   Day_Bound();
 }

protected void Change_Month(Object src,CommandEventArgs e)
 { 
   ViewState["CurrentYear"]=int.Parse(TheYear.SelectedItem.Text);
   ViewState["CurrentMonth"]=int.Parse(e.CommandName);
   PYear=ViewState["CurrentYear"].ToString();
   PMonth=ViewState["CurrentMonth"].ToString();
   TheMonth.Text=ViewState["CurrentYear"].ToString()+"年"+e.CommandName;
   Month_Bound();
   Day_Bound();
 }

protected void ShowIp(Object src,CommandEventArgs e)
{
 string theYear=ViewState["CurrentYear"].ToString();
 string theMonth=ViewState["CurrentMonth"].ToString();
 string theDay=e.CommandName;
 Response.Write("<script language=javascript>location.href='iplist.aspx?year="+theYear+"&month="+theMonth+"&day="+theDay+"';<"+"/script>");
 Response.End();
}

private void Data_Delete()
{
  conn.Open();
  string sql=(string)ViewState["del_sql"];
  OleDbCommand Comm=new OleDbCommand(sql,conn);
  Comm.ExecuteNonQuery();
  conn.Close();
}

private bool IsNum(string str)
 { 
  if(string.IsNullOrEmpty(str)){return false;}
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
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>流量统计</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top>
<form runat="server" id="form1">
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<!--------------------------------->
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
  <td  colspan=2 height=25 align=center><b><asp:DropDownList id="TheYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Change_Year"/> 年月流量统计表</b></td>
 </tr>
</table>

<table border="0px" cellpadding=0 cellspacing="0" width=95% align=center class="tablestyle">
<tr>
  <td class="tdstyle"  height=25 align=center>月访问量</td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_1" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_2" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_3" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_4" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_5" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_6" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_7" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_8" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_9" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_10" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_11" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month_tj_12" runat="server" /></td>
 </tr>

<tr>
  <td class="tdstyle"  height=100 align=center>图表</td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image1" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image2" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image3" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image4" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image5" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image6" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image7" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image8" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image9" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image10" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image11" runat="server" /></td>
  <td class="tdstyle" valign=bottom align=center><asp:Label id="Image12" runat="server" /></td>
 </tr>
<tr>
  <td class="tdstyle"  height=25 align=center>月份</td>
  <td class="tdstyle" align=center><asp:Label id="Month1" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month2" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month3" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month4" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month5" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month6" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month7" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month8" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month9" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month10" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month11" runat="server" /></td>
  <td class="tdstyle" align=center><asp:Label id="Month12" runat="server" /></td>
 </tr>
<tr>
  <td class="tdstyle"  height=25 align=center>查看</td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="1" OnCommand="Change_Month" /></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="2" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="3" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="4" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="5" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="6" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="7" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="8" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="9" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="10" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="11" OnCommand="Change_Month"/></td>
  <td class="tdstyle" align=center><asp:LinkButton Text="查看" runat="server" CommandName="12" OnCommand="Change_Month"/></td>
 </tr>
<tr>
  <td class="tdstyle"  height=25 align=center>清除</td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=1'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=2'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=3'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=4'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=5'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=6'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=7'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=8'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=9'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=10'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=11'};"></td>
  <td class="tdstyle" align=center><input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delmonth&year=<%=PYear%>&month=12'};"></td>
 </tr>
</table>
<br>
<!--------------------------------->
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
  <td  colspan=2 height=25 align=center><b><asp:Label id="TheMonth" runat="server"/>月日流量统计表</b></td>
 </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center class="tablestyle" id="tb_list">
<tr>
  <td  class="tdstyle"  height=25 align=center width=5%>日</td>
  <td  class="tdstyle"  height=25 align=center width=60%>图表</td>
  <td  class="tdstyle"  height=25 align=center width=10%>日访问量</td>
  <td  class="tdstyle"  height=25 align=center width=25%>操作</td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle" height=25 align=center width=5%><asp:Label id="Day_1" runat="server" /></td>
  <td class="tdstyle" height=25  align=left width=60%><asp:Label id="Day_Image1" runat="server" /></td>
  <td class="tdstyle" height=25 align=center width=10%><asp:Label id="Day_Count1" runat="server" /></td>
  <td class="tdstyle" height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="1" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=1'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_2" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image2" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count2" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="2" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=2'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_3" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image3" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count3" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="3" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=3'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_4" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image4" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count4" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="4" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=4'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_5" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image5" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count5" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="5" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=5'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_6" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image6" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count6" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="6" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=6'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_7" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image7" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count7" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="7" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=7'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_8" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image8" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count8" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="8" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=8'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_9" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image9" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count9" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="9" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=9'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_10" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image10" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count10" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="10" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=10'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_11" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image11" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count11" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="11" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=11'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_12" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image12" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count12" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="12" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=12'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_13" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image13" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count13" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="13" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=13'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_14" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image14" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count14" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="14" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=14'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_15" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image15" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count15" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="15" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=15'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_16" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image16" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count16" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="16" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=16'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_17" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image17" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count17" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="17" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=17'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_18" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image18" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count18" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="18" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=18'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_19" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image19" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count19" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="19" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=19'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_20" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image20" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count20" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="20" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=20'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_21" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image21" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count21" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="21" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=21'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_22" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image22" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count22" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="22" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=22'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_23" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image23" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count23" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="23" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=23'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_24" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image24" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count24" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="24" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=24'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_25" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image25" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count25" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="25" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=25'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_26" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image26" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count26" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="26" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=26'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_27" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image27" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count27" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="27" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=27'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_28" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image28" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count28" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="28" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=28'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_29" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image29" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count29" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="29" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=29'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_30" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image30" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count30" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="30" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=30'};"></td>
 </tr>
 <tr class="listitem">
  <td class="tdstyle"  height=25 align=center width=5%><asp:Label id="Day_31" runat="server" /></td>
  <td class="tdstyle"  height=25  align=left width=60%><asp:Label id="Day_Image31" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=10%><asp:Label id="Day_Count31" runat="server" /></td>
  <td class="tdstyle"  height=25 align=center width=25%><asp:Button Text="查看" runat="server" CssClass="button" CommandName="31" OnCommand="ShowIp"/>&nbsp;&nbsp;<input type="Button" Value="清除" class="button" onclick="if(confirm('确定删除吗')){location.href='tongji.aspx?act=delday&year=<%=PYear%>&month=<%=PMonth%>&day=31'};"></td>
 </tr>
</table>

<br>
</td>
 </tr>
</table>
<asp:Label id="M" Text="500" Runat="server" visible="false"/><asp:Label id="D" Text="10" Runat="server" visible="false"/>
</form>
</td>
</tr>
</table>
</center><br>
<script type="text/javascript">
MouseoverColor("tb_list");
</script>
</body>
</html>  