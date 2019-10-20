<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 OleDbConnection conn;
 int SiteId,PageSize,PageCount,RecordCount,CurrentPage;
protected void Page_Load(Object src,EventArgs e)
 {
  PageSize=25;
  Conn Myconn=new Conn();
  conn=Myconn.OleDbConn();//获取OleDbConnection
  if(!Page.IsPostBack) 
   {
       Master_Valicate YZ=new Master_Valicate();
       YZ.Master_Check();
       SiteId=int.Parse(Request.Cookies["SiteId"].Value);
       ViewState["CurrentPage"]=0;
    //绑定数据====================================
     if(Request.QueryString["month"]==null ||Request.QueryString["day"]==null)
       {
        Response.Redirect("tongji.aspx");
       }  
    else
       {
         if(IsNum(Request.QueryString["year"]) && IsNum(Request.QueryString["month"]) && IsNum(Request.QueryString["day"]) )
            {
             int CurrentYear=int.Parse(Request.QueryString["year"]);
             int CurrentMonth=int.Parse(Request.QueryString["month"]);
             int CurrentDay=int.Parse(Request.QueryString["day"]);
             string from="",sql_str="";
             if(Request.QueryString["from"]!=null)
              {
                from=Request.QueryString["from"];
              }
             if(from!="")
              {
               if(IsNum(from.Replace(".","")))
               {
                sql_str=" and ip like '%"+from+"%' ";
               }
               else
               {
                 sql_str=" and urlfrom like '%"+from+"%' ";
               }
              }
             ViewState["sql"]="select id from pa_count where year([thedate])="+CurrentYear+" and month([thedate])="+CurrentMonth+" and day([thedate])="+CurrentDay+" and isrobot=0 and site_id="+SiteId+sql_str+" order by id desc";
             ViewState["sql_tj"]="select count(id) as co from pa_count  where year([thedate])="+CurrentYear+" and month([thedate])="+CurrentMonth+" and day([thedate])="+CurrentDay+" and isrobot=0 and site_id="+SiteId+sql_str;
             conn.Open();
              Tongji();
              Data_Bind();
             conn.Close();
             TheDate.Text=CurrentYear.ToString()+"年"+CurrentMonth.ToString()+"月"+CurrentDay.ToString()+"日";
           }
       }  

   }

 }


private ICollection CreateTable()
 {
  CurrentPage=(int)ViewState["CurrentPage"];
  DLpage.SelectedIndex=DLpage.Items.IndexOf(DLpage.Items.FindByValue(CurrentPage.ToString()));
  Lblcurrentpage.Text=(CurrentPage+1).ToString();
  int StartIndex=CurrentPage*PageSize;
  string sql=(string)ViewState["sql"];
  DataSet ds=new DataSet();
  OleDbDataAdapter myAdapte=new OleDbDataAdapter(sql,conn);
  myAdapte.Fill(ds,StartIndex,PageSize,"default");
  ds=Optimize_DataSet(ds,"pa_count","id desc");
  return ds.Tables["default"].DefaultView;
 }

private DataSet Optimize_DataSet(DataSet SourceDs,string Table,string Order)
 {
   int RCount=SourceDs.Tables["default"].Rows.Count;
   string Ids="0";
   if(RCount>0)
    {
      DataRow dr;
      for(int i=0;i<RCount;i++)
       {
         dr=SourceDs.Tables["default"].Rows[i];
         Ids+=","+dr["id"].ToString();
       }
    }
   SourceDs.Clear();
   string sql="select * from "+Table+" where id in("+Ids+") order by "+Order;
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(SourceDs,"default");
   return SourceDs;
 }

private  void Data_Bind()
 {
  CurrentPage=(int)ViewState["CurrentPage"];
  PageCount=(int)ViewState["PageCount"];
//控制linkbutton==============

     Prev.Enabled=true;
     Next.Enabled=true;

     if(CurrentPage>=PageCount-1)
      {
        Next.Enabled=false;
      }

     if(CurrentPage<=0)
      {
       Prev.Enabled=false;
      }
//控制linkbutton==============

  Dlist1.DataSource=CreateTable();
  Dlist1.DataBind();
 }

private  void Tongji()
 {
  string sql=(string)ViewState["sql_tj"];
  OleDbCommand Comm=new OleDbCommand (sql,conn);
  OleDbDataReader dr=Comm.ExecuteReader();
  if(dr.Read())
   {
    RecordCount=int.Parse(dr["co"].ToString());
   }
  else
   {
    RecordCount=0;
   }
  dr.Close();
  Lblrecordcount.Text=RecordCount.ToString();
//计算总页数
  if(RecordCount%PageSize==0)
    {
     PageCount=RecordCount/PageSize;
    }
  else
    {
     PageCount=RecordCount/PageSize+1;
    }
  ViewState["PageCount"]=PageCount;
//填充下拉页
    DLpage.Items.Clear();
   for(int i=0;i<PageCount;i++)
    {
    DLpage.Items.Add(new ListItem((i+1).ToString(),i.ToString()));
    }
  LblpageCount.Text=PageCount.ToString();
 }


protected void Bt_Click(Object sender,CommandEventArgs e)
 {
   string CName=e.CommandName;
   switch(CName)
    {
      case "Prev":
       if((int)ViewState["CurrentPage"]>0)
        {
          ViewState["CurrentPage"]=(int)ViewState["CurrentPage"]-1;
        }
      break;

     case "Next":
       if((int)ViewState["CurrentPage"]<(int)ViewState["PageCount"]-1)
        {
          ViewState["CurrentPage"]=(int)ViewState["CurrentPage"]+1;
        }
     break;
    }
     conn.Open();
      Data_Bind();
     conn.Close();

 }

protected void Page_Changed(Object sender,EventArgs e)
 {
     int CurrentPage=int.Parse(DLpage.SelectedItem.Value);
     ViewState["CurrentPage"]=CurrentPage;
     conn.Open();
      Data_Bind();
     conn.Close();
 }

protected void Data_Delete(Object src,CommandEventArgs e)
 {
   conn.Open();
   int Id=int.Parse(e.CommandName);
   string sql="delete from pa_count where id="+Id;
   OleDbCommand Comm=new OleDbCommand (sql,conn); 
   Comm.ExecuteNonQuery();
   conn.Close();

   conn.Open();
    Tongji();
    Data_Bind();
   conn.Close();
 }

protected void Data_Bind(Object src,RepeaterItemEventArgs e)
 {
  if(e.Item.ItemType==ListItemType.Item  ||  e.Item.ItemType==ListItemType.AlternatingItem)
    {
     Button Lbt=(Button)e.Item.FindControl("Delete");
     Lbt.Attributes.Add("onclick","return confirm('确定删除吗？');");
    }

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
<aspcn:uc_head runat="server" />
<style Type="text/css">
.button1{
	height:23px;
	width:120px;
        font-weight:normal;
        color:#222222;
        background-color:white;
        border-top: 0 outset #333333;
	border-right: 0 outset #333333;
	border-bottom:0 outset #333333;
	border-left: 0 outset #333333;
        cursor:hand;
       }
</style>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1 align="left"><b>流量明细</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top>
<form runat="server" id="form1">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="Go_Tab('')">所有来路</li>
<li id="tab" name="tab" onclick="Go_Tab('www.baidu.com')">百度</li>
<li id="tab" name="tab" onclick="Go_Tab('www.so.com')">360搜索</li>
<li id="tab" name="tab" onclick="Go_Tab('www.sogou.com')">搜狗</li>
<li id="tab" name="tab" onclick="Go_Tab('google.com')">google</li>
<li id="tab" name="tab" onclick="Go_Tab('soso.com')">搜搜</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25 align="left"><b><asp:Label id="TheDate" runat="server"/></b></td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=95% align=center class="tablestyle" id="tb_list">
 <tr>
  <td width=12% class="white" height=25 align=center>IP</td>
  <td width=55% class="white" align=center>访问来路</td>
  <td width=8% class="white" align=center>时间</td>
  <td width=7% class="white" align=center>浏览器</td>
  <td width=8% class="white" align=center>系统</td>
  <td width=10% class="white" align=center>操作</td>
 </tr>
<asp:Repeater id="Dlist1"  runat="server"  OnItemDataBound="Data_Bind">
<ItemTemplate>
 <tr class="listitem">
  <td  class="tdstyle" height=25 align="center"><a href="javascript:GetIPAdd('<%#DataBinder.Eval(Container.DataItem,"ip")%>')"><%#DataBinder.Eval(Container.DataItem,"ip")%></a></td>
  <td  class="tdstyle" align="left"><a href="<%#DataBinder.Eval(Container.DataItem,"urlfrom")%>" target="search_source"><%#DataBinder.Eval(Container.DataItem,"urlfrom")%></a></td>
  <td  class="tdstyle"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:HH:mm}")%></td>
  <td  class="tdstyle"><%#DataBinder.Eval(Container.DataItem,"browser")%></td>
  <td  class="tdstyle"><%#DataBinder.Eval(Container.DataItem,"platform")%></td>
  <td  class="tdstyle" align=center><asp:Button id="Delete" Text="删除" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' onCommand="Data_Delete" Cssclass="button" runat="server"/></td>
 </tr>
</ItemTemplate>
</asp:Repeater>
</table>
<br>
</td>
 </tr>
</table>
<br>
<table border=0 cellpadding=0 cellspacing=1 width=100% align=center>
 <tr>
  <td width=30%  height=25 align=left><input type="text" size="15" id="kw_from" value="<%=Request.QueryString["from"]%>">
<input type="button" value="搜索" class="button" onclick="Go_Tab(document.getElementById('kw_from').value)">
 </td>
  <td width=80%  height=25 align=right>
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="Prev" cssclass=button runat="server" CommandName="Prev"  OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="Next" cssclass=button  runat="server" CommandName="Next"  OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;
 <input type="button" value="返回" class="button" onclick="location.href='tongji.aspx?year=<%=Request.QueryString["year"]%>&month=<%=Request.QueryString["month"]%>'">
 </td>

 </tr>
 </table>
</form>
</td>
</tr>
</table>
<script language="javascript">
MouseoverColor("tb_list");
function GO_Url(TheValue)
 {
    if(TheValue.indexOf("http://")==0)
     {
     window.open(TheValue,"urlfrom");
    }
 }

function Go_Tab(kw)
 {
  var Url="iplist.aspx?year=<%=Request.QueryString["year"]%>&month=<%=Request.QueryString["month"]%>&day=<%=Request.QueryString["day"]%>&from="+encodeURI(kw);
  location.href=Url;
 }

var C_Tab="<%=Request.QueryString["from"]%>";
var obj=document.getElementsByName("tab");
switch(C_Tab)
 {
   case "www.baidu.com":
    obj[1].style.fontWeight="bold";
   break;

   case "www.so.com":
    obj[2].style.fontWeight="bold";
   break;

   case "www.sogou.com":
    obj[3].style.fontWeight="bold";
   break;

   case "google.com":
    obj[4].style.fontWeight="bold";
   break;

   case "soso.com":
    obj[5].style.fontWeight="bold";
   break;

  default:
    obj[0].style.fontWeight="bold";
   break;
 }
</script>
</center>
</body>
</html>

